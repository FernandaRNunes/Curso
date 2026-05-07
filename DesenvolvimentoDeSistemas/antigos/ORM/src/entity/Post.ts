import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { User } from "./User";
import { IsNotEmpty, IsString, MinLength, Validate } from "class-validator";
import { NoBlankSpaceConstraint } from "../decorators/noBlankSpaces";

@Entity()
export class Post {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column("varchar")
  @IsNotEmpty({ message: "O título é obrigatório" })
  @IsString({ message: "O nome deve ser um texto" })
  @MinLength(5, { message: "Título deve conter no mínimo 5 caracteres" })
  @Validate(NoBlankSpaceConstraint, {
    message: "O título do post precisa ter algum texto.",
  })
  title!: string;

  @Column("text")
  @IsNotEmpty({ message: "O título é obrigatório" })
  @IsString({ message: "O nome deve ser um texto" })
  @Validate(NoBlankSpaceConstraint)
  content: string;

  // ↓ Um usuário pode ter muitos pots  ↓
  @ManyToOne(() => User, (user) => user.posts, { onDelete: "CASCADE" })
  user!: User;
}
