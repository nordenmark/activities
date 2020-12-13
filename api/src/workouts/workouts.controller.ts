import { User } from '#app/auth/auth.interfaces';
import { JwtAuthGuard } from '#app/auth/jwt-auth.guard';
import { AuthedUser } from '#app/auth/user.decorator';
import { Body, Controller, Delete, Get, Post, UseGuards } from '@nestjs/common';
import { existsSync, writeFileSync } from 'fs';
import { resolve } from 'path';
import { CreateWorkoutDto } from './workouts.dto';
import { WorkoutsService } from './workouts.service';

@Controller('workouts')
@UseGuards(JwtAuthGuard)
export class WorkoutsController {
  constructor(private readonly workoutsService: WorkoutsService) {}

  @Get()
  getWorkouts(@AuthedUser() user: User) {
    return this.workoutsService.getForUser(user.id);
  }

  @Post()
  createWorkout(
    @AuthedUser() user: User,
    @Body() { date, activity }: CreateWorkoutDto,
  ) {
    return this.workoutsService.create(user.id, date, activity);
  }

  @Get('/:id')
  getWorkout() {
    return {};
  }

  @Delete('/:id')
  deleteWorkout() {
    return true;
  }

  @Post('/import')
  import(@Body() body: any[]) {
    console.log(body, 'body');

    const path = resolve('lucile.json');
    if (existsSync(path)) {
      writeFileSync(path, JSON.stringify(body));
    }

    console.log('wrote', body.length, 'entries to', path);

    return body;
  }
}
