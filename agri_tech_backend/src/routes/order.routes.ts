import express from "express";
import { addOrder } from "../controllers/order";
import auth from "../middleware/auth";

const router = express.Router();

router.route("/").post(auth, addOrder);

export default router;
