import { Request, Response } from "express";
import { log } from "@drantaz/f-log";
import LiveStock from "../models/livestock";

export const addLiveStock = async (req: Request, res: Response) => {
  const { data } = req.body;
  try {
    const livestock = await LiveStock.create({ ...data });
    res.status(201).json(livestock);
  } catch ({ message }) {
    log(message, "error");
    res.status(500).json({ message });
  }
};

export const getLiveStocks = async (req: Request, res: Response) => {
  const { user_id } = req.query;
  try {
    const livestocks = await LiveStock.findAll({
      where: { user_id },
      order: [
        ["createdAt", "DESC"],
        ["name", "ASC"],
      ],
    });
    res.json(livestocks);
  } catch ({ message }) {
    log(message, "error");
    res.status(500).json({ message });
  }
};

export const editLiveStock = async (req: Request, res: Response) => {
  const { id } = req.params;
  const { data } = req.body;
  try {
    const [_count, results] = await LiveStock.update(
      { ...data },
      { where: { id }, returning: true }
    );
    res.json(results[0]);
  } catch ({ message }) {
    log(message, "error");
    res.status(500).json({ message });
  }
};

export const deleteLiveStock = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    await LiveStock.destroy({ where: { id } });
    res.sendStatus(204);
  } catch ({ message }) {
    log(message, "error");
    res.status(500).json({ message });
  }
};
