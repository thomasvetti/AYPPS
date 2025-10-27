import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { TasksModule } from './tasks/tasks.module';
import { ConfigModule } from '@nestjs/config';

@Module({
  imports: [
    ConfigModule.forRoot(), // Carga variables de entorno del .env
    TypeOrmModule.forRoot({
      type: 'postgres',
      url: process.env.DATABASE_URL, // Usará la variable del archivo .env
      autoLoadEntities: true,
      synchronize: true, // ⚠️ solo para desarrollo
      ssl: { rejectUnauthorized: false }, // necesario para Neon
    }),
    TasksModule,
  ],
})
export class AppModule {}
