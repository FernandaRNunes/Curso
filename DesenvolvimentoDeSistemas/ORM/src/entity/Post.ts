import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { User } from "./User";
import { IsNotEmpty, IsString, MinLength } from "class-validator";

@Entity()
export class Post {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column("varchar")
  @IsNotEmpty({ message: "O título é obrigatório" })
  @IsString({ message: "O nome deve ser um texto" })
  @MinLength(5, { message: "Título deve conter no mínimo 5 caracteres" })
  title!: string;

  @Column("text")
  @IsNotEmpty({ message: "O título é obrigatório" })
  @IsString({ message: "O nome deve ser um texto" })
  content: string;

  // ↓ Um usuário pode ter muitos pots  ↓
  @ManyToOne(() => User, (user) => user.posts, { onDelete: "CASCADE" })
  user!: User;
}
