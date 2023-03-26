import { createContext } from "react";
import { User } from "firebase/auth";

export const AuthContext = createContext<User | null>(null);
