import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { DatabaseModule } from './database/database.module';
import { WorkoutsModule } from './workouts/workouts.module';
import { AuthModule } from './auth/auth.module';
import { UsersModule } from './users/users.module';
import { FriendsModule } from './friends/friends.module';
import { ChallengesModule } from './challenges/challenges.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      envFilePath:
        process.env.ENVIRONMENT_NAME === 'production'
          ? '.production.env'
          : '.env',
    }),
    DatabaseModule,
    WorkoutsModule,
    AuthModule,
    UsersModule,
    FriendsModule,
    ChallengesModule,
  ],
})
export class AppModule {}
