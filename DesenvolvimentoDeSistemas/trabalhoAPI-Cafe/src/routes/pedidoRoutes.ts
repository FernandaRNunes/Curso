import { Router } from "express";
import { PedidoController } from "../controllers/PedidoController.js";

const router = Router();

router.get("/api/pedidos/relatorio", PedidoController.relatorio);

router.patch("/api/pedidos/:id/cancelar", PedidoController.cancelar);

export default router;
