import * as Knex from 'knex';

export async function up(knex: Knex): Promise<void> {
  return knex.schema.createTable('challenges', function(table) {
    table.increments('id');
    table.string('name').notNullable();
    table.date('fromDate').notNullable();
    table.date('toDate').notNullable();
    table
      .integer('creatorId')
      .references('id')
      .inTable('users')
      .notNullable();
  });
}

export async function down(knex: Knex): Promise<void> {
  return knex.schema.dropTable('challenges');
}
