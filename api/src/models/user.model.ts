import { Model, Column, Table, columnTypes } from 'nestjs-objection';

@Table({ tableName: 'users' })
export class UserModel extends Model {
  @Column({ type: columnTypes.increments })
  id: number;

  @Column({ type: columnTypes.string })
  name: string;

  @Column({ type: columnTypes.string })
  email: string;

  @Column({ type: columnTypes.string })
  password: string;
}
