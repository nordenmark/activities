import {
  Model,
  Column,
  Table,
  columnTypes,
  relationTypes,
  Relation,
} from 'nestjs-objection';
import { ChallengeModel } from './challenge.model';
import { UserModel } from './user.model';

@Table({ tableName: 'challenge_progress' })
export class ChallengeProgressModel extends Model {
  @Column({ type: columnTypes.integer })
  challengeId: number;

  @Column({ type: columnTypes.integer })
  userId: number;

  @Column({ type: columnTypes.date })
  date: Date;

  @Relation({
    modelClass: UserModel,
    relation: relationTypes.BelongsToOneRelation,
    join: { from: 'users.id', to: 'challenge_progress.userId' },
  })
  user: UserModel;

  @Relation({
    modelClass: ChallengeModel,
    relation: relationTypes.BelongsToOneRelation,
    join: {
      from: 'challenges.id',
      to: 'challenge_progress.challengeId',
    },
  })
  challenge: ChallengeModel;
}
