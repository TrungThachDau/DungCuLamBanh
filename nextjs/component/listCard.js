import React from "react";

const ListCard = ({products}) => {
    return (
        <div className="row row-cols-1 row-cols-md-3 g-4">
            {products.map(product => (
                // eslint-disable-next-line react/jsx-key
                <div className="col" key={product.id}>
                    <div className="card">
                        <img src={product.hinhAnh} className="card-img-top" alt="..."/>
                        <div className="card-body">
                            <h5 className="card-title">{product.tenSanPham}</h5>
                            <p className="card-text">{product.gia}</p>
                        </div>
                    </div>
                </div>
            ))}
        </div>
    );
}
export default ListCard;