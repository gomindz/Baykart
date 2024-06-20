import { Model, DataTypes, UUIDV4 } from "sequelize";
import sequelize from "../connections/connection";
import Crop from "./crop";

export default class CropCategory extends Model {}

CropCategory.init(
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
  },
  { sequelize }
);

CropCategory.hasMany(Crop, { foreignKey: "category_id" });

CropCategory.sync({ alter: { drop: false } });
