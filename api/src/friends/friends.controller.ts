import { User } from '#app/auth/auth.interfaces';
import { JwtAuthGuard } from '#app/auth/jwt-auth.guard';
import { AuthedUser } from '#app/auth/user.decorator';
import { UsersService } from '#app/users/users.service';
import {
  Body,
  Controller,
  Get,
  NotFoundException,
  Post,
  UseGuards,
} from '@nestjs/common';
import { AddFriendDto } from './friends.dto';
import { Friend } from './friends.interfaces';
import { FriendsService } from './friends.service';

@Controller('friends')
@UseGuards(JwtAuthGuard)
export class FriendsController {
  constructor(
    private readonly friendsService: FriendsService,
    private readonly usersService: UsersService,
  ) {}

  @Get()
  async getFriends(@AuthedUser() user: User): Promise<Friend[]> {
    return this.friendsService.getForUser(user.id);
  }

  @Post()
  async addFriend(
    @AuthedUser() user: User,
    @Body() { friendEmail }: AddFriendDto,
  ): Promise<boolean> {
    const friend = await this.usersService.findOneByEmail(friendEmail);

    if (!friend) {
      throw new NotFoundException('User with that email not found');
    }

    return this.friendsService
      .addFriendForUser(user.id, friend.id)
      .then(() => true);
  }
}
