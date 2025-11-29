function changeState(dhvc, uid, dh) {
    var selectElement = document.getElementById("TinhTrang_" + dhvc);
    if (selectElement) {
        var value = selectElement.value;
        console.log("DHVC: " + dhvc);
        console.log("Giá trị: " + value);
        console.log("Đơn hàng: " + dh);
        console.log("Khách hàng" + uid);
        var tinhTrang = "";
        if (value == 0) {
            tinhTrang = "đang được chuẩn bị.";
        }
        else if (value == 1) {
            tinhTrang = "đang được giao.";
        }
        else if (value == 2) {
            tinhTrang = "đã được giao thành công.";
        }
        else if (value == 3) {
            tinhTrang = "đã bị hủy.";
        }
        $.ajax({
            url: '/Administrator/ChangeStatus',
            type: "POST",
            data: {
                dhvc: dhvc,
                value: value
            },
            success: function (result) {
                if (result.success) {
                    writeUserData(uid, 'Đơn hàng ' + dh + ' ' + tinhTrang, dh);
                    alert('Thành công');
                } else {
                    alert(result.error);
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.error("AJAX error:", textStatus, errorThrown);
            }
        });
    } else {
        console.error("Cannot find the select element with the given ID: TinhTrang_" + dhvc);
    }
}