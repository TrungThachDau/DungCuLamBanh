export const metadata = {
  title: "Chính sách đổi hàng",
};

export default function ExchangePolicyPage() {
  return (
    <div className="p-3 sm:p-4 lg:p-8 mt-[30px]">
      <div className="bg-white rounded-[20px] p-5">
        <h2 className="text-2xl font-bold text-center">
          Chính sách đổi hàng
        </h2>
        <p className="italic text-center text-gray-500 mb-6">
          Cập nhật ngày 13 tháng 6 năm 2024
        </p>

        <h3 className="text-xl font-semibold mb-2">
          1. Điều kiện đổi trả hàng
        </h3>
        <ul className="list-disc pl-5 mb-4 space-y-2">
          <li>
            <strong>Sản phẩm lỗi hoặc hư hỏng:</strong> Nếu sản phẩm quý khách
            nhận được bị lỗi hoặc hư hỏng do nhà sản xuất hoặc trong quá trình
            vận chuyển, chúng tôi sẽ chấp nhận đổi hàng.
          </li>
          <li>
            <strong>Sản phẩm không đúng như mô tả:</strong> Nếu sản phẩm nhận
            được không đúng như thông tin đã mô tả trên website, quý khách có thể
            yêu cầu đổi.
          </li>
          <li>
            <strong>Thời gian đổi trả:</strong> Yêu cầu đổi trả phải được thực
            hiện trong vòng 7 ngày kể từ ngày quý khách nhận được hàng. Vui lòng
            giữ lại hoá đơn kèm bưu kiện vận chuyển.
          </li>
          <li>
            <strong>Tình trạng sản phẩm:</strong> Sản phẩm phải còn nguyên vẹn,
            chưa qua sử dụng và còn đầy đủ các phụ kiện, tem, nhãn mác kèm theo
            (nếu có).
          </li>
        </ul>

        <h3 className="text-xl font-semibold mb-2">
          2. Chính sách đổi hàng
        </h3>
        <ul className="list-disc pl-5 mb-4 space-y-2">
          <li>
            Rất tiếc chúng tôi không hỗ trợ trả hàng hoàn tiền nếu không thuộc
            các điều kiện ở phía trên.
          </li>
          <li>
            Khách hàng có thể đổi sang sản phẩm khác có giá trị bằng giá trị đơn
            hàng hoặc lớn hơn.
          </li>
          <li>
            Vui lòng mang sản phẩm đến các cửa hàng của chúng tôi để được hỗ trợ
            trong vòng 7 ngày.
          </li>
        </ul>

        <h3 className="text-xl font-semibold mb-2">
          3. Quy trình đổi trả hàng
        </h3>
        <ol className="list-decimal pl-5 mb-4 space-y-3">
          <li>
            <strong>Liên hệ với bộ phận chăm sóc khách hàng:</strong>
            <ul className="list-disc pl-5 mt-1 space-y-1">
              <li>
                Gọi điện thoại hoặc gửi email đến bộ phận chăm sóc khách hàng
                của chúng tôi để thông báo về yêu cầu đổi trả.
              </li>
              <li>
                Cung cấp mã đơn hàng và lý do đổi trả để chúng tôi có thể xử lý
                nhanh chóng và chính xác.
              </li>
            </ul>
          </li>
          <li>
            <strong>Chuẩn bị sản phẩm và gửi trả:</strong>
            <ul className="list-disc pl-5 mt-1 space-y-1">
              <li>
                Đóng gói sản phẩm cần đổi trả kèm theo hóa đơn mua hàng và
                phiếu bảo hành (nếu có).
              </li>
              <li>
                Gửi sản phẩm đến địa chỉ của chúng tôi theo hướng dẫn của bộ
                phận chăm sóc khách hàng.
              </li>
            </ul>
          </li>
          <li>
            <strong>Kiểm tra và xử lý đổi trả:</strong>
            <ul className="list-disc pl-5 mt-1 space-y-1">
              <li>
                Sau khi nhận được sản phẩm gửi trả, chúng tôi sẽ kiểm tra tình
                trạng sản phẩm và xác nhận yêu cầu đổi trả.
              </li>
              <li>
                Nếu sản phẩm đủ điều kiện đổi trả, chúng tôi sẽ tiến hành gửi
                sản phẩm mới hoặc hoàn tiền cho quý khách theo yêu cầu.
              </li>
            </ul>
          </li>
        </ol>

        <h3 className="text-xl font-semibold mb-2">3. Chính sách hoàn tiền</h3>
        <ul className="list-disc pl-5 mb-4 space-y-2">
          <li>
            <strong>Hoàn tiền trực tiếp tại cửa hàng:</strong> Chúng tôi sẽ hoàn
            tiền trực tiếp tại cửa hàng của Whisk &amp; Flourish. Quý khách có
            thể đến cửa hàng để nhận lại số tiền đã thanh toán.
          </li>
          <li>
            <strong>Hoàn tiền qua tài khoản ngân hàng:</strong> Khách hàng cần
            cung cấp tài khoản ngân hàng khi liên hệ đổi trả và chúng tôi sẽ
            hoàn tiền vào tài khoản của quý khách.
          </li>
          <li>
            <strong>Thời gian hoàn tiền:</strong> Quá trình hoàn tiền có thể mất
            từ 5-7 ngày làm việc kể từ khi chúng tôi xác nhận sản phẩm đủ điều
            kiện đổi trả.
          </li>
        </ul>

        <h3 className="text-xl font-semibold mb-2">4. Phí đổi trả</h3>
        <ul className="list-disc pl-5 mb-4 space-y-2">
          <li>
            <strong>
              Đối với sản phẩm lỗi, hư hỏng hoặc không đúng mô tả:
            </strong>{" "}
            Chúng tôi sẽ chịu hoàn toàn chi phí vận chuyển đổi trả.
          </li>
          <li>
            <strong>Đối với các trường hợp đổi trả khác:</strong> Chúng tôi
            không hỗ trợ đổi trả.
          </li>
        </ul>

        <h3 className="text-xl font-semibold mb-2">5. Liên hệ</h3>
        <p>
          Nếu quý khách có bất kỳ thắc mắc hoặc cần hỗ trợ, vui lòng liên hệ
          với chúng tôi qua:
        </p>
        <ul className="list-disc pl-5 mb-4">
          <li>
            <strong>Email:</strong>{" "}
            <a
              href="mailto:contact@whiskflourish.vn"
              className="text-blue-600 hover:underline"
            >
              contact@whiskflourish.vn
            </a>
          </li>
        </ul>
        <p>
          Chúng tôi luôn sẵn sàng hỗ trợ và đảm bảo quý khách có trải nghiệm
          mua sắm tốt nhất tại Whisk &amp; Flourish.
        </p>
        <p className="text-gray-500 italic mt-4">
          Cảm ơn quý khách đã tin tưởng và ủng hộ!
        </p>
      </div>
    </div>
  );
}
