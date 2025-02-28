-- DB起動時に実行するSQL
CREATE DATABASE IF NOT EXISTS ${DB_NAME};

-- USE ${DB_NAME};

-- CREATE TABLE IF NOT EXISTS users (
--     id INT AUTO_INCREMENT PRIMARY KEY,
--     username VARCHAR(50) NOT NULL,
--     password VARCHAR(255) NOT NULL,
--     email VARCHAR(100) NOT NULL,
--     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
-- );

-- INSERT INTO users (username, password, email) VALUES ('admin', 'admin_password', 'admin@example.com');
-- admin-pass
--なぜかパスワードがエラーとしてかえる
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';

-- 権限を反映させる
FLUSH PRIVILEGES;