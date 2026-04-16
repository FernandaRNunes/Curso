export const calculoDesconto = (valor: number, categoria: string): number => {
  if (categoria === "ELETRONICOS") {
    return valor * 0.9;
  }
  if (categoria === "VESTUARIO") {
    return valor * 0.95;
  }
  return -1;
};

console.log(calculoDesconto(3000, "ELETRONICOS"));
