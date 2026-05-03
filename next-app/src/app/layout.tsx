import type { Metadata } from "next";
import { League_Spartan } from "next/font/google";
import "./globals.css";
import Navbar from "@/presentation/components/Navbar";
import Footer from "@/presentation/components/Footer";
import ServiceCards from "@/presentation/components/ServiceCards";
import { AuthProvider } from "@/presentation/contexts/auth-context";
import { CartProvider } from "@/presentation/contexts/cart-context";

const leagueSpartan = League_Spartan({
  variable: "--font-league-spartan",
  subsets: ["latin", "vietnamese"],
  weight: ["100", "200", "300", "400", "500", "600", "700", "800", "900"],
});

export const metadata: Metadata = {
  title: {
    default: "Whisk & Flourish",
    template: "%s | Whisk & Flourish",
  },
  description: "Dụng cụ làm bánh chất lượng cao",
  icons: { icon: "/icon.png" },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="vi" className={`${leagueSpartan.variable} h-full antialiased`}>
      <head>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
      </head>
      <body className="min-h-full flex flex-col font-[family-name:var(--font-league-spartan)]">
        <AuthProvider>
          <CartProvider>
            <Navbar />
            <div className="flex-1 bg-[#fbf1f1]">
              <main>{children}</main>
              <ServiceCards />
            </div>
            <Footer />
          </CartProvider>
        </AuthProvider>
      </body>
    </html>
  );
}
