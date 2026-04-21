import { pool } from "../db.js";

export interface IFaturamento {
  faturamento_total: number;
}

export class Pedido {
  static async getFaturamentoTotal(): Promise<IFaturamento> {
    const result = await pool.query(
      `
      SELECT COALESCE(SUM(ip.quantidade * ip.preco_un), 0) AS faturamento_total
      FROM pedidos p
      JOIN itens_pedido ip ON ip.pedido_id = p.id
      WHERE p.status = $1
      `,
      ["finalizado"]
    );

    return {
      faturamento_total: Number(result.rows[0].faturamento_total),
    };
  }

  // cancelamento com transação
  static async cancelarPedido(id: number): Promise<void> {
    const client = await pool.connect();

    try {
      await client.query("BEGIN");

      // verifica se o pedido existe e o status atual
      const pedidoResult = await client.query(
        "SELECT status FROM pedidos WHERE id = $1",
        [id]
      );

      if (pedidoResult.rowCount === 0) {
        throw new Error("Pedido não encontrado");
      }

      const status = pedidoResult.rows[0].status;

      // só permite cancelar se estiver pendente
      if (status !== "pendente") {
        throw new Error("INVALID_STATUS");
      }

      // busca os itens do pedido
      const itensResult = await client.query(
        "SELECT produto_id, quantidade FROM itens_pedido WHERE pedido_id = $1",
        [id]
      );

      // estorna o estoque
      for (const item of itensResult.rows) {
        await client.query(
          "UPDATE produtos SET estoque = estoque + $1 WHERE id = $2",
          [item.quantidade, item.produto_id]
        );
      }

      // atualiza status
      await client.query("UPDATE pedidos SET status = $1 WHERE id = $2", [
        "cancelado",
        id,
      ]);

      await client.query("COMMIT");
    } catch (error) {
      await client.query("ROLLBACK");
      throw error;
    } finally {
      client.release();
    }
  }
}
