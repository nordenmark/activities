import {
  BadRequestException,
  Body,
  Controller,
  Post,
  UnauthorizedException,
} from '@nestjs/common';
import { LoginDto, RefreshDto } from './auth.dto';
import { LoginResponse } from './auth.interfaces';
import { AuthService } from './auth.service';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('/login')
  async login(@Body() { email, password }: LoginDto): Promise<LoginResponse> {
    const response = await this.authService.login(email, password);

    if (!response) {
      throw new BadRequestException('Invalid email and/or password');
    }

    return response;
  }

  @Post('/refresh')
  async refresh(@Body() { refreshToken }: RefreshDto): Promise<LoginResponse> {
    const response = await this.authService.refresh(refreshToken).catch(() => {
      throw new UnauthorizedException('Invalid refreshToken');
    });

    if (!response) {
      throw new UnauthorizedException('Invalid refreshToken');
    }

    return response;
  }
}
