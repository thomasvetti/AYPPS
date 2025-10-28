import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // ✅ Configuración detallada de CORS para Flutter Web + Render
  app.enableCors({
    origin: [
      'http://localhost:3000',  // tu entorno local
      'http://localhost:5000',
      'http://localhost:8000',
      'http://127.0.0.1:5500',
      'http://localhost:XXXXX', // reemplaza con el puerto de Flutter Web (ej: 59793)
      'https://aypps.onrender.com', // opcional
    ],
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE,OPTIONS',
    allowedHeaders: 'Content-Type, Authorization',
    credentials: false,
    preflightContinue: false,
    optionsSuccessStatus: 204,
  });

  await app.listen(process.env.PORT || 3000);
}
bootstrap();
