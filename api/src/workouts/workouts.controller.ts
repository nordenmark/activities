import { User } from '#app/auth/auth.interfaces';
import { JwtAuthGuard } from '#app/auth/jwt-auth.guard';
import { AuthedUser } from '#app/auth/user.decorator';
import { Body, Controller, Delete, Get, Post, UseGuards } from '@nestjs/common';
import { existsSync, writeFileSync } from 'fs';
import { resolve } from 'path';
import { WorkoutsService } from './workouts.service';

@Controller('workouts')
@UseGuards(JwtAuthGuard)
export class WorkoutsController {
  constructor(private readonly workoutsService: WorkoutsService) {}

  @Get()
  getWorkouts(@AuthedUser() user: User) {
    console.log('getting workouts for user', user.email);
    return this.workoutsService.getForUser(user.id);
  }

  @Post()
  createWorkout() {
    return {};
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
