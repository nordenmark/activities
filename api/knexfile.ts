// Update with your config settings.

module.exports = {
  development: {
    client: 'postgresql',
    connection: {
      user: process.env.DB_USER,
      database: process.env.DB_NAME,
      password: process.env.DB_PASSWORD,
      port: process.env.DB_PORT,
      host: process.env.DB_HOST,
      timezone: 'utc',
      ...(process.env.ENVIRONMENT_NAME === 'production' && {
        ssl: {
          sslmode: 'require',
          rejectUnauthorized: false,
        },
      }),
    },
  },

  staging: {
    client: 'postgresql',
  },

  production: {
    client: 'postgresql',
    connection: {
      user: process.env.DB_USER,
      database: process.env.DB_NAME,
      password: process.env.DB_PASSWORD,
      port: process.env.DB_PORT,
      host: process.env.DB_HOST,
      ssl: {
        sslmode: 'require',
        rejectUnauthorized: false,
      },
    },
  },
};
