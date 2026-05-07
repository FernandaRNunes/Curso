import {Router} from "express"
import {
    listarUsuarios,
    criarUsuario,
    listarUsuario,
    apagarUsuario
} from "../controllers/usuarios.controller.js"

export const rotasUsuarios = Router()

rotasUsuarios.get("/usuarios", listarUsuarios)
rotasUsuarios.get("/usuarios/:id", listarUsuario)
rotasUsuarios.post("/usuarios", criarUsuario)
rotasUsuarios.delete("/usuarios/:id", apagarUsuario)

