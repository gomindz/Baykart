import express from "express";
import {
  authenticate,
  authenticateAdmin,
  createUser,
  deleteUser,
  resendOTP,
  updateUser,
  verifyOTP,
} from "../controllers/auth";
import auth from "../middleware/auth";
const router = express.Router();

router.route("/authenticate").post(authenticate);
router.route("/verify").post(verifyOTP);
router.route("/resend").post(resendOTP);
router.route("/admin/authenticate").post(authenticateAdmin);
router.route("/:id").put(auth, updateUser).delete(auth, deleteUser);
router.route("/").post(createUser);

export default router;
