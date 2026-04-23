import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { Post } from "./Post";
import {
  IS_NOT_EMPTY,
  isEmpty,
  IsNotEmpty,
  isNotEmpty,
  IsString,
  isString,
} from "class-validator";

@Entity()
export class User {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column("varchar")
  @IsNotEmpty({ message: "O primeiro nome é obrigatório" })
  @IsString({ message: "O nome deve ser um texto" })
  firstName!: string;

  @Column("varchar")
  @IsNotEmpty({ message: "O primeiro nome é obrigatório" })
  @IsString({ message: "O nome deve ser um texto" })
  lastName!: string;

  @Column({ type: "boolean", default: true })
  isActive!: boolean;

  @OneToMany(() => Post, (post) => post.user)
  posts: Post[];
}
