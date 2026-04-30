"use client";

import { useState } from "react";
import { useAuth } from "@/lib/auth-context";
import { useCart } from "@/lib/cart-context";
import { favoriteApi } from "@/lib/api";
import { useRouter } from "next/navigation";

interface Props {
  productId: number;
  inStock: boolean;
}

export default function AddToCartSection({ productId, inStock }: Props) {
  const { token } = useAuth();
  const { addItem } = useCart();
  const router = useRouter();
  const [quantity, setQuantity] = useState(1);
  const [loading, setLoading] = useState(false);
  const [message, setMessage] = useState<{ type: "success" | "error"; text: string } | null>(null);

  const handleAddToCart = async () => {
    setLoading(true);
    setMessage(null);

    try {
      await addItem(productId, quantity);
      setMessage({ type: "success", text: "Đã thêm vào giỏ hàng!" });
    } catch (err) {
      setMessage({ type: "error", text: err instanceof Error ? err.message : "Lỗi khi thêm vào giỏ" });
    } finally {
      setLoading(false);
    }
  };

  const handleToggleFavorite = async () => {
    if (!token) {
      router.push("/sign-in");
      return;
    }

    try {
      await favoriteApi.add(token, productId);
      setMessage({ type: "success", text: "Đã thêm vào yêu thích!" });
    } catch {
      setMessage({ type: "error", text: "Lỗi khi thêm yêu thích" });
    }
  };

  return (
    <div className="space-y-4">
      {/* Quantity + Add to Cart - same row like MVC */}
      <div className="flex items-stretch gap-3">
        <div className="flex items-center border rounded-[20px] overflow-hidden">
          <button
            onClick={() => setQuantity(Math.max(1, quantity - 1))}
            className="px-3 py-2 text-black hover:bg-gray-100 font-bold"
          >
            -
          </button>
          <input
            type="number"
            value={quantity}
            onChange={(e) => setQuantity(Math.max(1, Math.min(5, parseInt(e.target.value) || 1)))}
            min={1}
            max={5}
            className="w-12 text-center border-x py-2 text-sm focus:outline-none"
          />
          <button
            onClick={() => setQuantity(Math.min(5, quantity + 1))}
            className="px-3 py-2 text-black hover:bg-gray-100 font-bold"
          >
            +
          </button>
        </div>

        <button
          onClick={handleAddToCart}
          disabled={!inStock || loading}
          className={`flex-1 rounded-[20px] font-bold text-sm transition-colors ${inStock
              ? "bg-[#212631] text-white hover:bg-[#343a46]"
              : "bg-gray-300 text-gray-500 cursor-not-allowed"
            }`}
        >
          {loading ? "Đang thêm..." : inStock ? "Thêm vào giỏ" : "Đã bán hết"}
        </button>
      </div>

      {/* Favorite button */}
      <div>
        <button
          onClick={handleToggleFavorite}
          className="bg-[#212631] text-white rounded-[20px] px-5 py-2 text-sm font-bold hover:bg-[#343a46] inline-flex items-center gap-2"
        >
          <span>♡</span>
          <span>Yêu thích</span>
        </button>
      </div>

      {/* Message Toast */}
      {message && (
        <div
          className={`text-sm px-4 py-2 rounded-[20px] ${message.type === "success" ? "bg-green-50 text-green-700" : "bg-red-50 text-red-700"
            }`}
        >
          {message.text}
        </div>
      )}
    </div>
  );
}
