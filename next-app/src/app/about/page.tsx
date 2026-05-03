import Image from "next/image";

export const metadata = {
  title: "Giới thiệu",
};

export default function AboutPage() {
  return (
    <div className="p-3 sm:p-4 lg:p-8 mt-[50px]">
      <div className="bg-white rounded-[20px] p-[60px]">
        <Image
          src="/logo.svg"
          alt="Whisk & Flourish"
          width={200}
          height={60}
          quality={15}
          className="mb-4"
        />
        <header>
          <h1 className="text-2xl font-bold mb-4">
            Chào mừng bạn đến với Whisk &amp; Flourish
          </h1>
        </header>
        <section className="mb-6">
          <p>
            Chào mừng bạn đến với <strong>Whisk &amp; Flourish</strong>, cửa
            hàng chuyên cung cấp các dụng cụ làm bánh chất lượng cao tại Việt
            Nam! Tại đây, chúng tôi tự hào mang đến cho bạn một thế giới đầy
            màu sắc của khuôn mẫu, máy trộn, và nguyên liệu làm bánh, tất cả
            đều được chọn lọc kỹ càng để phục vụ mọi nhu cầu từ cơ bản đến
            chuyên nghiệp. Dù bạn là người mới bắt đầu hay đã là một đầu bếp
            kỳ cựu, <strong>Whisk &amp; Flourish</strong> luôn sẵn sàng hỗ trợ
            bạn trên hành trình tạo ra những tác phẩm bánh ngọt tuyệt vời. Ghé
            thăm chúng tôi để trải nghiệm sự đa dạng sản phẩm và dịch vụ tận
            tâm ngay hôm nay!
          </p>
        </section>
        <section className="mb-6">
          <h3 className="text-xl font-semibold mb-2">
            Thông tin về chúng tôi
          </h3>
          <p>Công ty TNHH Whisk &amp; Flourish</p>
          <p>
            Địa chỉ: 123 Đường Đồng Khởi, Phường Bến Nghé, Quận 1, TP. HCM
          </p>
          <p>Giấy phép đăng ký kinh doanh số: 302302130210</p>
        </section>
        <section className="mb-6">
          <h4 className="text-lg font-semibold mb-2">Liên hệ chúng tôi</h4>
          <p>Điện thoại: 0123 456 789</p>
          <p>
            Email:{" "}
            <a
              href="mailto:contact@whiskflourish.vn"
              className="text-blue-600 hover:underline"
            >
              contact@whiskflourish.vn
            </a>
          </p>
        </section>
        <section>
          <h4 className="text-lg font-semibold mb-2">
            Hệ thống cửa hàng ở Sài Gòn
          </h4>
          <p>
            <strong>Cửa hàng 1: </strong>
            <a
              href="https://maps.app.goo.gl/xtiAttc63AopQHxn7"
              target="_blank"
              rel="noopener noreferrer"
              className="text-blue-600 hover:underline"
            >
              123 Đường Đồng Khởi, Phường Bến Nghé, Quận 1
            </a>
          </p>
          <p>
            <strong>Cửa hàng 2: </strong>
            <a
              href="https://maps.app.goo.gl/ud2mAVRfThp4ryAq6"
              target="_blank"
              rel="noopener noreferrer"
              className="text-blue-600 hover:underline"
            >
              66 Đường Song Hành Xa Lộ, Phường An Phú, Quận 2, Thành phố Thủ
              Đức
            </a>
          </p>
          <p>
            <strong>Cửa hàng 3: </strong>
            <a
              href="https://maps.app.goo.gl/NQLeHTGbko2pkNjP8"
              target="_blank"
              rel="noopener noreferrer"
              className="text-blue-600 hover:underline"
            >
              17 Đường Đồng Xoài, Phường 13, Quận Tân Bình
            </a>
          </p>
          <p>
            <strong>Cửa hàng 4: </strong>
            <a
              href="https://maps.app.goo.gl/GugywubpmNcgGxvb6"
              target="_blank"
              rel="noopener noreferrer"
              className="text-blue-600 hover:underline"
            >
              82 Đường Chợ Lớn, Phường Bình Phú, Quận 6
            </a>
          </p>
        </section>
      </div>
    </div>
  );
}
