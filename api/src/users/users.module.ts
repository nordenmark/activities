import { DatabaseModule } from '#app/database/database.module';
import { UserModel } from '#app/models/user.model';
import { Module } from '@nestjs/common';
import { ObjectionModule } from 'nestjs-objection';
import { UsersService } from './users.service';

@Module({
  imports: [DatabaseModule, ObjectionModule.forFeature([UserModel])],
  providers: [UsersService],
  exports: [UsersService],
})
export class UsersModule {}
