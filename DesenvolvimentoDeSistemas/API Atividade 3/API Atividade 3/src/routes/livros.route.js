import {Router} from "express"
import {listarLivros, criarLivro} from "../controllers/livros.controller.js"

export const rotasLivros = Router() 

rotasLivros.get("/livros", listarLivros)
rotasLivros.post("/livros", criarLivro)