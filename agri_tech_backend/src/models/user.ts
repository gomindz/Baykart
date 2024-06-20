import { Model, DataTypes, UUIDV4 } from "sequelize";
import sequelize from "../connections/connection";
import Equipment from "./equipment";
import LiveStock from "./livestock";
import Product from "./product";

export default class User extends Model {}

User.init(
  {
    id: {
      type: DataTypes.UUID,
      primaryKey: true,
      allowNull: false,
      defaultValue: UUIDV4,
    },
    fullname: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    phone_number: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    language: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    region: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    role: {
      type: DataTypes.ENUM,
      values: ["farmer", "buyer", "seller", "admin", "super-admin"],
      defaultValue: "farmer",
    },
    crops: {
      type: DataTypes.ARRAY(DataTypes.UUID),
      allowNull: false,
      defaultValue: [],
    },
    location: {
      type: DataTypes.JSONB,
      allowNull: true,
    },
    deleted: {
      type: DataTypes.BOOLEAN,
      defaultValue: false,
      allowNull: false,
    },
  },
  { sequelize }
);

User.hasMany(Equipment, { foreignKey: "user_id" });
User.hasMany(LiveStock, { foreignKey: "user_id" });
User.hasMany(Product, { foreignKey: "user_id" });

User.sync({ alter: { drop: false } });
