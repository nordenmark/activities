import * as Knex from 'knex';

export async function up(knex: Knex): Promise<void> {
  return knex.schema.createTable('challenge_users', function(table) {
    table
      .integer('userId')
      .references('id')
      .inTable('users')
      .notNullable()
      .onDelete('CASCADE');

    table
      .integer('challengeId')
      .references('id')
      .inTable('challenges')
      .notNullable()
      .onDelete('CASCADE');

    table.primary(['userId', 'challengeId']);
  });
}

export async function down(knex: Knex): Promise<void> {
  return knex.schema.dropTable('challenge_users');
}
