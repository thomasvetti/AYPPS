import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // ✅ Habilitar CORS para permitir peticiones desde Flutter Web
  app.enableCors({
    origin: '*', // puedes restringirlo si quieres (ej: ['http://localhost:xxxxx'])
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE,OPTIONS',
    credentials: false,
  });

  await app.listen(process.env.PORT || 3000);
}
bootstrap();
