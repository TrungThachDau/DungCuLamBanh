import Link from "next/link";
import Image from "next/image";

export default function Footer() {
  return (
    <footer className="bg-white">
      <div className="p-3 sm:p-4 lg:p-8">
        <div className="mb-4" style={{ padding: 15 }}>
          <span>Bản quyền thuộc về © {new Date().getFullYear()} Whisk & Flourish. Mọi quyền được bảo lưu.</span>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-12 gap-6" style={{ padding: 15 }}>
          <div className="md:col-span-3">
            <p><b>VỀ CHÚNG TÔI</b></p>
            <p>Công ty TNHH Whisk Flourish</p>
            <p>Địa chỉ: 123 Đồng Khởi, Bến Nghé, Quận 1, Sài Gòn</p>
            <p>Email: contact@whiskflourish.vn</p>
          </div>
          <div className="md:col-span-3">
            <p><b>HỖ TRỢ</b></p>
            <p className="hover:underline"><Link href="/delivery-policy" className="text-black no-underline">Chính sách giao hàng</Link></p>
            <p className="hover:underline"><Link href="/membership-policy" className="text-black no-underline">Chính sách thành viên</Link></p>
            <p className="hover:underline"><Link href="/exchange-policy" className="text-black no-underline">Chính sách đổi trả</Link></p>
            <p className="hover:underline"><Link href="/privacy" className="text-black no-underline">Chính sách bảo mật</Link></p>
          </div>
          <div className="md:col-span-4">
            <p><b>HỆ THỐNG CỬA HÀNG TẠI SÀI GÒN</b></p>
            <p className="hover:underline"><a href="https://maps.app.goo.gl/xtiAttc63AopQHxn7" target="_blank" rel="noopener noreferrer" className="text-black no-underline">123 Đ. Đồng Khởi, Bến Nghé, Quận 1</a></p>
            <p className="hover:underline"><a href="https://maps.app.goo.gl/ud2mAVRfThp4ryAq6" target="_blank" rel="noopener noreferrer" className="text-black no-underline">66 Đ. Song Hành, An Phú, Quận 2</a></p>
            <p className="hover:underline"><a href="https://maps.app.goo.gl/NQLeHTGbko2pkNjP8" target="_blank" rel="noopener noreferrer" className="text-black no-underline">17 Đ. Đồng Xoài, Phường 13, Tân Bình</a></p>
            <p className="hover:underline"><a href="https://maps.app.goo.gl/GugywubpmNcgGxvb6" target="_blank" rel="noopener noreferrer" className="text-black no-underline">82 Đ. Chợ Lớn, Bình Phú, Quận 6</a></p>
          </div>
          <div className="md:col-span-2">
            <Image src="/bo-cong-thuong.png" alt="Bộ Công Thương" width={200} height={76} quality={15} className="rounded w-[200px] mb-2" />
            <Image src="/logodai.png" alt="Whisk & Flourish" width={280} height={40} quality={15} className="h-10 w-auto" />
          </div>
        </div>
      </div>
    </footer>
  );
}
