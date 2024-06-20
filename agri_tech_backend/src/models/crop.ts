import { Model, DataTypes, UUIDV4 } from "sequelize";
import sequelize from "../connections/connection";

export default class Crop extends Model {}

Crop.init(
  {
    id: {
      type: DataTypes.UUID,
      primaryKey: true,
      defaultValue: UUIDV4,
      allowNull: false,
    },
    name: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    image_url: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    category_id: {
      type: DataTypes.UUID,
      allowNull: false,
    },
  },
  { sequelize }
);

Crop.sync({ alter: { drop: false } });
