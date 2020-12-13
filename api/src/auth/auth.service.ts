import { UsersService } from '#app/users/users.service';
import { Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { JwtPayload, LoginResponse } from './auth.interfaces';
import { compare } from 'bcrypt';

@Injectable()
export class AuthService {
  private EXPIRES_IN_ACCESS_TOKEN = 30 * 60; // 30 minutes
  private EXPIRES_IN_REFRESH_TOKEN = 60 * 60 * 24 * 14; // 14 days

  constructor(
    private usersService: UsersService,
    private jwtService: JwtService,
  ) {}

  async login(email: string, password: string): Promise<LoginResponse> {
    const user = await this.usersService.findOneByEmail(email);

    if (!user) {
      return null;
    }

    const isPasswordValid = await this.isPasswordValid(user.password, password);

    if (!isPasswordValid) {
      return null;
    }

    const payload: JwtPayload = {
      user: {
        id: user.id,
        name: user.name,
        email: user.email,
      },
    };

    return {
      accessToken: this.createToken(payload, this.EXPIRES_IN_ACCESS_TOKEN),
      refreshToken: this.createToken(payload, this.EXPIRES_IN_REFRESH_TOKEN),
      accessTokenExpiresIn: this.EXPIRES_IN_ACCESS_TOKEN,
      refreshTokenExpiresIn: this.EXPIRES_IN_REFRESH_TOKEN,
      user,
    };
  }

  async refresh(refreshToken: string): Promise<LoginResponse> {
    const decodedToken = this.jwtService.verify<JwtPayload>(refreshToken);

    const user = await this.usersService.findOneById(decodedToken.user.id);

    if (!user) {
      return null;
    }

    const payload: JwtPayload = {
      user: {
        id: user.id,
        name: user.name,
        email: user.email,
      },
    };

    return {
      accessToken: this.createToken(payload, this.EXPIRES_IN_ACCESS_TOKEN),
      refreshToken: this.createToken(payload, this.EXPIRES_IN_REFRESH_TOKEN),
      accessTokenExpiresIn: this.EXPIRES_IN_ACCESS_TOKEN,
      refreshTokenExpiresIn: this.EXPIRES_IN_REFRESH_TOKEN,
      user,
    };
  }

  private createToken(payload: JwtPayload, expiresIn: number | string): string {
    return this.jwtService.sign(payload, {
      expiresIn,
    });
  }

  private isPasswordValid(
    currentPasswordHash: string,
    passwordToTest: string,
  ): Promise<boolean> {
    return compare(passwordToTest, currentPasswordHash);
  }
}
