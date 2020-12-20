import * as Knex from 'knex';

export async function up(knex: Knex): Promise<void> {
  return knex.schema.createTable('friendships', function(table) {
    table
      .integer('userId')
      .notNullable()
      .references('id')
      .inTable('users');
    table
      .integer('friendId')
      .notNullable()
      .references('id')
      .inTable('users');

    table.primary(['userId', 'friendId']);
  });
}

export async function down(knex: Knex): Promise<void> {
  return knex.schema.dropTable('friendships');
}
