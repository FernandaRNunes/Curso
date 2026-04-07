import { Router } from "express";
import {
  deletePedido,
  getPedidos,
  postPedido,
} from "../controllers/pedidoController.js";

const router = Router();

router.get("/", getPedidos);
router.post("/", postPedido);
router.delete("/:id", deletePedido);

export const pedidoRoutes = router;
