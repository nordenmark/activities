import { ChallengeModel } from '#app/models/challenge.model';
import { Injectable } from '@nestjs/common';
import { InjectModel } from 'nestjs-objection';

@Injectable()
export class ChallengesService {
  constructor(
    @InjectModel(ChallengeModel)
    private readonly challengeModel: typeof ChallengeModel,
  ) {}

  async getForUser(userId: number): Promise<ChallengeModel[]> {
    // Get the ones where userId is a participant
    return this.challengeModel.query().withGraphFetched('creator');
  }
}
