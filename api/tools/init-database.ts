import * as knex from 'knex';

async function createDatabase() {
  const config = {
    client: 'postgresql',
    connection: {
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      port: process.env.DB_PORT,
      host: process.env.DB_HOST,
      database: 'postgres',
      timezone: 'utc',
    },
  };

  const client = knex(config);

  await client.raw('CREATE DATABASE activities');
  await client.destroy();
}

createDatabase();
