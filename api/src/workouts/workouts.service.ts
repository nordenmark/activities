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

  async create(
    userId: number,
    date: string,
    activity: string,
  ): Promise<WorkoutModel> {
    return this.workoutModel.query().insert({
      userId,
      date: new Date(date),
      activity,
    });
  }

  async getForUser(id: number): Promise<WorkoutModel[]> {
    return this.workoutModel
      .query()
      .where({ userId: id })
      .orderBy('date', 'desc');
  }

  async getForUsers(userIds: number[]): Promise<WorkoutModel[]> {
    return this.workoutModel
      .query()
      .whereIn('userId', userIds)
      .orderBy('date', 'desc');
  }

  async delete(id: number): Promise<boolean> {
    return this.workoutModel
      .query()
      .deleteById(id)
      .then(() => true);
  }

  async update(
    id: number,
    date: string,
    activity: string,
  ): Promise<WorkoutModel> {
    return this.workoutModel
      .query()
      .updateAndFetchById(id, { date: new Date(date), activity });
  }
}
