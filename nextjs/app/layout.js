import React from "react";
import "bootstrap/dist/css/bootstrap.min.css";
import Script from "next/script";
import Navbar from "@/component/layout/navbar";
import Footer from "@/component/layout/footer";
export const metadata = {
  title: "Whisk and Flourish",
  description: "Whisk and Flourish",
};

export default function RootLayout({ children }) {
  return (
      <html lang="en">
      <head>
          <title></title>
          <link
                rel="stylesheet"
                href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
            />
      </head>
      <body>
        <Navbar />
      <div>
          {children}
      </div>
        <Footer/>
        <Script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossOrigin="anonymous"
            strategy="afterInteractive"
        />
      </body>
      
      </html>
  );
}
