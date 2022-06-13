import { atom, AtomEffect, DefaultValue, selector } from 'recoil';

const LOCAL_STORAGE_AUTH_STATE = 'workouts-auth';
const LOCAL_STORAGE_USER_STATE = 'workouts-user';

interface AuthState {
  isLoggedIn: boolean;
  isLoading: boolean;
  accessToken: string;
  accessTokenExpiresAt: number;
  refreshToken: string;
}

interface UserState {
  id: number;
  name: string;
  email: string;
}

const localStorageEffect: <T>(key: string) => AtomEffect<T> =
  (key: string) =>
  ({ setSelf, onSet }) => {
    const savedValue = localStorage.getItem(key);
    if (savedValue != null) {
      setSelf(JSON.parse(savedValue));
    }

    onSet(newValue => {
      if (newValue instanceof DefaultValue) {
        localStorage.removeItem(key);
      } else {
        localStorage.setItem(key, JSON.stringify(newValue));
      }
    });
  };

export const authState = atom({
  key: '[AUTH]',
  default: null,
  effects_UNSTABLE: [
    localStorageEffect<AuthState | null>(LOCAL_STORAGE_AUTH_STATE),
  ],
});

export const authIsLoggedIn = selector({
  key: '[AUTH] is logged in',
  get: ({ get }) => {
    return get(authState)?.isLoggedIn ?? false;
  },
});

export const userState = atom({
  key: '[USER]',
  default: null,
  effects_UNSTABLE: [
    localStorageEffect<UserState | null>(LOCAL_STORAGE_USER_STATE),
  ],
});
