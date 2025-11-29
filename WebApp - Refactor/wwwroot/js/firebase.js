import { initializeApp } from 'https://www.gstatic.com/firebasejs/10.12.2/firebase-app.js'
import { getDatabase, ref, push, set } from "https://www.gstatic.com/firebasejs/10.12.2/firebase-database.js";

const firebaseConfig = {
    databaseURL: "https://qldclb-770f5-default-rtdb.asia-southeast1.firebasedatabase.app/",
};

const app = initializeApp(firebaseConfig);
const database = getDatabase(app);

// Định nghĩa hàm và gán nó vào phạm vi global
window.writeUserData = function (userId, message, link) {
    var time = new Date().getTime();
    push(ref(database, 'notification'), {
        uid: userId,
        message: message,
        link: link,
        time: time

    })
        .then(() => {
            console.log("Dữ liệu đã được lưu thành công!");
        })
        .catch((error) => {
            console.error("Lỗi khi lưu dữ liệu: ", error);
        });
}