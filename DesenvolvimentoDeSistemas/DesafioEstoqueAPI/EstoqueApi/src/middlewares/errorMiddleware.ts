import { Request, Response } from "express";

export const errorMiddleware = (error: any, req: Request, res: Response) => {
  if (Array.isArray(error) && error[0]?.constraints) {
    const messages = error
      .map((err: any) => Object.values(err.constraints))
      .flat();
    return res
      .status(400)
      .json({ message: "erro de validação", errors: messages });
  }

  const statusCode = error.statusCode ?? 500;
  const message = error.message ? error.message : "Erro interno do servidor";

  return res.status(statusCode).json({ message });
};
