
// webpack.config.js
const path = require('path');

module.exports = {
    entry: './js/firebase.js', // Tệp JavaScript chính của bạn
    output: {
        filename: 'bundle.js',
        path: path.resolve(__dirname, 'dist') // Thư mục output cho các file được đóng gói
    },
    module: {
        rules: [
            {
                test: /\.js$/,
                exclude: /node_modules/,
                use: {
                    loader: 'babel-loader',
                    options: {
                        presets: ['@babel/preset-env']
                    }
                }
            }
        ]
    },
    mode: 'development' // Chế độ development hoặc production
};
