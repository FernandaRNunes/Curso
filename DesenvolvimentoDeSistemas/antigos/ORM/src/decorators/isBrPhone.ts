import {
  ValidationArguments,
  ValidatorConstraint,
  ValidatorConstraintInterface,
} from "class-validator";

@ValidatorConstraint({ name: "isBrPhone", async: false })
export class IsBrPhoneConstraint implements ValidatorConstraintInterface {
  validate(value: unknown): boolean {
    if (typeof value !== "string") return false;
    /**
     * Regex detalhada:
     * ^\(?\d{2}\)? -> DDD (2 dígitos) com parênteses opcionais
     * \s?          -> Espaço opcional
     * 9\d{4}       -> O dígito 9 obrigatório + 4 dígitos
     * -?           -> Traço opcional
     * \d{4}$       -> 4 dígitos finais
     */
    const phoneRegex = /^(?:\(\d{2}\)|\d{2})\s?9\d{4}-?\d{4}$/;
    return phoneRegex.test(value);
  }
  defaultMessage(args?: ValidationArguments): string {
    return `O número "${args?.value}" não é um celular válido (XX) 9XXXX-XXXX`;
  }
}
