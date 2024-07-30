import React from "react";

const Banner = () => {
    return (
        <div id="carouselExampleIndicators" className="carousel slide">
            <div className="carousel-indicators">
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0"
                        className="active" aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1"
                        aria-label="Slide 2"></button>
            </div>
            <div className="carousel-inner">
                <div className="carousel-item active">
                    <img src="https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/Pink%20and%20Brown%20Cute%20Opening%20Soon%20Banner.gif?alt=media&token=67a067f5-7ba9-4240-a4bc-8049db56ab5a" className="d-block w-100" alt="..."/>
                </div>
                <div className="carousel-item">
                    <img src="https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/images%2FPurple%20and%20Pink%20Pastel%20Cute%20Fashion%20Collection%20Coming%20Soon%20Banner.png?alt=media&token=9241c5d3-a7f0-4ef2-9ed8-74a5911b2392" className="d-block w-100" alt="..."/>
                </div>
            </div>
        </div>
    );
}
export default Banner;