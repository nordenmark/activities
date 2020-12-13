import { Model, Column, Table, columnTypes } from 'nestjs-objection';

@Table({ tableName: 'workouts' })
export class WorkoutModel extends Model {
  @Column({ type: columnTypes.increments })
  id: number;

  @Column({ type: columnTypes.string })
  activity: string;

  @Column({ type: columnTypes.date })
  date: Date;

  @Column({ type: columnTypes.integer })
  userId: number;
}
