// Update with your config settings.

console.log('knexfile', process.env.DB_USER);

module.exports = {
  development: {
    client: 'postgresql',
    connection: {
      user: process.env.DB_USER,
      database: process.env.DB_NAME,
      password: process.env.DB_PASSWORD,
      port: process.env.DB_PORT,
      host: process.env.DB_HOST,
    },
  },

  staging: {
    client: 'postgresql',
    // connection: {
    //   database: 'my_db',
    //   user: 'username',
    //   password: 'password',
    // },
    // pool: {
    //   min: 2,
    //   max: 10,
    // },
    // migrations: {
    //   tableName: 'knex_migrations',
    // },
  },

  production: {
    client: 'postgresql',
    // connection: {
    //   database: 'my_db',
    //   user: 'username',
    //   password: 'password',
    // },
    // pool: {
    //   min: 2,
    //   max: 10,
    // },
    // migrations: {
    //   tableName: 'knex_migrations',
    // },
  },
};
