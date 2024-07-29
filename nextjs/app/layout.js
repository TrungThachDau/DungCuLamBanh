import Head from 'next/head';
import Script from "next/script";
import Navbar from "../components/Navbar";
import React from "react";
import styles from "../app/page.module.css";
import Footer from "../components/footer";
export default function RootLayout({ children }) {
    return (
        <html lang="en">
        <head>
            <meta charSet="UTF-8"/>
            <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
            <link
                rel="stylesheet"
                href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
            />
            <link
                href="https://fonts.googleapis.com/css2?family=League+Spartan:wght@100..900&display=swap"
                rel="stylesheet"
            />
            <link
                rel="stylesheet"
                href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"
            />
        </head>
        <body>
        <Navbar/>
        <div className={`container-fluid ${styles.mainBody}`}>
            <div>
                <main role={"main"} className={"pb3 container-fluid"}>
                    {children}
                </main>
            </div>
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
