export const metadata = {
  title: "Chương trình thành viên",
};

export default function MembershipPolicyPage() {
  return (
    <div className="p-3 sm:p-4 lg:p-8 mt-[30px]">
      <div className="bg-white rounded-[20px] p-5 pt-8">
        <h2 className="text-2xl font-bold text-center">
          Chương trình thành viên
        </h2>
        <p className="italic text-center text-gray-500 mb-6">
          Cập nhật ngày 13 tháng 6 năm 2024
        </p>

        <h3 className="text-xl font-semibold mb-2">1. Thành viên là gì?</h3>
        <p className="mb-4">
          Thành viên (hay còn gọi là khách hàng thân thiết) là một chương trình
          của Whisk &amp; Flourish tạo ra để mang đến nhiều ưu đãi và quyền lợi
          hấp dẫn dành riêng cho những khách hàng sử dụng dịch vụ của chúng tôi.
          Tài khoản thành viên được quản lý và cập nhật theo email của khách
          hàng.
        </p>

        <h3 className="text-xl font-semibold mb-2">
          2. Làm sao để trở thành thành viên của Whisk &amp; Flourish?
        </h3>
        <p>
          Bạn sẽ là thành viên của Whisk &amp; Flourish ngay sau khi đăng ký tài
          khoản khách hàng trên Website của chúng tôi bằng việc cung cấp:
        </p>
        <p>- Họ tên</p>
        <p>- Số điện thoại</p>
        <p className="mb-4">- Email</p>
        <p className="mb-4">
          Trong các lần mua kế tiếp bạn chỉ cần đăng nhập vào tài khoản đã đăng
          ký trước đó và sử dụng các quyền lợi của thành viên.
        </p>

        <h3 className="text-xl font-semibold mb-2">
          3. Quyền lợi của thành viên gồm những gì?
        </h3>
        <p>- Quý khách sẽ được thông báo các ưu đãi hiện có.</p>
        <p>- Quyền lợi tích lũy điểm mua hàng.</p>
        <p className="mb-4">- Các chương trình khuyến mãi độc quyền khác.</p>

        <h3 className="text-xl font-semibold mb-2">
          4. Tích lũy điểm mua hàng là gì?
        </h3>
        <p>
          Khi sử dụng tài khoản thành viên, các đơn hàng được mua sẽ được chuyển
          10% giá trị đơn hàng thành điểm tích lũy và có thể sử dụng ở lần mua
          hàng tiếp theo.
        </p>
        <p className="mb-4">1 điểm tích lũy tương đương với 1 VND (₫)</p>

        <h3 className="text-xl font-semibold mb-2">
          5. Liên hệ ai khi cần được hỗ trợ?
        </h3>
        <p>
          Nhân viên Whisk &amp; Flourish luôn sẵn sàng hỗ trợ bạn đăng ký thành
          viên, tra cứu chi tiêu tích lũy, và cung cấp các ưu đãi. Hoặc liên hệ
          chúng tôi qua Email:{" "}
          <a
            href="mailto:contact@whiskflourish.vn"
            className="text-blue-600 hover:underline"
          >
            contact@whiskflourish.vn
          </a>{" "}
          bạn nhé!
        </p>

        <p className="text-gray-500 italic mt-6">
          Whisk &amp; Flourish trân trọng cảm ơn!
        </p>
      </div>
    </div>
  );
}
