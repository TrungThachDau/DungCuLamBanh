
window.addEventListener('beforeunload', (event) => {
    const username = 'a';
    const logMessage = 'Closed tab';
    console.log(logMessage);
    // Sử dụng fetch để gửi dữ liệu
    fetch('goodsreceipt/checktabs', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            username: username,
            command: logMessage
        }),
        keepalive: true // Thêm keepalive để đảm bảo yêu cầu được gửi ngay cả khi tab đang đóng
    });
});



