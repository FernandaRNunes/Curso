import { Router } from "express"
import { listarUsuarios, criarUsuario, buscarUsuarioPorId, deletarUsuario, atualizarUsuario } from "../controllers/usuarios.controller.js"

const router = Router()

router.get("/usuarios", listarUsuarios)
router.get("/usuarios/:id", buscarUsuarioPorId)
router.post("/usuarios", criarUsuario)
router.put("/usuarios/:id", atualizarUsuario)
router.delete("/usuarios/:id", deletarUsuario)

export default router