import express from "express"
import rotasUsuario from "./routes/usuarios.routes.js"

const api = express()

api.use(express.json())
api.use(rotasUsuario)

api.listen(3000, () => {
	console.log("Servidor rodando em http://localhost:3000")
})