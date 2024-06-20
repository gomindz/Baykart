import { DataTypes, Model, UUIDV4 } from "sequelize";
import sequelize from "../connections/connection";
import shortid from "shortid";

class Order extends Model {
  static generateOrderId(): string {
    return shortid.generate();
  }
}

Order.init(
  {
    id: {
      type: DataTypes.UUID,
      defaultValue: UUIDV4,
      allowNull: false,
      primaryKey: true,
    },
    user_id: {
      type: DataTypes.UUID,
      allowNull: false,
    },
    status: {
      type: DataTypes.ENUM("cart", "cancelled", "completed"),
      allowNull: false,
      defaultValue: "cart",
    },
    order_id: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: { name: "order_id", msg: "This order id is already in use." },
    },
    products: {
      type: DataTypes.JSONB,
      allowNull: false,
    },
    merchant_id: {
      type: DataTypes.UUID,
      allowNull: false,
    },
    total: {
      type: DataTypes.DOUBLE,
      allowNull: false,
    },
    merchant_name: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    customer_name: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    customer_coords: {
      type: DataTypes.JSONB,
      allowNull: true,
    },
    merchant_coords: {
      type: DataTypes.JSONB,
      allowNull: true,
    },
    merchant_number: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    customer_number: {
      type: DataTypes.STRING,
      allowNull: true,
    },
  },
  {
    sequelize,
    modelName: "Order",
  }
);

Order.sync({
  alter: {
    drop: false,
  },
});

export default Order;
