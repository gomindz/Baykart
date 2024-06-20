import { Model, DataTypes, UUIDV4 } from "sequelize";
import sequelize from "../connections/connection";
import User from "./user";

export default class Sale extends Model {}

Sale.init(
  {
    id: {
      type: DataTypes.UUID,
      primaryKey: true,
      allowNull: false,
      defaultValue: UUIDV4,
    },
    item: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    quantity: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    buyer_name: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    buyer_contact: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    price: {
      type: DataTypes.FLOAT,
      allowNull: false,
    },
    user_id: {
      type: DataTypes.UUID,
      allowNull: false,
    },
  },
  { sequelize }
);

Sale.belongsTo(User, { foreignKey: "user_id" });

Sale.sync({ alter: { drop: false } });
