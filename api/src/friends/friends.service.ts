import { FriendshipModel } from '#app/models/friendship.model';
import { UserModel } from '#app/models/user.model';
import { Injectable } from '@nestjs/common';
import { InjectModel } from 'nestjs-objection';
import { Friend } from './friends.interfaces';

@Injectable()
export class FriendsService {
  constructor(
    @InjectModel(FriendshipModel)
    private readonly friendshipModel: typeof FriendshipModel,
    @InjectModel(UserModel)
    private readonly userModel: typeof UserModel,
  ) {}

  async getForUser(userId: number): Promise<Friend[]> {
    const friendships = await this.friendshipModel
      .query()
      .where({ userId: userId });

    const friendIds = friendships.map(({ friendId }) => friendId);

    const users = await this.userModel
      .query()
      .withGraphJoined('workouts(filterThisYear)')
      .findByIds(friendIds);

    return users.map(user => ({
      id: user.id,
      name: user.name,
      email: user.email,
      workoutsCount: user.workouts.length,
    }));
  }

  async addFriendForUser(userId: number, friendId: number) {
    return this.friendshipModel.query().insert({
      userId,
      friendId,
    });
  }
}
