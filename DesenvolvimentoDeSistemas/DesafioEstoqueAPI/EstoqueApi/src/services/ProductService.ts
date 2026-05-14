import { AppDataSource } from "../data-source.js";
import { Product } from "../entities/Product.js";

export class ProductService {
  private productRepository = AppDataSource.getRepository(Product);

  create = async (produtoData: Partial<Product>) => {
    return await this.productRepository.save(produtoData);
  };

  listAll = async () => {
    return await this.productRepository.find();
  };

  update = async (id: number, produtoData: Partial<Product>) => {
    const product = await this.productRepository.findOneBy({ id });
    if (!product) {
      throw new Error("Produto não encontrado");
    }
    this.productRepository.merge(product, produtoData);
    return await this.productRepository.save(product);
  };

  delete = async (id: number) => {
    const product = await this.productRepository.findOneBy({ id });
    if (!product) {
      throw new Error("Produto não encontrado");
    }
    return await this.productRepository.delete(id);
  };
}
