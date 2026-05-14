import { Router } from "express";
import { ProductController } from "../controllers/ProductController.js";

const router = Router();
const productController = new ProductController();

router.get("/", productController.list);
router.post("/", productController.create);
router.patch("/:id", productController.upadate);
router.delete("/:id", productController.delete);

export const produtoRoutes = router;
