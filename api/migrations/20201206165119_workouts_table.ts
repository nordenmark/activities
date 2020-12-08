import * as Knex from 'knex';

export async function up(knex: Knex): Promise<void> {
  return knex.schema.createTable('workouts', function(table) {
    table.increments();
    table.string('activity').notNullable();
    table.date('date').notNullable();
    table
      .integer('userId')
      .references('id')
      .inTable('users')
      .notNullable();
  });
}

export async function down(knex: Knex): Promise<void> {
  return knex.schema.dropTable('workouts');
}
