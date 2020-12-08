import { Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { Model, ObjectionModule } from 'nestjs-objection';
import { WorkoutModel } from '#app/models/workout.model';

@Module({
  imports: [
    ObjectionModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: (configService: ConfigService) => {
        return {
          Model,
          config: {
            client: 'postgres',
            useNullAsDefault: true,
            connection: {
              user: configService.get('DB_USER'),
              database: configService.get('DB_NAME'),
              password: configService.get('DB_PASSWORD'),
              port: configService.get('DB_PORT'),
              host: configService.get('DB_HOST'),
            },
          },
        };
      },
      inject: [ConfigService],
    }),
  ],
  exports: [ObjectionModule],
})
export class DatabaseModule {}
