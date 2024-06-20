import { Request, Response } from "express";
import { log } from "@drantaz/f-log";
import CropCategory from "../models/crop-category";
import Crop from "../models/crop";

export const createCategory = async (req: Request, res: Response) => {
  const { data } = req.body;
  try {
    const category = await CropCategory.create({ ...data });
    res.status(201).json(category);
  } catch ({ message }) {
    log(message, "error");
    res.status(500).json({ message });
  }
};

export const getCategories = async (_req: Request, res: Response) => {
  try {
    const categories = await CropCategory.findAll({
      order: [
        ["name", "ASC"],
        ["createdAt", "DESC"],
      ],
      include: { all: true },
    });
    res.json(categories);
  } catch ({ message }) {
    log(message, "error");
    res.status(500).json({ message });
  }
};

export const createCrop = async (req: Request, res: Response) => {
  const { data } = req.body;
  try {
    const crop = await Crop.create({ ...data });
    res.status(201).json(crop);
  } catch ({ message }) {
    log(message, "error");
    res.status(500).json({ message });
  }
};

export const editCrop = async (req: Request, res: Response) => {
  const { id } = req.params;
  const { data } = req.body;
  try {
    const [_count, results] = await Crop.update(
      { ...data },
      { where: { id }, returning: true }
    );
    res.json(results[0]);
  } catch ({ message }) {
    log(message, "error");
    res.status(500).json({ message });
  }
};

export const editCategory = async (req: Request, res: Response) => {
  const { id } = req.params;
  const { data } = req.body;
  try {
    const [_count, results] = await CropCategory.update(
      { ...data },
      { where: { id }, returning: true }
    );
    res.json(results[0]);
  } catch ({ message }) {
    log(message, "error");
    res.status(500).json({ message });
  }
};

export const deleteCrop = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    await Crop.destroy({ where: { id } });
    res.sendStatus(204);
  } catch ({ message }) {
    log(message, "error");
    res.status(500).json({ message });
  }
};

export const deleteCategory = async (req: Request, res: Response) => {
  const { id } = req.params;
  try {
    await CropCategory.destroy({ where: { id } });
    res.sendStatus(204);
  } catch ({ message }) {
    log(message, "error");
    res.status(500).json({ message });
  }
};
