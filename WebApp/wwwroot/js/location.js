var citis = document.getElementById("city");
var districts = document.getElementById("district");
var wards = document.getElementById("ward");
var Parameter = {
    url: "https://raw.githubusercontent.com/KhoaLuanTotNghiepHUITK11/WebAppDungCuLamBanh/main/wwwroot/location.json",
    method: "GET",
    responseType: "application/json",
};
var promise = axios(Parameter);
promise.then(function (result) {
    renderCity(result.data);
});


function renderCity(data) {
    // Sắp xếp các thành phố theo tên
    data.sort((a, b) => a.Name.localeCompare(b.Name));

    for (const x of data) {
        citis.options[citis.options.length] = new Option(x.Name, x.Id);
    }

    citis.onchange = function () {
        district.length = 1; // Xóa danh sách quận cũ
        ward.length = 1; // Xóa danh sách phường cũ

        if (this.value != "") {
            const result = data.filter(n => n.Id === this.value);

            // Sắp xếp các quận theo tên
            result[0].Districts.sort((a, b) => a.Name.localeCompare(b.Name));

            for (const k of result[0].Districts) {
                district.options[district.options.length] = new Option(k.Name, k.Id);
            }
        }
    };

    district.onchange = function () {
        ward.length = 1; // Xóa danh sách phường cũ

        if (this.value != "") {
            const dataCity = data.filter(n => n.Id === citis.value);
            const dataWards = dataCity[0].Districts.filter(n => n.Id === this.value)[0].Wards;

            // Sắp xếp các phường theo tên
            dataWards.sort((a, b) => a.Name.localeCompare(b.Name));

            for (const w of dataWards) {
                wards.options[wards.options.length] = new Option(w.Name, w.Id);
            }
        }
    };
}
function updateLink() {
    var citySelect = document.getElementById('city');
    var districtSelect = document.getElementById('district');
    var wardSelect = document.getElementById('ward');
    var streetInput = document.getElementById('street');
    var link = document.getElementById('selectedText');

    var cityText = citySelect.options[citySelect.selectedIndex].text;
    var districtText = districtSelect.options[districtSelect.selectedIndex].text;
    var wardText = wardSelect.options[wardSelect.selectedIndex].text;
    var streetText = streetInput.value;

    // Cập nhật nội dung và href của thẻ <a>
    link.textContent = streetText + ', ' + wardText + ', ' + districtText + ', ' + cityText;
    //Cập nhật nội dung thẻ <input>
     

    link.href = 'https://www.google.com/maps?q=' + encodeURIComponent(streetText) + ',+' + encodeURIComponent(wardText) + ',+' + encodeURIComponent(districtText) + ',+' + encodeURIComponent(cityText);
}

// Thêm sự kiện 'change' cho các thẻ select
document.getElementById('city').addEventListener('change', updateLink);
document.getElementById('district').addEventListener('change', updateLink);
document.getElementById('ward').addEventListener('change', updateLink);
document.getElementById('street').addEventListener('input', updateLink);