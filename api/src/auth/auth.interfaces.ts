import { Request } from 'express';

export interface JwtPayload {
  user: {
    id: number;
    name: string;
    email: string;
  };
}

export type User = JwtPayload['user'];

export interface AuthRequest extends Request {
  user: User;
}

export interface LoginResponse {
  accessToken: string;
  refreshToken: string;
  accessTokenExpiresIn: number;
  refreshTokenExpiresIn: number;
  user: User;
}
