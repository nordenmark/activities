import { UserModel } from '#app/models/user.model';
import { Injectable } from '@nestjs/common';
import { InjectModel } from 'nestjs-objection';

@Injectable()
export class UsersService {
  constructor(
    @InjectModel(UserModel) private readonly userModel: typeof UserModel,
  ) {}

  findOneById(id: number): Promise<UserModel | undefined> {
    return this.userModel.query().findById(id);
  }

  findOneByEmail(email: string): Promise<UserModel | undefined> {
    return this.userModel.query().findOne({ email });
  }
}
