import type { Request, Response } from "express";

import { ProductService } from "../services/ProductService.js";

export class ProductController {
  private productService = new ProductService();

  create = async (req: Request, res: Response) => {
    const newProduct = await this.productService.create(req.body);
    return res.status(201).json(newProduct);
  };

  list = async (req: Request, res: Response) => {
    const product = await this.productService.listAll();
    return res.status(200).json(product);
  };

  upadate = async (req: Request, res: Response) => {
    const id = Number(req.params.id);
    const product = await this.productService.update(id, req.body);
    return res.status(200).json(product);
  };

  delete = async (req: Request, res: Response) => {
    const id = Number(req.params.id);
    if (isNaN(id)) {
      throw new Error("ID inválido");
    }
    await this.productService.delete(id);
    return res.status(204).send();
  };
}
