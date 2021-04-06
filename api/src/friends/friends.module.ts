import { DatabaseModule } from '#app/database/database.module';
import { FriendshipModel } from '#app/models/friendship.model';
import { UserModel } from '#app/models/user.model';
import { UsersModule } from '#app/users/users.module';
import { Module } from '@nestjs/common';
import { ObjectionModule } from 'nestjs-objection';
import { FriendsController } from './friends.controller';
import { FriendsService } from './friends.service';

@Module({
  imports: [
    DatabaseModule,
    ObjectionModule.forFeature([FriendshipModel, UserModel]),
    UsersModule,
  ],
  controllers: [FriendsController],
  providers: [FriendsService],
  exports: [FriendsService],
})
export class FriendsModule {}
