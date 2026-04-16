import { Router } from "express";
import { UserController } from "../controller/UserController";
import { resolve } from "node:dns";

const router = Router();
const userControler = new UserController();

router.post("/", (req, res) => userControler.create(req, res));
router.patch("/:id", (req, res) => userControler.update(req, res));
router.get("/", (req, res) => userControler.list(req, res));
router.delete("/:id", (req, res) => userControler.delete(req, res));

export const userRoutes = router;
