import { Router } from "express"
import {reservar} from "../controllers/livraria.controller.js"
import { db } from "../db.js"

export const rotasLivraria = Router()

rotasLivraria.post("/reserva/:livroId/:usuarioId", reservar)












rotasLivraria.get("/teste", async (req, res) => {
   const result = await db.query('SELECT * from pessoas;')
    
    res.json(result.rows)
})