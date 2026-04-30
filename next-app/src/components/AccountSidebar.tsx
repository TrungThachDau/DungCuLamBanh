"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";

const menuItems = [
  { href: "/account", label: "Tài khoản" },
  { href: "/order-history", label: "Lịch sử đơn hàng" },
  { href: "/account/change-password", label: "Mật khẩu và bảo mật" },
  { href: "/account/favorites", label: "Sản phẩm yêu thích" },
  { href: "/notifications", label: "Thông báo" },
];

export default function AccountSidebar() {
  const pathname = usePathname();

  return (
    <ul className="space-y-1">
      {menuItems.map((item) => {
        const isActive = pathname === item.href;
        return (
          <li key={item.href}>
            <Link
              href={item.href}
              className={`block px-4 py-3 rounded-[20px] no-underline transition-colors ${isActive
                  ? "bg-[#f8d9d6] font-bold text-[#49130e]"
                  : "bg-[#fbf1f1] text-[#49130e] hover:bg-[#f8d9d6]"
                }`}
            >
              {item.label}
            </Link>
          </li>
        );
      })}
    </ul>
  );
}
