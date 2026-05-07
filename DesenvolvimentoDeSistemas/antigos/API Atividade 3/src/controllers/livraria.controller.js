import { livros } from "../data/livros.js"

export function reservar(req, res) {
    const idLivro = req.params.livroId
    const idUsuario = req.params.usuarioId

    const livro = livros.find(livro => livro.id == idLivro)

    if (!livro) return res.status(404).json({
        mensagem: "Livro não encontrado"
    })

    if (livro.usuarioId != null) return res.status(400).json({
        mensagem: "Livro já reservado, volte outra hora."
    })

    livro.usuarioId = idUsuario

    res.status(200).json({
        mensagem: `Reserva concluída do livro ${livro.titulo} para o usuario ${idUsuario}.`
    })
}