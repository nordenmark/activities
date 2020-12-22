import { User } from '#app/auth/auth.interfaces';
import { JwtAuthGuard } from '#app/auth/jwt-auth.guard';
import { AuthedUser } from '#app/auth/user.decorator';
import { Controller, Get, UseGuards } from '@nestjs/common';
import { ChallengesService } from './challenges.service';

@Controller('challenges')
@UseGuards(JwtAuthGuard)
export class ChallengesController {
  constructor(private readonly challengesService: ChallengesService) {}

  @Get()
  getChallenges(@AuthedUser() user: User) {
    return this.challengesService.getForUser(user.id);
  }
}
