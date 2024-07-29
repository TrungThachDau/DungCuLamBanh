import React from "react";
const Footer = () => {
    const currentYear = new Date().getFullYear();
    return (
        <div>
            <div>
                <div className="row" style={{padding:"15px"}}>
                    <a>Bản quyền thuộc về © {currentYear} Whisk & Flourish. Mọi quyền được bảo lưu.</a>
                </div>
                <div className="row" style={{padding:"15px"}}>
                    <div className="col-md-3 supportlink">
                        <p><b>VỀ CHÚNG TÔI</b></p>
                        <p><a>Công ty TNHH Whisk Flourish</a></p>
                        <p>Địa chỉ: 123 Đồng Khởi, Bến Nghé, Quận 1, Sài Gòn</p>
                        <p>Email: contact@whiskflourish.vn</p>
                    </div>

                    <div className="col-md-3 supportlink">
                        <p><b>HỖ TRỢ</b></p>
                        <p><a>Chính sách giao hàng</a></p>
                        <p><a>Chính sách thành viên</a></p>
                        <p><a>Chính sách đổi trả</a></p>
                        <p><a>Chính sách bảo mật</a></p>
                    </div>

                    <div className="col-md-4 supportlink">
                        <p><b>HỆ THỐNG CỬA HÀNG TẠI SÀI GÒN</b></p>
                        <p><a href="https://maps.app.goo.gl/xtiAttc63AopQHxn7">123 Đ. Đồng Khởi, Bến Nghé, Quận 1</a></p>
                        <p><a href="https://maps.app.goo.gl/ud2mAVRfThp4ryAq6">66 Đ. Song Hành, An Phú, Quận 2</a></p>
                        <p><a href="https://maps.app.goo.gl/NQLeHTGbko2pkNjP8">17 Đ. Đồng Xoài, Phường 13, Tân Bình</a></p>
                        <p><a href="https://maps.app.goo.gl/GugywubpmNcgGxvb6">82 Đ. Chợ Lớn, Bình Phú, Quận 6</a></p>
                    </div>
                    <div className="col-md-2">
                        <img src="~/B_cong_th_ng_2.png" className="rounded float-start" width="200px" alt="Logo" />
                        <img src="~/logo/logodai.png" height="40px" alt="Logo" />
                    </div>
                </div>
            </div>
        </div>
    );
};

export default Footer;
