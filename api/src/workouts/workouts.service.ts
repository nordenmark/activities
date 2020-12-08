import { WorkoutModel } from '#app/models/workout.model';
import { Injectable } from '@nestjs/common';
import { InjectModel } from 'nestjs-objection';

@Injectable()
export class WorkoutsService {
  constructor(
    @InjectModel(WorkoutModel)
    private readonly workoutModel: typeof WorkoutModel,
  ) {}

  async getAll() {
    return this.workoutModel.query();
  }

  async getForUser(id: number): Promise<WorkoutModel[]> {
    return this.workoutModel.query().where({ userId: id });
  }
}
