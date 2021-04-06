import axios, { AxiosError, AxiosInstance, AxiosRequestConfig } from 'axios';
import { AppState } from '../state/app.interfaces';
import { StorageService } from './storage';

const API_URL =
  process.env.NODE_ENV === 'production'
    ? 'https://activities-rjm7jeatiq-ew.a.run.app'
    : 'http://localhost:8888';

export interface LoginResponse {
  accessToken: string;
  accessTokenExpiresIn: number;
  refreshToken: string;
  refreshTokenExpiresIn: number;
  user: {
    email: string;
    id: number;
    name: string;
  };
}

export interface WorkoutModel {
  activity: string;
  date: Date;
  id: number;
  userId: number;
}

class ApiService {
  private axios: AxiosInstance;

  constructor() {
    this.axios = axios.create({
      baseURL: API_URL,
    });

    this.axios.interceptors.request.use(
      async (config: AxiosRequestConfig) => {
        if (
          config.url.includes('/auth/login') ||
          config.url.includes('/auth/refresh')
        ) {
          return config;
        }

        const state = StorageService.getState();

        if (state.accessToken) {
          console.log(
            'token used',
            state.accessToken.substring(state.accessToken.length - 10),
          );
          // Make sure it is still valid
          if (Date.now() < state.accessTokenExpiresAt) {
            config.headers['Authorization'] = `Bearer ${state.accessToken}`;
          } else {
            console.log(
              'accessToken no longer valid expired at',
              state.accessTokenExpiresAt,
            );
          }
        }

        if (state.refreshToken) {
          // Make sure it is still valid
          if (state.refreshTokenExpiresAt < Date.now()) {
            const response = await this.refresh(state.refreshToken);

            config.headers['Authorization'] = `Bearer ${response.accessToken}`;

            const updatesState: AppState = {
              user: response.user,
              accessToken: response.accessToken,
              refreshToken: response.refreshToken,
              accessTokenExpiresAt: Date.now() + response.accessTokenExpiresIn,
              refreshTokenExpiresAt:
                Date.now() + response.refreshTokenExpiresIn,
            };

            StorageService.setState(updatesState);
          }
        }

        return config;
      },
      (error: AxiosError) => {
        return Promise.reject(error);
      },
    );

    this.axios.interceptors.response.use(
      function (response) {
        // Any status code that lie within the range of 2xx cause this function to trigger
        // Do something with response data
        return response;
      },
      async function (error: AxiosError) {
        const { config: originalReq, response } = error;

        // skip refresh token request, retry attempts to avoid infinite loops
        if (
          !originalReq.url.includes('/auth/refresh') &&
          !originalReq.url.includes('/auth/login') &&
          // @ts-ignore
          !originalReq.isRetryAttempt &&
          response &&
          response.status === 401
        ) {
          try {
            const state = StorageService.getState();
            const response = await this.refresh(state.refreshToken);
            originalReq.headers[
              'Authorization'
            ] = `Bearer ${response.accessToken}`;
            // @ts-ignore
            originalReq.isRetryAttempt = true;
            return await this.axios.request(originalReq);
          } catch {
            StorageService.clear();
          }
        } else {
          return Promise.reject(error);
        }

        console.log('error!', error.code, error);

        if (error.response && error.response.status === 401) {
          console.log('UH-OH 401!');
        }
        // Any status codes that falls outside the range of 2xx cause this function to trigger
        // Do something with response error
        return Promise.reject(error);
      },
    );
  }

  login = async (email: string, password: string): Promise<LoginResponse> => {
    return this.axios
      .post<LoginResponse>(`/auth/login`, {
        email,
        password,
      })
      .then((response) => response.data);
  };

  refresh = async (refreshToken: string): Promise<LoginResponse> => {
    return this.axios
      .post<LoginResponse>(`/auth/refresh`, { refreshToken })
      .then((response) => response.data);
  };

  getWorkouts = async () => {
    return this.axios.get<WorkoutModel[]>('/workouts').then((response) =>
      response.data.map((workout) => ({
        ...workout,
        date: new Date(workout.date),
      })),
    );
  };

  createWorkout = async (date: Date, activity: string) => {
    return this.axios.post('/workouts', { date, activity }).then((response) => {
      console.log(response);
      return response.data;
    });
  };
}

const apiService = new ApiService();

export default apiService;
