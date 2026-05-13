import { AppDataSource } from "../data-source.js";
import { Product } from "../entities/Product.js";

export class ProductService {
  private productRepository = AppDataSource.getRepository(Product);

  create = async (produtoData: Partial<Product>) => {
    return await this.productRepository.save(produtoData);
  };

  listAll = async () => {
    return await this.productRepository.find({ relations: ["Product"] });
  };
}
