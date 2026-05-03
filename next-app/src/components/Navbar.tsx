"use client";

import Link from "next/link";
import Image from "next/image";
import { useAuth } from "@/lib/auth-context";
import { useState, useEffect, useCallback, useRef } from "react";
import { useCart } from "@/lib/cart-context";
import { cartApi } from "@/lib/api";
import type { ChiTietDonHangModel } from "@/lib/types";

function formatCurrency(value: number) {
  return value.toLocaleString("vi-VN") + " ₫";
}

export default function Navbar() {
  const { user, token, isAnonymous, signOut } = useAuth();
  const { itemCount: cartCount } = useCart();
  const [menuOpen, setMenuOpen] = useState(false);
  const [searchQuery, setSearchQuery] = useState("");
  const [cartOpen, setCartOpen] = useState(false);
  const [cartItems, setCartItems] = useState<ChiTietDonHangModel[]>([]);
  const [cartLoading, setCartLoading] = useState(false);
  const cartRef = useRef<HTMLDivElement>(null);

  // Close cart popup when clicking outside
  useEffect(() => {
    const handleClickOutside = (e: MouseEvent) => {
      if (cartRef.current && !cartRef.current.contains(e.target as Node)) {
        setCartOpen(false);
      }
    };
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  const loadMiniCart = useCallback(() => {
    if (!token) {
      setCartItems([]);
      return;
    }
    setCartLoading(true);
    cartApi
      .getCart(token)
      .then((res) => {
        if (res.success) setCartItems(res.items);
      })
      .catch(() => setCartItems([]))
      .finally(() => setCartLoading(false));
  }, [token]);

  // Reload mini cart when cart-updated event fires
  useEffect(() => {
    loadMiniCart();
    const onCartUpdate = () => {
      const t = localStorage.getItem("token");
      if (t) {
        cartApi.getCart(t).then((res) => { if (res.success) setCartItems(res.items); }).catch(() => { });
      }
    };
    window.addEventListener("cart-updated", onCartUpdate);
    return () => window.removeEventListener("cart-updated", onCartUpdate);
  }, [loadMiniCart]);

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    if (searchQuery.trim()) {
      window.location.href = `/products?search=${encodeURIComponent(searchQuery)}`;
    }
  };

  return (
    <nav className="bg-white sticky top-0 z-50">
      <div className="max-w-[1400px] mx-auto px-6 lg:px-12">
        <div className="flex items-center justify-between h-20">
          {/* Mobile menu button */}
          <button onClick={() => setMenuOpen(!menuOpen)} className="md:hidden text-gray-800">
            <span className="material-symbols-outlined text-2xl">menu</span>
          </button>

          {/* Logo */}
          <Link href="/" className="flex-shrink-0 ml-6 md:ml-0">
            <Image src="/logo.svg" alt="Whisk & Flourish" width={56} height={56} quality={15} className="h-14 w-auto" />
          </Link>

          {/* Desktop Menu */}
          <div className="hidden md:flex items-center gap-1 flex-1 ml-8">
            {/* Sản phẩm dropdown */}
            <div className="relative group">
              <button className="px-3 py-2 text-black font-bold text-sm flex items-center gap-1">
                Sản phẩm
                <svg className="w-3 h-3 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                  <path fillRule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clipRule="evenodd" />
                </svg>
              </button>
              <div className="absolute left-0 top-full invisible group-hover:visible opacity-0 group-hover:opacity-100 transition-all bg-white border border-gray-200 rounded-[20px] p-3 shadow-lg min-w-[200px] z-50">
                <Link href="/products" className="block px-4 py-2 text-sm text-gray-800 font-bold hover:bg-gray-50 rounded-xl">
                  Tất cả sản phẩm
                </Link>
                <Link href="/products?sortColumn=6" className="block px-4 py-2 text-sm text-gray-800 font-bold hover:bg-gray-50 rounded-xl">
                  Sản phẩm bán chạy
                </Link>
              </div>
            </div>

            <Link href="/promotions" className="px-3 py-2 text-black font-bold text-sm">
              Giảm giá
            </Link>

            <Link href="/tracking" className="px-3 py-2 text-black font-bold text-sm">
              Tra cứu đơn hàng
            </Link>

            {/* Về chúng tôi dropdown */}
            <div className="relative group">
              <button className="px-3 py-2 text-black font-bold text-sm flex items-center gap-1">
                Về chúng tôi
                <svg className="w-3 h-3 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                  <path fillRule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clipRule="evenodd" />
                </svg>
              </button>
              <div className="absolute left-0 top-full invisible group-hover:visible opacity-0 group-hover:opacity-100 transition-all bg-white border border-gray-200 rounded-[20px] p-3 shadow-lg min-w-[200px] z-50">
                <Link href="/gioi-thieu" className="block px-4 py-2 text-sm text-gray-800 font-bold hover:bg-gray-50 rounded-xl">
                  Giới thiệu
                </Link>
                <Link href="/chinh-sach-bao-mat" className="block px-4 py-2 text-sm text-gray-800 font-bold hover:bg-gray-50 rounded-xl">
                  Thông báo bảo mật
                </Link>
                <Link href="/quyen-loi-khach-hang" className="block px-4 py-2 text-sm text-gray-800 font-bold hover:bg-gray-50 rounded-xl">
                  Quyền lợi khách hàng
                </Link>
              </div>
            </div>

            {/* Search */}
            <form onSubmit={handleSearch} className="ml-4">
              <input
                type="text"
                placeholder="Tìm sản phẩm..."
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                className="bg-[#fbf1f1] border-0 rounded-[20px] px-5 py-2 text-sm text-black font-bold placeholder:text-black focus:outline-none w-48 lg:w-56 bg-[length:16px] bg-[10px_center] bg-no-repeat pl-9"
                style={{ backgroundImage: "url(/search.svg)" }}
              />
            </form>
          </div>

          {/* Right Icons */}
          <div className="flex items-center gap-1">
            {/* Notification Bell */}
            <Link href="/notifications" className="w-[50px] h-11 flex items-center justify-center rounded-[20px] text-black hover:bg-gray-100">
              <span className="material-symbols-outlined">notifications</span>
            </Link>

            {/* Cart Popup */}
            <div className="relative" ref={cartRef}>
              <button
                onClick={() => { setCartOpen(!cartOpen); if (!cartOpen) loadMiniCart(); }}
                className="relative w-[50px] h-11 flex items-center justify-center rounded-[20px] text-black hover:bg-gray-100"
              >
                <span className="material-symbols-outlined">shopping_bag</span>
                {cartCount > 0 && (
                  <span className="absolute -top-0.5 -right-0.5 bg-red-500 text-white text-[11px] rounded-full h-[18px] min-w-[18px] flex items-center justify-center px-1">
                    {cartCount}
                  </span>
                )}
              </button>

              {cartOpen && (
                <div className="absolute right-0 top-full mt-2 bg-white border border-gray-100 rounded-2xl shadow-2xl w-[340px] z-50 overflow-hidden">
                  <div className="px-4 py-3 border-b border-gray-100 flex items-center justify-between">
                    <h3 className="font-bold text-sm">Giỏ hàng ({cartCount})</h3>
                    <button onClick={() => setCartOpen(false)} className="text-gray-400 hover:text-gray-600 text-lg leading-none">&times;</button>
                  </div>

                  <div className="max-h-[320px] overflow-y-auto">
                    {cartLoading ? (
                      <div className="flex items-center justify-center py-10">
                        <div className="w-6 h-6 border-2 border-gray-200 border-t-gray-600 rounded-full animate-spin" />
                      </div>
                    ) : cartItems.length > 0 ? (
                      <div className="divide-y divide-gray-50">
                        {cartItems.map((item) => (
                          <div key={item.id_ChiTietDonHang} className="flex gap-3 p-3 hover:bg-gray-50/50 transition-colors">
                            {item.dungCu?.hinhAnh && (
                              <Image
                                src={item.dungCu.hinhAnh}
                                alt={item.dungCu?.tenDungCu || ""}
                                width={56}
                                height={56}
                                quality={15}
                                className="w-14 h-14 rounded-xl object-cover flex-shrink-0 bg-gray-100"
                              />
                            )}
                            <div className="flex-1 min-w-0">
                              <p className="text-sm font-medium text-gray-800 line-clamp-2 leading-tight">
                                {item.dungCu?.tenDungCu}
                              </p>
                              <div className="flex items-center justify-between mt-1.5">
                                <span className="text-xs text-gray-400">SL: {item.soLuong}</span>
                                <span className="text-sm font-bold text-red-500">{formatCurrency(item.donGia)}</span>
                              </div>
                            </div>
                          </div>
                        ))}
                      </div>
                    ) : (
                      <div className="flex flex-col items-center justify-center py-10 text-gray-300">
                        <span className="material-symbols-outlined text-4xl mb-2">shopping_bag</span>
                        <p className="text-sm">Giỏ hàng trống</p>
                      </div>
                    )}
                  </div>

                  <div className="p-3 border-t border-gray-100">
                    <Link
                      href="/cart"
                      onClick={() => setCartOpen(false)}
                      className="block w-full text-center text-sm font-bold bg-[#212631] !text-white py-2.5 rounded-xl no-underline hover:bg-[#343a46] transition-colors"
                    >
                      Xem giỏ hàng
                    </Link>
                  </div>
                </div>
              )}
            </div>

            {/* User */}
            {user && !isAnonymous ? (
              <div className="relative group">
                <button className="w-[50px] h-11 flex items-center justify-center rounded-[20px] text-black hover:bg-gray-100">
                  <span className="material-symbols-outlined">person</span>
                </button>
                <div className="absolute right-0 top-full invisible group-hover:visible opacity-0 group-hover:opacity-100 transition-all bg-white border border-gray-200 rounded-[20px] p-2 shadow-lg min-w-[200px] z-50">
                  <Link href="/account" className="block px-4 py-2 text-sm text-gray-800 hover:bg-gray-50 rounded-xl">
                    Quản lý tài khoản
                  </Link>
                  <Link href="/order-history" className="block px-4 py-2 text-sm text-gray-800 hover:bg-gray-50 rounded-xl">
                    Lịch sử đơn hàng
                  </Link>
                  <button
                    onClick={signOut}
                    className="block w-full text-left px-4 py-2 text-sm text-gray-800 hover:bg-gray-50 rounded-xl"
                  >
                    Đăng xuất
                  </button>
                </div>
              </div>
            ) : (
              <Link href="/sign-in" className="w-[50px] h-11 flex items-center justify-center rounded-[20px] text-black hover:bg-gray-100">
                <span className="material-symbols-outlined">person</span>
              </Link>
            )}
          </div>
        </div>

        {/* Mobile Menu */}
        {menuOpen && (
          <div className="md:hidden pb-4 space-y-2 border-t border-gray-100 pt-4">
            <form onSubmit={handleSearch} className="mb-3">
              <input
                type="text"
                placeholder="Tìm sản phẩm..."
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                className="w-full bg-[#fbf1f1] border-0 rounded-[20px] px-5 py-2.5 text-sm text-black placeholder:text-black focus:outline-none"
              />
            </form>
            <Link href="/products" className="block py-2 text-black font-bold text-sm">Tất cả sản phẩm</Link>
            <Link href="/promotions" className="block py-2 text-black font-bold text-sm">Giảm giá</Link>
            <Link href="/tracking" className="block py-2 text-black font-bold text-sm">Tra cứu đơn hàng</Link>
            <Link href="/gioi-thieu" className="block py-2 text-black font-bold text-sm">Giới thiệu</Link>
          </div>
        )}
      </div>
    </nav>
  );
}
