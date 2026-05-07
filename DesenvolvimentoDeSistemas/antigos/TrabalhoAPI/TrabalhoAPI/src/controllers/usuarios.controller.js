import { usuarios } from "../data/usuarios.js"

// LISTAR
export function listarUsuarios(req, res) {
	res.json(usuarios)
}

// BUSCAR POR ID
export function buscarUsuarioPorId(req, res) {
	const { id } = req.params

	const usuarioEncontrado = usuarios.find(u => u.id == id)

	if (!usuarioEncontrado) {
		return res.status(404).json({ mensagem: "Usuário não encontrado" })
	}

	res.json(usuarioEncontrado)
}

// CRIAR
export function criarUsuario(req, res) {
	const { usuario, ativo } = req.body

	if (!usuario || ativo === undefined) {
		return res.status(400).json({ mensagem: "Dados inválidos" })
	}

	const novoUsuario = {
		id: usuarios.length + 1,
		usuario,
		ativo
	}

	usuarios.push(novoUsuario)

	res.status(201).json(novoUsuario)
}

// DELETAR POR ID
export function deletarUsuario(req, res) {
	const { id } = req.params

	const index = usuarios.findIndex(u => u.id == id)

	if (index === -1) {
		return res.status(404).json({ mensagem: "Usuário não encontrado" })
	}

	usuarios.splice(index, 1)

	res.status(204).send()
}

// ATUALIZAR POR ID
export function atualizarUsuario(req, res) {
	const { id } = req.params
	const { usuario, ativo } = req.body

	const usuarioEncontrado = usuarios.find(u => u.id == id)

	if (!usuarioEncontrado) {
		return res.status(404).json({ mensagem: "Usuário não encontrado" })
	}

	if (!usuario || ativo === undefined) {
		return res.status(400).json({ mensagem: "Dados inválidos" })
	}

	usuarioEncontrado.usuario = usuario
	usuarioEncontrado.ativo = ativo

	res.json(usuarioEncontrado)
}

