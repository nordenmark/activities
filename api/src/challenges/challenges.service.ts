import { ChallengeModel, ChallengeType } from '#app/models/challenge.model';
import { Injectable } from '@nestjs/common';
import { Connection, InjectConnection, InjectModel } from 'nestjs-objection';

@Injectable()
export class ChallengesService {
  constructor(
    @InjectModel(ChallengeModel)
    private readonly challengeModel: typeof ChallengeModel,
    @InjectConnection() private readonly connection: Connection,
  ) {}

  async getForUser(userId: number): Promise<ChallengeModel[]> {
    // Get the ones where userId is a participant
    const challengeIds = (
      await this.connection('challenge_users').where({
        userId: userId,
      })
    ).map(({ challengeId }) => challengeId);

    return this.challengeModel
      .query()
      .withGraphFetched('[progress, progress.user]')
      .findByIds(challengeIds)
      .orderBy('toDate', 'asc');
  }

  async getById(id: number): Promise<ChallengeModel | undefined> {
    return this.challengeModel.query().findById(id);
  }

  async create(
    userId: number,
    name: string,
    fromDate: string,
    toDate: string,
    type: ChallengeType,
  ) {
    // Create the challenge itself
    const challenge = await this.challengeModel.query().insert({
      creatorId: userId,
      name,
      fromDate: new Date(fromDate),
      toDate: new Date(toDate),
      type,
    });

    // Make the creator a participant
    await this.connection('challenge_users').insert({
      userId,
      challengeId: challenge.id,
    });

    return challenge;
  }

  async toggleProgress(
    userId: number,
    challengeId: number,
    date: string,
    completed: boolean,
  ) {
    // Does the user already have progress for the given date and wants to change it?
    const existing = await this.connection('challenge_progress').where({
      date: new Date(date),
      userId,
      challengeId,
    });

    console.log('existing', existing);

    return true;
  }
}
