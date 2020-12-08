import * as Knex from 'knex';

import { entries as nicklas } from '../fixtures/nicklas';
import { entries as lucile } from '../fixtures/lucile';

export async function seed(knex: Knex): Promise<void> {
  await knex('workouts').del();

  await knex('workouts').insert(
    nicklas.map(entry => ({ ...entry, userId: 1 })),
  );

  await knex('workouts').insert(lucile.map(entry => ({ ...entry, userId: 2 })));
}
