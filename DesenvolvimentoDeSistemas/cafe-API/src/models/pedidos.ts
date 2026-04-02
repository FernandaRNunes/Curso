export interface IItemPedido{
    id: number;
    pedido_id: number;
    produto_id: number;
    quantidade: number;
    preco_un: number;
}

export interface IdPedido{
    id: number;
    data_criacao: Date;
    status: string;
    itens: IItemPedido[]
}

export type INovoItemPedido = Pick<IItemPedido