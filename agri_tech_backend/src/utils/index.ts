import jwt from "jsonwebtoken";
import { IProduct } from "../types";

export const createToken = (userid: any, duration: string = "2 years") => {
  return jwt.sign(userid, process.env.TOKEN_SECRET!, {
    expiresIn: duration,
  });
};

export const generateTotalAmount = (products: IProduct[]) => {
  let total = 0;
  for (let i = 0; i < products.length; i++) {
    const product = products[i];
    total += product.discount
      ? product.quantity * product.unit_price - product.discount
      : product.quantity * product.unit_price;
  }
  return total;
};
