import api from "express"

const porta = 3000
const app = api()

app.get("/home", (req, res) => {
	res .json({
		mensagem: "Rota inicial",
		status: "Funcionando"
	})
})

app.get("/pessoa/:nome/:idade", (req, res) => {
	const idade = req.params.idade

	res.json({
		nome:req.params.nome,
		idade: idade
	})

})

app.listen(porta, () => {
	console.log(`O servidor está rodando em localhost: ${porta}`)
})
 