import { Entity, PrimaryGeneratedColumn, Column } from "typeorm";

@Entity("products")
export class Product {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column()
  name!: string;

  @Column()
  quantity!: number;

  @Column("decimal", {
    precision: 10,
    scale: 2,
  })
  price!: number;
}
