const express = require('express');
const mysql = require('mysql');
const cors = require('cors');

const app = express();
app.use(cors());

const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'password',
    database: 'your_database'
});
/// Sửa mấy cái trong '' lại nha

db.connect(err => {
    if (err) {
        console.error('Lỗi kết nối cơ sở dữ liệu:', err);
        return;
    }
    console.log('Đã kết nối cơ sở dữ liệu');
});

app.get('/images', (req, res) => {
    const query = 'SELECT imageUrl FROM images';
    db.query(query, (err, results) => {
        if (err) {
            console.error('Lỗi khi lấy hình ảnh:', err);
            res.status(500).send('Lỗi khi lấy hình ảnh');
            return;
        }
        res.json(results);
    });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});