import { IsEmail, IsInt, IsNumber } from 'class-validator';

export class AddFriendDto {
  @IsEmail()
  friendEmail: string;
}
