"use client";

import { createContext, useContext, useState, useEffect, ReactNode, useCallback } from "react";
import { authApi } from "@/infrastructure/api";

interface User {
  uid: string;
  email: string;
  tenKhachHang: string | null;
  isAnonymous?: boolean;
}

interface AuthContextType {
  user: User | null;
  token: string | null;
  isAnonymous: boolean;
  signIn: (token: string, user: User) => void;
  signOut: () => void;
  ensureAuth: () => Promise<string>;
  isLoading: boolean;
}

const AuthContext = createContext<AuthContextType>({
  user: null,
  token: null,
  isAnonymous: false,
  signIn: () => { },
  signOut: () => { },
  ensureAuth: async () => "",
  isLoading: true,
});

export function AuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<User | null>(null);
  const [token, setToken] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    const savedToken = localStorage.getItem("token");
    const savedUser = localStorage.getItem("user");
    if (savedToken && savedUser) {
      setToken(savedToken);
      setUser(JSON.parse(savedUser));
    }
    setIsLoading(false);
  }, []);

  const signIn = useCallback((newToken: string, newUser: User) => {
    setToken(newToken);
    setUser(newUser);
    localStorage.setItem("token", newToken);
    localStorage.setItem("user", JSON.stringify(newUser));
  }, []);

  const signOut = useCallback(() => {
    setToken(null);
    setUser(null);
    localStorage.removeItem("token");
    localStorage.removeItem("user");
  }, []);

  const ensureAuth = useCallback(async (): Promise<string> => {
    if (token) {
      try {
        const payload = JSON.parse(atob(token.split(".")[1]));
        if (payload.exp && payload.exp * 1000 > Date.now()) {
          return token;
        }
      } catch {
        // Can't parse → treat as expired
      }
      signOut();
    }

    const res = await authApi.signInAnonymously();
    const newUser: User = {
      uid: res.data.uid,
      email: "",
      tenKhachHang: null,
      isAnonymous: true,
    };
    signIn(res.token, newUser);
    return res.token;
  }, [token, signIn, signOut]);

  const isAnonymous = user?.isAnonymous === true;

  return (
    <AuthContext.Provider value={{ user, token, isAnonymous, signIn, signOut, ensureAuth, isLoading }}>
      {children}
    </AuthContext.Provider>
  );
}

export const useAuth = () => useContext(AuthContext);
