import React from "react";
import Head from "next/head";
import Image from "next/image";

export const metadata = {
    title: "About Us",
    description: "Learn more about our company and team.",
};


export default function About() {
    return (
        <main>
            <div className="container">
                <h1>About</h1>
                <p>
                    This is the about page. You can edit this page in{" "}
                    <code>app/home/about/page.js</code>.
                </p>
                <p>
                    The layout for this page is defined in{" "}
                    <code>app/layout.js</code>.
                </p>
                <p>
                    To add a new page, simply create a new directory in{" "}
                    <code>app</code> and add a <code>page.js</code> file.
                </p>
            </div>
        </main>
    );
}
