import {livros} from "../data/livros.js"

export function listarLivros(req, res) {
    res.status(200).json(livros)
}

export function criarLivro(req, res) {
    const dados = req.body

    if (!dados.titulo) return res.status(400).json({
        mensagem: "Faltando o título do livro."
    })

    const ultimoId = livros.length ? livros[livros.length - 1].id : 0

    const novoLivro = {
        id: ultimoId + 1,
        titulo: dados.titulo,
        usuarioId: dados.usuarioId ?? null
    }

    livros.push(novoLivro)

    res.status(201).json({
        mensagem: "Livro criado com sucesso.",
        livro: novoLivro
    })
}