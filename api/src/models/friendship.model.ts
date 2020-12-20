import { Model, Column, Table, columnTypes } from 'nestjs-objection';

@Table({ tableName: 'friendships' })
export class FriendshipModel extends Model {
  @Column({ type: columnTypes.integer })
  userId: number;

  @Column({ type: columnTypes.integer })
  friendId: number;
}
