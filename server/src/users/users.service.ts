import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from './user.entity';
import * as bcrypt from 'bcrypt';

@Injectable()
export class UsersService {
  constructor(
    @InjectRepository(User)
    private usersRepository: Repository<User>,
  ) {}

  async findByEmail(email: string): Promise<User | null> {
    return this.usersRepository.findOne({ where: { email } });
  }

  async create(email: string, password: string): Promise<User> {
    const hashedPassword = await bcrypt.hash(password, 10);
    const user = this.usersRepository.create({ email, password: hashedPassword });
    return this.usersRepository.save(user);
  }

  // Nuevo: listar todos los usuarios
  async findAll(): Promise<User[]> {
    return this.usersRepository.find();
  }

  // Nuevo: eliminar usuario por id
  async remove(id: number): Promise<void> {
    await this.usersRepository.delete(id);
  }

  // Opcional: eliminar por email
  async removeByEmail(email: string): Promise<void> {
    await this.usersRepository.delete({ email });
  }
}