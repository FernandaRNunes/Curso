import { Pool } from "pg"

export const db = new Pool({
    user: "postgres",
    password: "aluno",
    host: 'localhost',
    port: 5432,
    database: 'postgres'
})