import { Request, Response } from "express";
import { log } from "@drantaz/f-log";
import Equipment from "../models/equipment";

export const addEquipment = async (req: Request, res: Response) => {
  const { data } = req.body;
  try {
    const equipment = await Equipment.create({ ...data });
    res.status(201).json(equipment);
  } catch ({ message }) {
    log(message, "error");
    res.status(500).json({ message });
  }
};

export const getEquipments = async (req: Request, res: Response) => {
  const { user_id } = req.query;
  try {
    const equipments = await Equipment.findAll({
      where: { user_id },
      order: [
        ["createdAt", "DESC"],
        ["name", "ASC"],
      ],
    });
    res.json(equipments);
  } catch ({ message }) {
    log(message, "error");
    res.status(500).json({ message });
  }
};

export const editEquipment = async (req: Request, res: Response) => {
  const { id } = req.params;
  const { data } = req.body;
  try {
    const [_count, results] = await Equipment.update(
      { ...data },
      { where: { id }, returning: true }
    );
    res.json(results[0]);
  } catch ({ message }) {
    log(message, "error");
    res.status(500).json({ message });
  }
};

export const deleteEquipment = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    await Equipment.destroy({ where: { id } });
    res.sendStatus(204);
  } catch ({ message }) {
    log(message, "error");
    res.status(500).json({ message });
  }
};
