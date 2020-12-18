import { User } from '#app/auth/auth.interfaces';
import { JwtAuthGuard } from '#app/auth/jwt-auth.guard';
import { AuthedUser } from '#app/auth/user.decorator';
import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Put,
  UseGuards,
} from '@nestjs/common';
import { CreateWorkoutDto, UpdateWorkoutDto } from './workouts.dto';
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

  @Put('/:id')
  updateWorkout(
    @Param('id') id: number,
    @Body() { date, activity }: UpdateWorkoutDto,
  ) {
    return this.workoutsService.update(id, date, activity);
  }

  @Get('/:id')
  getWorkout() {
    return {};
  }

  @Delete('/:id')
  deleteWorkout(@Param('id') id: number) {
    return this.workoutsService.delete(id);
  }
}
