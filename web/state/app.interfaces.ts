export interface User {
  email: string;
  id: number;
  name: string;
}

export interface AppState {
  user: null | User;
  accessToken: null | string;
  refreshToken: null | string;
  accessTokenExpiresAt: null | number;
  refreshTokenExpiresAt: null | number;
}
