import {usuarios} from "../data/usuarios.js"

export function listarUsuarios(req, res) {
    res.status(200).json(usuarios)
}

export function listarUsuario(req, res) {
    const id = req.params.id
    const usuario = usuarios.find(usuario => usuario.id == id)

    if (!usuario) {
        return res.status(404).json({
            mensagem: "Usuário não encontrado!"
        })
    }

    res.status(200).json({
        mensagem: "Usuario encontrado.",
        usuario: usuario
    })
}

export function criarUsuario(req, res) {
    const dados = req.body

    if (!dados.usuario || dados.ativo == undefined) {
        return res.status(400).json({
            mensagem: "Informação faltando. Precisa ter usuario e ativo."
        })
    }

    const ultimoId = usuarios.length ? usuarios[usuarios.length - 1].id : 0
    const novoId = ultimoId + 1

    const novoUsuario = {
        id: novoId,
        usuario: dados.usuario,
        ativo: dados.ativo
    }

    usuarios.push(novoUsuario)

    res.status(201).json({
        mensagem: "Usuario criado!",
        usuario: novoUsuario
    })
}

export function apagarUsuario(req, res) {
    const id = req.params.id
    const indice = usuarios.findIndex(usuario => usuario.id == id)

    if (indice == -1) return res.status(404).json({
        mensagem: "Usuário não encontrado."
    })

    usuarios.splice(indice, 1)

    res.status(200).json({
        mensagem: `Usuário do id ${id} foi deletado`
    })
}