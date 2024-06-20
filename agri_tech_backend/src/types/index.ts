export interface IProduct {
  id: number;
  name: string;
  unit_price: number;
  quantity: number;
  orderId: string;
  discount?: number;
}
