import * as Knex from 'knex';

export async function seed(knex: Knex): Promise<void> {
  await knex('friendships').del();

  await knex('friendships').insert([{ userId: 1, friendId: 2 }]);
  await knex('friendships').insert([{ userId: 2, friendId: 1 }]);
}
