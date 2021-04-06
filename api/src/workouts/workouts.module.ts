import { DatabaseModule } from '#app/database/database.module';
import { FriendsModule } from '#app/friends/friends.module';
import { WorkoutModel } from '#app/models/workout.model';
import { Module } from '@nestjs/common';
import { ObjectionModule } from 'nestjs-objection/dist';
import { WorkoutsController } from './workouts.controller';
import { WorkoutsService } from './workouts.service';

@Module({
  imports: [
    DatabaseModule,
    ObjectionModule.forFeature([WorkoutModel]),
    FriendsModule,
  ],
  controllers: [WorkoutsController],
  providers: [WorkoutsService],
})
export class WorkoutsModule {}
