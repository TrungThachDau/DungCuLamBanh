"use client";

import { createContext, useContext, useState, useEffect, useCallback, ReactNode } from "react";
import { useAuth } from "./auth-context";
import { cartApi } from "@/infrastructure/api";

interface CartContextType {
  itemCount: number;
  addItem: (productId: number, quantity: number) => Promise<void>;
  refreshCount: () => void;
}

const CartContext = createContext<CartContextType>({
  itemCount: 0,
  addItem: async () => { },
  refreshCount: () => { },
});

export function CartProvider({ children }: { children: ReactNode }) {
  const { token, ensureAuth } = useAuth();
  const [itemCount, setItemCount] = useState(0);

  const refreshCount = useCallback(() => {
    if (token) {
      cartApi.getItemCount(token).then((r) => setItemCount(r.count)).catch(() => { });
    } else {
      setItemCount(0);
    }
  }, [token]);

  useEffect(() => {
    refreshCount();

    const onCartUpdate = () => {
      const currentToken = localStorage.getItem("token");
      if (currentToken) {
        cartApi.getItemCount(currentToken).then((r) => setItemCount(r.count)).catch(() => { });
      }
    };
    window.addEventListener("cart-updated", onCartUpdate);
    return () => window.removeEventListener("cart-updated", onCartUpdate);
  }, [refreshCount]);

  const addItem = useCallback(async (productId: number, quantity: number) => {
    const authToken = await ensureAuth();
    await cartApi.addItem(authToken, productId, quantity);
    window.dispatchEvent(new Event("cart-updated"));
  }, [ensureAuth]);

  return (
    <CartContext.Provider value={{ itemCount, addItem, refreshCount }}>
      {children}
    </CartContext.Provider>
  );
}

export const useCart = () => useContext(CartContext);
