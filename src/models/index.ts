import { model } from "mongoose";
import { UserSchema } from "./user"

const User = model("User", UserSchema, )
export { User }