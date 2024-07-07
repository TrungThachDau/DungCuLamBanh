function updateCartBadge() {
    $.ajax({
        url: '/Cart/GetCartItemCount',
        type: 'GET',
        success: function (result) {
            if (result.success) {
                var itemCount = result.dem;
                // Cập nhật tổng tiền trên trang
                $('#badgeCount').text(itemCount);
            }
        }

    });
}
function updateMiniCart() {
    // Cập nhật giỏ hàng mini
    var uid = $('#uid').val();
    miniCart(uid);

}
function miniCart(uid) {
    var url = '/api/cart/' + uid;
    $.ajax({
        url: url,
        type: 'GET',
        dataType: 'json',
        success: function (data) {
            if (data.length > 0) {
                var productList = $('#product-list');
                productList.empty(); // Xóa bỏ bất kỳ nội dung nào đã tồn tại

                // Lặp qua mỗi sản phẩm và thêm vào danh sách
                $.each(data, function (index, product) {
                    var productHtml = '<tr class="product">';
                    productHtml += '<td style="font-size:11px;width:70%">' + product.dungCu.tenDungCu + '</td>';
                    productHtml += '<td style="font-size:11px;text-align: right;width:20%;">x' + product.soLuong + '</td>';
                    productHtml += '<td style="font-size:11px;text-align: right">' + product.donGia.toLocaleString('vi-VN') + '₫' + '</td>';
                    // Thêm nhiều thông tin khác tại đây nếu cần
                    productHtml += '</tr>';

                    productList.append(productHtml);
                });
            } else {
                $('#product-list').html('<a>Giỏ hàng trống</a>');
            }
        },
        error: function () {
            $('#product-list').html('<a>Giỏ hàng trống</a>');
        }

    });
}