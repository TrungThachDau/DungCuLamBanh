export default function ServiceCards() {
  const services = [
    { img: "/customer-service.png", title: "Liên hệ với chúng tôi", desc: "+84 369 132 321" },
    { img: "/delivery-truck.png", title: "Giao hàng toàn quốc", desc: "63 tỉnh thành tối đa 5 ngày" },
    { img: "/dairy-products.png", title: "Sản phẩm chất lượng", desc: "An toàn, xuất xứ rõ ràng" },
    { img: "/price-tag.png", title: "Giá cả, ưu đãi tốt", desc: "Tích điểm trên mỗi đơn hàng" },
  ];

  return (
    <div className="p-3 sm:p-4 lg:p-8">
      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-5">
        {services.map((item) => (
          <div key={item.title} className="bg-white rounded-[20px] mb-5">
            <div className="p-4">
              <div className="flex items-center gap-0">
                <div className="w-1/3 flex-shrink-0">
                  <img src={item.img} alt="" className="rounded w-[70px]" />
                </div>
                <div className="w-2/3">
                  <span className="text-xs">{item.title}</span><br />
                  <span className="text-xs text-gray-500">{item.desc}</span>
                </div>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
