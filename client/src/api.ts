import axios, { AxiosRequestConfig } from 'axios';
import { useRecoilValue, useResetRecoilState, useSetRecoilState } from 'recoil';
import { authState, userState } from './state';

const API_URL = process.env.REACT_APP_API_URL;

export interface LoginPayload {
  email: string;
  password: string;
}

export interface LoginResponse {
  accessToken: string;
  refreshToken: string;
  accessTokenExpiresIn: number;
  refreshTokenExpiresIn: number;
  user: {
    id: number;
    name: string;
    email: string;
  };
}

type RefreshResponse = LoginResponse;

export interface Workout {
  id: string;
  activity: string;
  date: string;
  userId: number;
}

export type WorkoutsResponse = Workout[];

export const useApiClient = () => {
  const auth = useRecoilValue(authState);
  const resetAuthState = useResetRecoilState(authState);
  const resetUserState = useResetRecoilState(userState);
  const setAuthState = useSetRecoilState(authState);
  const setUserState = useSetRecoilState(userState);

  const axiosInstance = axios.create({
    baseURL: API_URL,
    headers: {
      Authorization: `Bearer ${auth?.accessToken}`,
    },
  });

  axiosInstance.interceptors.request.use(
    async (config: AxiosRequestConfig): Promise<AxiosRequestConfig> => {
      if (!auth || config.url?.includes('/auth/')) {
        return config;
      }

      const isExpired = Date.now() >= auth.accessTokenExpiresAt;

      if (!isExpired) {
        return config;
      }

      try {
        const response = await refresh(auth.refreshToken);

        setAuthState({
          isLoading: false,
          isLoggedIn: true,
          accessToken: response.accessToken,
          accessTokenExpiresAt:
            Date.now() + response.accessTokenExpiresIn * 1000,
          refreshToken: response.refreshToken,
        });
        setUserState(response.user);

        config.headers = {
          ...config.headers,
          Authorization: `Bearer ${response.accessToken}`,
        };
      } catch {
        // Failed to refresh, we can do nothing but log out now
        resetAuthState();
        resetUserState();
      }

      return config;
    }
  );

  const login = async ({
    email,
    password,
  }: LoginPayload): Promise<LoginResponse> => {
    return axiosInstance
      .post<LoginResponse>(`/auth/login`, { email, password })
      .then(({ data }) => data);
  };

  const refresh = async (refreshToken: string): Promise<RefreshResponse> => {
    return axiosInstance
      .post<RefreshResponse>(`/auth/refresh`, { refreshToken })
      .then(({ data }) => data);
  };

  const workouts = async (): Promise<Workout[]> => {
    return axiosInstance
      .get<WorkoutsResponse>(`/workouts`)
      .then(({ data }) => data);
  };

  return { login, refresh, workouts };
};
