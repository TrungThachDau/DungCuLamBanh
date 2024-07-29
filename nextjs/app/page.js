// app/page.js
import Image from "next/image";
import React from "react";
import Card from "../components/card";
import { getAllProduct } from "@/services/product";
import { notFound } from "next/navigation";

export const metadata = {
    title: "Home",
    description: "Welcome to our website.",
}

export default async function Home() {
    const products = await getAllProduct();
    if (!products) return notFound();

    return (
        <main>
            <div className="container">
                <h1>Home</h1>
                <p>This is the home page. You can edit this page in <code>app/home/page.js</code>.</p>
                <p>The layout for this page is defined in <code>app/layout.js</code>.</p>
                <p>To add a new page, simply create a new directory in <code>app</code> and add a <code>page.js</code> file.</p>
            </div>
            <div className={"p-3 p-sm-4 p-lg-5"} style={{ paddingTop: "0" }}>
                <div className="row">
                    <div id="carouselExample" className="carousel slide">
                        <div className="carousel-inner">
                            <div className="carousel-item active">
                                <img
                                    src="https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/Pink%20and%20Brown%20Cute%20Opening%20Soon%20Banner.gif?alt=media&token=67a067f5-7ba9-4240-a4bc-8049db56ab5a"
                                    className="d-block w-100" alt="..."/>
                            </div>
                            <div className="carousel-item">
                                <img src="..." className="d-block w-100" alt="..."/>
                            </div>
                            <div className="carousel-item">
                                <img src="..." className="d-block w-100" alt="..."/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div style={{ backgroundColor: "white", borderRadius: "20px", marginTop: "30px", padding: "20px" }}>
                <div className="row" style={{ textAlign: "center" }}>
                    <h3 className="align-center league-spartan">GIẢM GIÁ DÀNH CHO BẠN</h3>
                </div>
                <div className={"card-container align-center"}>
                    <div>
                        <Card products={products}></Card>
                    </div>
                </div>
            </div>
        </main>
    );
}
