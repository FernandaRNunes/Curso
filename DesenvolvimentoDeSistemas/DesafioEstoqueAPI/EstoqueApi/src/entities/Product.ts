import { Entity, PrimaryGeneratedColumn, Column } from "typeorm";
import { IsDecimal, IsInt, IsNotEmpty, IsString } from "class-validator";

@Entity("products")
export class Product {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column("varchar")
  @IsNotEmpty({ message: "Primeiro nome é obrigatório!" })
  @IsString({ message: "Primeiro nome precisa ser um texto" })
  name!: string;

  @Column("int")
  @IsNotEmpty({ message: "Quantidade é obrigatória" })
  @IsInt({ message: "A quantidade precisa de um número inteiro" })
  quantity!: number;

  @Column("decimal", {
    precision: 10,
    scale: 2,
  })
  @IsNotEmpty({ message: "Preço é obrigatório" })
  @IsDecimal(
    { decimal_digits: "2" },
    { message: "Insira o formato moeda: 9.99" }
  )
  price!: string;
}
