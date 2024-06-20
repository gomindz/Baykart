import { Model, DataTypes, UUIDV4 } from "sequelize";
import sequelize from "../connections/connection";
import otpGenerator from "otp-generator";
import User from "./user";

export default class Otp extends Model {
  static generateOtp = async (user_id: string): Promise<string> => {
    const otp = otpGenerator.generate(4, {
      specialChars: false,
      lowerCaseAlphabets: false,
      upperCaseAlphabets: false,
    });
    const user = await User.findByPk(user_id);
    if (user.getDataValue("phone") !== "7024725") {
      await Otp.update(
        { consumed: true },
        { where: { user_id, consumed: false } }
      );
    }

    return otp;
  };

  static verifyOtp = async (
    user_id: string,
    code: number
  ): Promise<boolean> => {
    try {
      const data = await Otp.findOne({ where: { user_id, code } });
      if (!data) throw new Error("OTP is not valid");
      if (data.getDataValue("consumed")) {
        return false;
      }
      return true;
    } catch (err) {
      throw err;
    }
  };
}

Otp.init(
  {
    id: {
      type: DataTypes.UUID,
      primaryKey: true,
      defaultValue: UUIDV4,
    },
    code: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    consumed: {
      type: DataTypes.BOOLEAN,
      defaultValue: false,
      allowNull: false,
    },
    user_id: {
      type: DataTypes.UUID,
      allowNull: false,
    },
  },
  { sequelize }
);

Otp.belongsTo(User, { foreignKey: "user_id" });

Otp.sync({ alter: { drop: false } });
