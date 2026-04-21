import { Request, Response } from "express";
import { Pedido } from "../models/Pedido.js";

export class PedidoController {
  static async relatorio(req: Request, res: Response) {
    try {
      const data = await Pedido.getFaturamentoTotal();
      return res.json(data);
    } catch (error) {
      console.error("ERRO REAL:", error);
      return res.status(500).json({ error: "Erro ao gerar relatório" });
    }
  }

  // cancelamento de pedido
  static async cancelar(req: Request, res: Response) {
    try {
      const { id } = req.params;

      await Pedido.cancelarPedido(Number(id));

      return res.json({ message: "Pedido cancelado com sucesso" });
    } catch (error: any) {
      if (error.message === "Pedido não encontrado") {
        return res.status(404).json({ error: error.message });
      }

      if (error.message === "INVALID_STATUS") {
        return res.status(400).json({
          error: "Pedido só pode ser cancelado se estiver pendente",
        });
      }

      console.error(error);
      return res.status(500).json({ error: "Erro ao cancelar pedido" });
    }
  }
}
