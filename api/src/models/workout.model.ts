import {
  Model,
  Column,
  Table,
  columnTypes,
  QueryBuilder,
} from 'nestjs-objection';

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

  static modifiers = {
    filterThisYear(query: QueryBuilder<WorkoutModel>) {
      query.whereRaw(`EXTRACT(YEAR FROM date) = ${new Date().getFullYear()}`);
    },
  };
}
