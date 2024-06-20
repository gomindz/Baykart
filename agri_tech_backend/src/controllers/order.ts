import { log } from "@drantaz/f-log";
import { Request, Response } from "express";
import { generateTotalAmount } from "../utils";
import Order from "../models/order";
import { IProduct } from "../types";

export const addOrder = async (req: Request, res: Response) => {
  const {
    user_id,
    products,
    merchant,
    status,
    merchant_name,
    customer_name,
    merchant_id,
    merchant_number,
    customer_number,
  } = req.body;

  try {
    const total = generateTotalAmount(products);

    let data: Order | null;

    // get customer's cart
    data = await Order.findOne({
      where: {
        user_id,
        merchant,
        status: status,
      },
    });
    let prods: Array<IProduct>;
    if (data) {
      prods = products.map((curr: IProduct) => {
        curr.orderId = data?.getDataValue("order_id");
        return curr;
      });
      data.set("products", prods);
      data.set("total", total);
      data.save();
      const pds: Array<any> = data.getDataValue("products");

      if (pds.length === 0) {
        data.destroy();
      }
    } else {
      const orderId = Order.generateOrderId();
      prods = products.map((curr: IProduct) => {
        curr.orderId = orderId;
        return curr;
      });

      data = await Order.create({
        user_id,
        products: prods,
        order_id: orderId,
        merchant,
        merchant_name,
        customer_name,
        merchant_id,
        status,
        total,
        customer_number,
        merchant_number,
      });
    }

    res.status(201).json(data);
  } catch ({ message }) {
    log(message, "error");
    res.status(500).json({ message });
  }
};
