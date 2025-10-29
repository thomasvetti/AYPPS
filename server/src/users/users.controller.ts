import { Controller, Post, Body, Get, Delete, Param } from '@nestjs/common';
import { UsersService } from './users.service';
import { User } from './user.entity';

@Controller('users')
export class UsersController {
  constructor(private usersService: UsersService) {}

  @Post('register')
  create(@Body() body: { email: string; password: string }) {
    return this.usersService.create(body.email, body.password);
  }

  // Nuevo: listar usuarios (sin devolver password)
  @Get()
  async findAll() {
    const users = await this.usersService.findAll();
    // eliminar campo password antes de devolver
    return users.map((u: User) => ({
      id: u.id,
      email: u.email,
    }));
  }

  // Nuevo: eliminar por id
  @Delete(':id')
  async remove(@Param('id') id: string) {
    await this.usersService.remove(+id);
    return { ok: true };
  }

  // Opcional: eliminar por email (POST por seguridad o DELETE con query)
  // @Delete('by-email/:email')
  // async removeByEmail(@Param('email') email: string) {
  //   await this.usersService.removeByEmail(email);
  //   return { ok: true };
  // }
}