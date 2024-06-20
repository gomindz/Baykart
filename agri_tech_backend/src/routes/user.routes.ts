import express from "express";
import auth from "../middleware/auth";
import { editUser } from "../controllers/user";
const router = express.Router();

router.route("/:id").get(auth, editUser);

export default router;
