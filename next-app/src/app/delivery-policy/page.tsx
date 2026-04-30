export const metadata = {
  title: "Chính sách giao hàng",
};

export default function DeliveryPolicyPage() {
  return (
    <div className="p-3 sm:p-4 lg:p-8 mt-[30px]">
      <div className="bg-white rounded-[20px] p-[50px]">
        <h2 className="text-2xl font-bold text-center">
          Chính sách giao hàng
        </h2>
        <p className="italic text-center text-gray-500 mb-6">
          Cập nhật ngày 13 tháng 6 năm 2024
        </p>

        <h4 className="text-lg font-semibold mb-2">
          Giao hàng bởi Whisk &amp; Flourish
        </h4>
        <ul className="list-none pl-0 mb-4 space-y-1">
          <li>- Áp dụng tại khu vực nội thành TP. HCM</li>
          <li>
            - Phí áp dụng:{" "}
            <span className="font-bold text-red-600">10.000 ₫</span>
          </li>
          <li>- Giao hàng trong ngày.</li>
          <li>
            - Khung giờ giao hàng từ{" "}
            <span className="font-bold text-red-600">09:00 đến 21:00</span> mỗi
            ngày.
          </li>
        </ul>

        <h4 className="text-lg font-semibold mb-2">
          Giao hàng bởi dịch vụ chuyển phát bên thứ ba
        </h4>
        <ul className="list-none pl-0 mb-4 space-y-1">
          <li>- Áp dụng cho các khu vực khác.</li>
          <li>
            - Phí áp dụng: từ{" "}
            <span className="font-bold text-red-600">
              21.000 đến 35.000 ₫
            </span>{" "}
            tuỳ nhà vận chuyển.
          </li>
          <li>
            - Giao hàng từ{" "}
            <span className="font-bold text-red-600">2 đến 5 ngày</span>.
          </li>
        </ul>

        <h4 className="text-lg font-semibold mb-2">Cước phí áp dụng</h4>
        <div className="overflow-x-auto mb-6">
          <table className="w-full border-collapse my-4">
            <thead>
              <tr>
                <th className="border border-gray-300 bg-gray-100 p-2 text-left">
                  Tỉnh
                </th>
                <th className="border border-gray-300 bg-gray-100 p-2 text-left">
                  Khu vực
                </th>
                <th className="border border-gray-300 bg-gray-100 p-2 text-left">
                  Cước phí áp dụng
                </th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td className="border border-gray-300 p-2">Tp. HCM</td>
                <td className="border border-gray-300 p-2">
                  Quận 1, 2, 3, 4, 5, 6, 7, 8, 10, 11, 12, Tân Bình, Tân Phú,
                  Gò Vấp, Hóc Môn, Bình Thạnh, Bình Tân
                </td>
                <td className="border border-gray-300 p-2 text-right">
                  10.000 ₫
                </td>
              </tr>
              <tr>
                <td className="border border-gray-300 p-2">Tp. HCM</td>
                <td className="border border-gray-300 p-2">
                  Quận 9, Thủ Đức, Củ Chi, Nhà Bè, Cần Giờ, Bình Chánh
                </td>
                <td className="border border-gray-300 p-2 text-right">
                  21.000 ₫
                </td>
              </tr>
              <tr>
                <td className="border border-gray-300 p-2">Bình Dương</td>
                <td className="border border-gray-300 p-2">
                  Thủ Dầu Một, Dĩ An, Thuận An
                </td>
                <td className="border border-gray-300 p-2 text-right">
                  27.000 ₫
                </td>
              </tr>
              <tr>
                <td className="border border-gray-300 p-2">Long An</td>
                <td className="border border-gray-300 p-2">Đức Hoà</td>
                <td className="border border-gray-300 p-2 text-right">
                  30.000 ₫
                </td>
              </tr>
              <tr>
                <td className="border border-gray-300 p-2">Tây Ninh</td>
                <td className="border border-gray-300 p-2">Trảng Bàng</td>
                <td className="border border-gray-300 p-2 text-right">
                  30.000 ₫
                </td>
              </tr>
              <tr>
                <td className="border border-gray-300 p-2">Đồng Nai</td>
                <td className="border border-gray-300 p-2">Biên Hoà</td>
                <td className="border border-gray-300 p-2 text-right">
                  30.000 ₫
                </td>
              </tr>
              <tr>
                <td className="border border-gray-300 p-2">Tỉnh khác</td>
                <td className="border border-gray-300 p-2">-</td>
                <td className="border border-gray-300 p-2 text-right">
                  35.000 ₫
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <h4 className="text-lg font-semibold mb-2">Quy cách niêm phong</h4>
        <ul className="list-none pl-0 mb-4 space-y-1">
          <li>
            - Tất cả hàng hoá Whisk &amp; Flourish gửi qua đơn vị vận chuyển
            bên thứ ba đều được cân trọng lượng, dán niêm phong trước khi gửi.
          </li>
          <li>
            - Trọng lượng của hàng gửi bao gồm cả vỏ hộp, được ghi rõ trên vỏ
            hộp bằng bút dạ ghi bảng.
          </li>
          <li>
            - Giấy niêm phong có đóng dấu tròn của Công ty hoặc dán băng dính
            có thương hiệu Whisk &amp; Flourish.
          </li>
          <li>
            - Trong trường hợp Quý khách hàng phát hiện thấy giấy niêm phong đã
            bị rách, hoặc có dấu hiệu bị mở trước đó và hoặc hàng (bao gồm cả
            vỏ hộp) không đủ trọng lượng được ghi trên vỏ hộp:
            <ul className="pl-5 mt-1 space-y-1">
              <li>+ Quý khách lập biên bản ngay với vận chuyển.</li>
              <li>
                + Thông báo ngay cho nhân viên kinh doanh Whisk &amp; Flourish
                để có hướng giải quyết kịp thời.
              </li>
            </ul>
          </li>
          <li>
            - Chậm nhất là{" "}
            <span className="font-bold text-red-600">2 ngày</span> kể từ khi
            hàng về đến nơi theo yêu cầu của Quý khách hàng, nếu Quý khách hàng
            không phản hồi thông tin cho Whisk &amp; Flourish thì Whisk &amp;
            Flourish coi như Quý khách hàng đã nhận đúng, đủ hàng theo thoả
            thuận.
          </li>
        </ul>

        <h4 className="text-lg font-semibold mb-2">Liên hệ</h4>
        <p>
          Để biết thêm thông tin chi tiết, vui lòng liên hệ với chúng tôi qua:
        </p>
        <ul className="list-none pl-0 mb-4 space-y-1">
          <li>
            Hotline:{" "}
            <span className="font-bold text-red-600">0123 456 789</span>
          </li>
          <li>
            Email:{" "}
            <a
              href="mailto:contact@whiskflourish.vn"
              className="font-bold text-red-600 hover:underline"
            >
              contact@whiskflourish.vn
            </a>
          </li>
        </ul>
        <p>Whisk &amp; Flourish trân trọng cảm ơn!</p>
      </div>
    </div>
  );
}
