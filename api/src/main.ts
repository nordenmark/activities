import { ValidationPipe } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  app.useGlobalPipes(
    new ValidationPipe({
      transform: true,
    }),
  );

  app.enableCors();

  const port = process.env.PORT || 8888;

  await app.listen(port, () => {
    console.log('server running at http://localhost:8888');
  });
}

bootstrap();
