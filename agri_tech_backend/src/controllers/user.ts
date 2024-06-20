import { Request, Response } from "express";
import { log } from "@drantaz/f-log";
import User from "../models/user";

export const editUser = async (req: Request, res: Response) => {
  const { id } = req.params;
  const { data } = req.body;
  try {
    const [_count, results] = await User.update(
      { ...data },
      { where: { id }, returning: true }
    );
    res.json(results[0]);
  } catch ({ message }) {
    log(message, "error");
    res.status(500).json({ message });
  }
};

export const getAppUsers = async (req: Request, res: Response) => {
  const { offset, limit } = req.query;
  try {
    const { rows, count } = await User.findAndCountAll({
      where: { role: "user" },
      order: [
        ["updatedAt", "DESC"],
        ["fullname", "ASC"],
      ],
      offset: Number(offset) || 0,
      limit: Number(limit) || 10,
    });
    res.json({
      data: rows,
      meta: { total: count },
    });
  } catch ({ message }) {
    log(message, "error");
    res.status(500).json({ message });
  }
};

export const loadAdmins = async (req: Request, res: Response) => {
  const { offset, limit } = req.query;
  try {
    const { rows, count } = await User.findAndCountAll({
      where: { role: "admin" },
      order: [
        ["updatedAt", "DESC"],
        ["fullname", "ASC"],
      ],
      offset: Number(offset) || 0,
      limit: Number(limit) || 10,
    });
    res.json({
      data: rows,
      meta: { total: count },
    });
  } catch ({ message }) {
    log(message, "error");
    res.status(500).json({ message });
  }
};
