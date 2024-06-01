import express from "express";
import { genToken } from "../utils/functions";
var router = express.Router();
import os from "os";

/* GET home page. */
router.get("/", function (req, res, next) {
    console.log(os.arch());
    res.render("index", { title: "Express" });
});

router.post("/encode", async (req, res) => {
    try {
        const data = req.body;
        console.log(data);
        const token = genToken(data);
        res.send(token);
    } catch (e) {
        console.log(e);
        res.status(500).send("swr");
    }
});


export default router;


