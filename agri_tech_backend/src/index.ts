import { config } from "dotenv";
import { getLogs, log } from "@drantaz/f-log";
import { env } from "process";
config();
import express, { Application } from "express";
import cors from "cors";
import authRoutes from "./routes/auth.routes";
import userRoutes from "./routes/user.routes";
import equipmentRoutes from "./routes/equipment.routes";
import cropRoutes from "./routes/crop.routes";
import liveStockRoutes from "./routes/livestock.routes";
import orderRoutes from "./routes/order.routes";

const app: Application = express();
app.use(cors());

app.use("/api/auths", authRoutes);
app.use("/api/users", userRoutes);
app.use("/api/crops", cropRoutes);
app.use("/api/livestocks", liveStockRoutes);
app.use("/api/equipments", equipmentRoutes);
app.use("/api/orders", orderRoutes);

const { PORT } = env;

app.get("/", async (_req, res) => {
  res.send("Welcome to BayKart's Backend!");
});

app.get("/api/logs", (req, res) => {
  const { group, title } = req.query;
  const logs = getLogs(group ? true : false, title?.toString() || "");
  res.json(logs);
});

app.listen(parseInt(PORT, 10), async () => {
  log(`App running on http://localhost:${PORT}`, "debug");
});
