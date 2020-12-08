import { createParamDecorator, ExecutionContext } from '@nestjs/common';
import { AuthRequest } from './auth.interfaces';

export const AuthedUser = createParamDecorator(
  (data: unknown, ctx: ExecutionContext) => {
    const request = ctx.switchToHttp().getRequest<AuthRequest>();
    return request.user;
  },
);
