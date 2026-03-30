import meuexpress from "express"
import {rotasUsuarios} from "./routes/usuarios.route.js"
import {rotasLivros} from "./routes/livros.route.js"
import {rotasLivraria} from "./routes/livraria.route.js"
import { db } from "./database.js"

const api = meuexpress()

api.use(meuexpress.json())

api.use(rotasUsuarios)
api.use(rotasLivros)
api.use(rotasLivraria)

api.get("/pessoas", async function(req, res) {
    const resultado = await db.query("SELECT * from pessoas;")
    
    res.status(200).json(resultado.rows)
})

api.post("/pessoas", async function(req, res) {
    const dados = req.body

    const resultado = await db.query("INSERT INTO pessoas (nome) values($1) returning *;", [dados.nome])

    console.log(resultado)

    res.status(200).json({
        mensagem: "Pessoa criada."
    })
})

api.listen(3000, function() {
    console.log("Servidor iniciado em http://localhost:3000")
})