import * as Knex from 'knex';

export async function up(knex: Knex): Promise<void> {
  return knex.schema.createTable('challenge_progress', function(table) {
    table.date('date').notNullable();

    table
      .integer('challengeId')
      .references('id')
      .inTable('challenges')
      .notNullable()
      .onDelete('CASCADE');

    table
      .integer('userId')
      .references('id')
      .inTable('users')
      .notNullable()
      .onDelete('CASCADE');
  });
}

export async function down(knex: Knex): Promise<void> {
  return knex.schema.dropTable('challenge_progress');
}
