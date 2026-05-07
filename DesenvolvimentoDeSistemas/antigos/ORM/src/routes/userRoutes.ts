import { Router } from "express";
import { UserController } from "../controller/UserController";
import { resolve } from "node:dns";

const router = Router();
const userControler = new UserController();

router.post("/", userControler.create);
router.patch("/:id/toggle", userControler.toggleActive);
router.patch("/:id", userControler.update);
router.get("/", userControler.list);
router.get("/active", userControler.listActive);
router.get("/:id", userControler.listById);
router.get("/:id", userControler.list);
router.delete("/:id", userControler.delete);

export const userRoutes = router;
