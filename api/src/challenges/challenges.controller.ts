import { User } from '#app/auth/auth.interfaces';
import { JwtAuthGuard } from '#app/auth/jwt-auth.guard';
import { AuthedUser } from '#app/auth/user.decorator';
import {
  Body,
  Controller,
  Get,
  NotFoundException,
  Param,
  Post,
  UseGuards,
} from '@nestjs/common';
import {
  CreateChallengeDto,
  ToggleChallengeProgressDto,
} from './challenges.dto';
import { ChallengesService } from './challenges.service';

@Controller('challenges')
@UseGuards(JwtAuthGuard)
export class ChallengesController {
  constructor(private readonly challengesService: ChallengesService) {}

  @Get()
  getChallenges(@AuthedUser() user: User) {
    return this.challengesService.getForUser(user.id);
  }

  @Post()
  createChallenge(
    @AuthedUser() user: User,
    @Body() { name, fromDate, toDate, type }: CreateChallengeDto,
  ) {
    return this.challengesService.create(user.id, name, fromDate, toDate, type);
  }

  @Post('/:id/toggle-progress')
  async toggleProgress(
    @AuthedUser() user: User,
    @Param('id') id: number,
    @Body() { completed, date }: ToggleChallengeProgressDto,
  ) {
    const challenge = await this.challengesService.getById(id);

    if (!challenge) {
      throw new NotFoundException(`Challenge with id ${id} not found`);
    }

    return this.challengesService.toggleProgress(
      user.id,
      challenge.id,
      date,
      completed,
    );
  }
}
