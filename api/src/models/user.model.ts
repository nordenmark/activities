import {
  Model,
  Column,
  Table,
  columnTypes,
  Relation,
  relationTypes,
} from 'nestjs-objection';
import { WorkoutModel } from './workout.model';

@Table({ tableName: 'users' })
export class UserModel extends Model {
  @Column({ type: columnTypes.increments })
  id: number;

  @Column({ type: columnTypes.string })
  name: string;

  @Column({ type: columnTypes.string })
  email: string;

  @Column({ type: columnTypes.string })
  password: string;

  @Relation({
    modelClass: WorkoutModel,
    relation: relationTypes.HasManyRelation,
    join: { from: 'users.id', to: 'workouts.userId' },
  })
  workouts: WorkoutModel[];
}
