import { Router } from "express";
import { ProductController } from "../controllers/ProductController.js";

const router = Router();
const productController = new ProductController();

router.get("/", productController.list);
router.post("/", productController.create);

export const produtoRoutes = router;
