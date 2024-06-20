import express from "express";
import auth from "../middleware/auth";
import {
  addEquipment,
  deleteEquipment,
  editEquipment,
  getEquipments,
} from "../controllers/equipment";
const router = express.Router();

router.route("/").post(auth, addEquipment).get(auth, getEquipments);
router.route("/:id").put(auth, editEquipment).delete(auth, deleteEquipment);

export default router;
