import { Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { Model, ObjectionModule } from 'nestjs-objection';

@Module({
  imports: [
    ObjectionModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: (configService: ConfigService) => {
        const connection = {
          user: configService.get('DB_USER'),
          database: configService.get('DB_NAME'),
          password: configService.get('DB_PASSWORD'),
          port: configService.get('DB_PORT'),
          host: configService.get('DB_HOST'),
          timezone: 'utc',
          ssl: undefined,
        };

        if (configService.get('DB_HOST') !== 'localhost') {
          connection.ssl = {
            sslmode: 'require',
            rejectUnauthorized: false,
          };
        }

        return {
          Model,
          config: {
            client: 'postgres',
            useNullAsDefault: true,
            debug: configService.get('DB_HOST') === 'localhost',
            connection,
          },
        };
      },
      inject: [ConfigService],
    }),
  ],
  exports: [ObjectionModule],
})
export class DatabaseModule {}
