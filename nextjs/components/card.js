// app/components/card.js
import React from 'react';

const Card = ({ products }) => {
    return (
        <div className="row">
            {products.map((product) => (
                <div key={product.id} className="col-md-4">
                    <div className="card mb-4 shadow-sm">
                        <img src={product.hinhAnh} className="card-img-top" alt={product.name} />
                        <div className="card-body">
                            <h5 className="card-title">{product.tenSanPham}</h5>
                            <p className="card-text">{product.description}</p>
                            <p className="card-text">Price: ${product.gia}</p>
                        </div>
                    </div>
                </div>
            ))}
        </div>
    );
};

export default Card;
