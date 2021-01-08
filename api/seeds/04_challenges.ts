import * as Knex from 'knex';

export async function seed(knex: Knex): Promise<void> {
  await knex('challenges').del();

  await knex('challenges').insert([
    {
      name: 'Squats',
      fromDate: new Date(2020, 11, 1),
      toDate: new Date(2020, 11, 30),
      creatorId: 1,
    },
    {
      name: 'Push ups on the fingertips',
      fromDate: new Date(2020, 11, 1),
      toDate: new Date(2021, 1, 30),
      creatorId: 1,
    },
  ]);

  await knex('challenge_users').insert([
    {
      userId: 1,
      challengeId: 1,
    },
    {
      userId: 1,
      challengeId: 2,
    },
  ]);
}
