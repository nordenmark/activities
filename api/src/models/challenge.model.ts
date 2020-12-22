import {
  Model,
  Column,
  Table,
  columnTypes,
  relationTypes,
  Relation,
} from 'nestjs-objection';
import { UserModel } from './user.model';

@Table({ tableName: 'challenges' })
export class ChallengeModel extends Model {
  @Column({ type: columnTypes.increments })
  id: number;

  @Column({ type: columnTypes.string })
  name: string;

  @Column({ type: columnTypes.date })
  fromDate: Date;

  @Column({ type: columnTypes.date })
  toDate: Date;

  @Column({ type: columnTypes.integer })
  creatorId: number;

  @Relation({
    modelClass: UserModel,
    relation: relationTypes.BelongsToOneRelation,
    join: { from: 'users.id', to: 'challenges.creatorId' },
  })
  creator: UserModel;
}
