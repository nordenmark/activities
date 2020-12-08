import { DatabaseModule } from '#app/database/database.module';
import { WorkoutModel } from '#app/models/workout.model';
import { Module } from '@nestjs/common';
import { ObjectionModule } from 'nestjs-objection/dist';
import { WorkoutsController } from './workouts.controller';
import { WorkoutsService } from './workouts.service';

@Module({
  imports: [DatabaseModule, ObjectionModule.forFeature([WorkoutModel])],
  controllers: [WorkoutsController],
  providers: [WorkoutsService],
})
export class WorkoutsModule {}
