import { DatabaseModule } from '#app/database/database.module';
import { ChallengeModel } from '#app/models/challenge.model';
import { Module } from '@nestjs/common';
import { ObjectionModule } from 'nestjs-objection/dist';
import { ChallengesController } from './challenges.controller';
import { ChallengesService } from './challenges.service';

@Module({
  imports: [DatabaseModule, ObjectionModule.forFeature([ChallengeModel])],
  controllers: [ChallengesController],
  providers: [ChallengesService],
})
export class ChallengesModule {}
