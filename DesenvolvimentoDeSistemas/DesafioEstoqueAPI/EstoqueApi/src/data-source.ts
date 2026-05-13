import "reflect-metadata";
import { DataSource, type DataSourceOptions } from "typeorm";
import { Product } from "./entities/Product.js";

const options: DataSourceOptions = {
  type: (process.env.DB_TYPE as "postgres") || "postgres",
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT) || 5432,
  username: process.env.DB_USERNAME,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_DATABASE,
  synchronize: true,
  logging: true,
  entities: [Product],
  migrations: [],
  subscribers: [],
};

export const AppDataSource = new DataSource(options);
