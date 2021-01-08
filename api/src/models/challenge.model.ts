import {
  Model,
  Column,
  Table,
  columnTypes,
  relationTypes,
  Relation,
} from 'nestjs-objection';
import { ChallengeProgressModel } from './challenge-progress.model';
import { UserModel } from './user.model';

export enum ChallengeType {
  DAILY = 'DAILY',
}

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

  @Column({ type: columnTypes.string, default: ChallengeType.DAILY })
  type: ChallengeType;

  @Relation({
    modelClass: UserModel,
    relation: relationTypes.BelongsToOneRelation,
    join: { from: 'users.id', to: 'challenges.creatorId' },
  })
  creator: UserModel;

  @Relation({
    modelClass: UserModel,
    relation: relationTypes.HasManyRelation,
    join: {
      from: 'challenges.id',
      through: {
        from: 'challenge_users.challengeId',
        to: 'challenge_users.userId',
      },
      to: 'users.id',
    },
  })
  participants: UserModel[];

  @Relation({
    modelClass: ChallengeProgressModel,
    relation: relationTypes.HasManyRelation,
    join: {
      from: 'challenges.id',
      to: 'challenge_progress.challengeId',
    },
  })
  progress: ChallengeProgressModel[];
}
