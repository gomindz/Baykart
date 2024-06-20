import express from "express";
import auth from "../middleware/auth";
import {
  addLiveStock,
  deleteLiveStock,
  editLiveStock,
  getLiveStocks,
} from "../controllers/livestock";
const router = express.Router();

router.route("/").post(auth, addLiveStock).get(auth, getLiveStocks);
router.route("/:id").put(auth, editLiveStock).delete(auth, deleteLiveStock);

export default router;
