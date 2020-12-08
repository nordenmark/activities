import * as Knex from 'knex';

export async function seed(knex: Knex): Promise<void> {
  // Deletes ALL existing entries
  await knex('users').del();

  // Inserts seed entries
  await knex('users').insert([
    {
      id: 1,
      name: 'Nicky',
      email: 'nordenmark@gmail.com',
      password: '$2b$10$VDeVBTyFhLrRvZolcKCn1e.Ctg9IedOIyoIRLl.SPbPWodWIZ70FW',
    },
    {
      id: 2,
      name: 'Lussebullen',
      email: 'lucile.ericson@outlook.com',
      password: '$2b$10$VDeVBTyFhLrRvZolcKCn1e.Ctg9IedOIyoIRLl.SPbPWodWIZ70FW',
    },
  ]);
}
