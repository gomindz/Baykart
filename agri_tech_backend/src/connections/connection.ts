import { Sequelize } from "sequelize";
import { env } from "process";

const sequelize = new Sequelize(
  env.DATABASE_NAME!.toString(),
  env.DATABASE_USER!.toString(),
  env.DATABASE_PASSWORD!.toString(),
  {
    port: Number(env.DATABASE_PORT!),
    host: env.DATABASE_HOST!.toString(),
    dialect: "postgres",
    logging: false,
  }
);

export default sequelize;
