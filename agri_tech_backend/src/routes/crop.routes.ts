import express from "express";
import auth from "../middleware/auth";
import {
  createCategory,
  createCrop,
  deleteCategory,
  deleteCrop,
  editCategory,
  editCrop,
  getCategories,
} from "../controllers/crop";
const router = express.Router();

router.route("/crop").post(auth, createCrop);
router.route("/crop/:id").put(auth, editCrop).delete(auth, deleteCrop);
router.route("/").post(auth, createCategory).get(auth, getCategories);
router.route("/:id").put(auth, editCategory).delete(auth, deleteCategory);

export default router;
