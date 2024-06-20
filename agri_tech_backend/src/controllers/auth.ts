import { Request, Response } from "express";
import { log } from "@drantaz/f-log";
import Otp from "../models/otp";
import User from "../models/user";
import Axios from "axios";
import bcrypt from "bcryptjs";
import { createToken } from "../utils";

const DS_API = "https://sms-api.datasling.gm";

export const createUser = async (req: Request, res: Response) => {
  const { data } = req.body;
  try {
    const { phone_number } = data;

    // check if user exist
    const usr = await User.findOne({ where: { phone_number } });
    if (usr) {
      const blocked = usr.getDataValue("deleted") as boolean;
      if (blocked) {
        const [_, result] = await User.update(
          { deleted: false },
          { where: { id: usr.getDataValue("id") }, returning: true }
        );
        return res
          .status(201)
          .json({ ...result[0].toJSON(), password: undefined });
      } else {
        return res.status(201).json({ ...usr.toJSON(), password: undefined });
      }
    }
    const user = await User.create({ ...data, id: undefined });
    res.status(201).json({ ...user.toJSON(), password: undefined });
  } catch ({ message }) {
    log(message, "error");
    res.status(500).json({ message });
  }
};

export const updateUser = async (req: Request, res: Response) => {
  const { data, from_admin } = req.body;
  const { id } = req.params;
  try {
    const [count, result] = await User.update(
      { ...data },
      { where: { id }, returning: true }
    );
    if (from_admin) {
      const token = createToken({ user_id: id }, "14d");
      res.json({ ...result[0].toJSON(), password: undefined, token });
    } else {
      res.json(result[0]);
    }
  } catch ({ message }) {
    log(message, "error");
    res.status(500).json({ message });
  }
};

export const verifyOTP = async (req: Request, res: Response) => {
  const { user_id, code } = req.body;
  try {
    const user = await User.findOne({ where: { id: user_id } });
    const isValid = await Otp.verifyOtp(user_id, code);
    if (!isValid)
      return res.status(400).json({ message: "Code is not longer valid." });
    if (user.getDataValue("phone_number") != "7024725") {
      await Otp.update(
        { consumed: true },
        { where: { user_id, consumed: false } }
      );
    }
    const token = createToken({ user_id });
    res.json({ ...user?.toJSON(), token });
  } catch ({ message }) {
    log(message, "error");
    res.status(500).json({ message });
  }
};

export const authenticateAdmin = async (req: Request, res: Response) => {
  const { phone_number, password } = req.body;
  try {
    const record = await User.findOne({
      where: { phone_number },
    });
    if (record) {
      const role = record.getDataValue("role") as string;
      const deleted = record.getDataValue("deleted") as boolean;
      if (!deleted) {
        if (role == "admin") {
          const pwd = record.getDataValue("password");
          const match = bcrypt.compareSync(password, pwd);
          if (match) {
            const token = createToken(
              { user_id: record.getDataValue("id") },
              "14d"
            );
            res.json({ ...record.toJSON(), password: undefined, token });
          } else {
            throw new Error("Invalid credentials");
          }
        } else {
          throw new Error("Please login in the mobile app.");
        }
      } else {
        throw new Error("User not found");
      }
    } else {
      throw new Error("User not found");
    }
  } catch ({ message }) {
    log(message, "error");
    res.status(500).json({ message });
  }
};

export const authenticate = async (req: Request, res: Response) => {
  const { phone_number } = req.body;
  try {
    const user = await User.findOne({ where: { phone_number } });
    if (!user)
      throw new Error(
        `${phone_number} not found. Check your number or create an account.`
      );
    const deleted = user.getDataValue("deleted") as boolean;
    if (!deleted) {
      if (phone_number !== "7024725") {
        const code = await Otp.generateOtp(user.getDataValue("id"));
        await Otp.create({ code, user_id: user.getDataValue("id") });
        await sendOTP(phone_number, Number(code));
      }
      res.json(user);
    } else {
      throw new Error("User not found");
    }
  } catch ({ message }) {
    log(message, "error");
    res.status(500).json({ message });
  }
};

export const resendOTP = async (req: Request, res: Response) => {
  const { phone_number, user_id } = req.body;
  try {
    const code = await Otp.generateOtp(user_id);
    await Otp.create({ code, user_id });
    await sendOTP(phone_number, Number(code));
    res.sendStatus(200);
  } catch ({ message }) {
    log(message, "error");
    res.status(500).json({ message });
  }
};

export const deleteUser = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    const user = await User.findByPk(id);
    if (!user) return res.status(404).json({ message: "user not found" });
    user.set("deleted", true);
    await user.save();
    res.sendStatus(204);
  } catch ({ message }) {
    log(message, "error");
    res.status(500).json({ message });
  }
};

const sendOTP = async (phone_number: string, code: number) => {
  try {
    const { data } = await Axios.post(
      `${DS_API}/transactions/sms_bulk`,
      {
        number: phone_number,
        message: `You can now access with ${code}`,
      },
      {
        headers: {
          Authorization: `Bearer f11b411fba0b8d305d56a79054af793f`,
        },
      }
    );
    return data;
  } catch (err) {
    throw err;
  }
};
