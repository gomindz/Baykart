import { Model, DataTypes, UUIDV4 } from "sequelize";
import sequelize from "../connections/connection";

export default class Product extends Model {}

Product.init(
  {
    id: {
      type: DataTypes.UUID,
      primaryKey: true,
      allowNull: false,
      defaultValue: UUIDV4,
    },
    name: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    description: {
      type: DataTypes.TEXT,
      allowNull: false,
    },
    unit_price: {
      type: DataTypes.FLOAT,
      allowNull: false,
    },
    images: {
      type: DataTypes.ARRAY(DataTypes.STRING),
      allowNull: false,
    },
    quantity: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    listed_by: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    prioritized_regions: {
      type: DataTypes.ARRAY(DataTypes.STRING),
      allowNull: false,
      defaultValue: [],
    },
    status: {
      type: DataTypes.ENUM,
      values: ["available", "out-of-stock"],
      defaultValue: "available",
    },
    user_id: {
      type: DataTypes.UUID,
      allowNull: false,
    },
  },
  { sequelize }
);

Product.sync({ alter: { drop: false } });
