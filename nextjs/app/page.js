import React, { Suspense } from 'react';
import Banner from "@/component/banner";
import ListCard from "@/component/listCard";
import {getAllProduct} from "@/services/product";

export default async function Home() {
    const products = await getAllProduct();
    if(!products){
        return <div>Loading...</div>;
    }
    return (
        <main className={"container-fluid"}>
            <div className={"row"}>
                <Banner/>
            </div>
            <div>
                <h1>Sản phẩm dành cho bạn</h1>
                <div>
                    <Suspense fallback={<div>Loading...</div>}></Suspense>
                    <ListCard products={products}></ListCard>
                </div>
            </div>
        </main>
    );
}
