import "dotenv/config";
import express from "express";
import pedidoRoutes from "./routes/pedidoRoutes.js";

const app = express();

app.use(express.json());

app.use(pedidoRoutes);

app.listen(process.env.PORT || 3000, () => {
  console.log("Servidor rodando");
});
