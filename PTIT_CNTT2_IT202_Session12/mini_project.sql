drop database social_network_pro_ss12;
CREATE DATABASE social_network_pro_ss12;
USE social_network_pro_ss12;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(post_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);


CREATE TABLE likes (
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    PRIMARY KEY (user_id, post_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (post_id) REFERENCES posts(post_id) ON DELETE CASCADE
);

CREATE TABLE friends (
    user_id INT NOT NULL,
    friend_id INT NOT NULL,
    status VARCHAR(20) DEFAULT 'pending',
    PRIMARY KEY (user_id, friend_id),
    CONSTRAINT chk_status CHECK (status IN ('pending', 'accepted')),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (friend_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Bài 1
INSERT INTO users (username, password, email)
VALUES 
('nguyenvana', 'pass123', 'ana@gmail.com'),
('tranvanb', 'pass456', 'vanb@gmail.com'),
('lethic', 'pass789', 'thic@gmail.com'),
('anhtuan', '123', 'anhtuan@gmail.com'),
('minhan', '123', 'minhan@gmail.com'),
('thanhdat', '123', 'thanhdat@gmail.com'),
('hoangan', '123', 'hoangan@gmail.com'),
('linhchi', '123', 'linhchi@gmail.com'),
('phuongnam', '123', 'phuongnam@gmail.com'),
('quocbao', '123', 'quocbao@gmail.com'),
('myhanh', '123', 'myhanh@gmail.com'),
('tuananh', '123', 'tuananh@gmail.com'),
('anhthu', '123', 'anhthu@gmail.com'),
('vietanh', '123', 'vietanh@gmail.com'),
('hoanglong', '123', 'hoanglong@gmail.com'),
('kimngan', '123', 'kimngan@gmail.com'),
('ngocanh', '123', 'ngocanh@gmail.com'),
('thanhson', '123', 'thanhson@gmail.com'),
('phuongthao', '123', 'phuongthao@gmail.com'),
('ducthinh', '123', 'ducthinh@gmail.com'),
('baotram', '123', 'baotram@gmail.com'),
('huyhoang', '123', 'huyhoang@gmail.com'),
('quynhanh', '123', 'quynhanh@gmail.com');

SELECT * FROM users;

INSERT INTO Posts (user_id, content) VALUES
(1, 'Hôm nay học database rất thú vị'),
(2, 'MySQL giúp quản lý dữ liệu hiệu quả'),
(3, 'Mình đang học stored procedure'),
(4, 'Lập trình backend thật sự cuốn'),
(5, 'Cuối tuần học SQL cùng bạn bè'),
(6, 'Index giúp truy vấn nhanh hơn'),
(7, 'View giúp bảo mật dữ liệu'),
(8, 'Hôm nay trời mưa nhẹ'),
(9, 'Tối ưu database rất quan trọng'),
(10, 'Học database để làm backend'),
(11, 'Procedure giúp tái sử dụng code'),
(12, 'Mạng xã hội mini bằng SQL'),
(13, 'Thích nhất là phần join table'),
(14, 'Thực hành SQL mỗi ngày'),
(15, 'Cơ sở dữ liệu quan hệ'),
(16, 'Foreign key rất quan trọng'),
(17, 'Composite index tăng hiệu suất'),
(18, 'Database design quyết định hiệu năng'),
(19, 'SQL không khó nếu chăm học'),
(20, 'Backend developer cần giỏi database');


INSERT INTO Comments (post_id, user_id, content) VALUES
(1,2,'Chuẩn luôn'),
(1,3,'Mình cũng thấy vậy'),
(2,4,'MySQL rất mạnh'),
(3,5,'Procedure hơi khó'),
(4,6,'Backend rất thú vị'),
(5,7,'Cuối tuần học là hợp lý'),
(6,8,'Index quan trọng thật'),
(7,9,'View rất hay'),
(8,10,'Thời tiết dễ ngủ'),
(9,11,'Tối ưu là bắt buộc'),
(10,12,'Backend cần SQL'),
(11,13,'Procedure dùng nhiều'),
(12,14,'Mini project hay'),
(13,15,'Join là nền tảng'),
(14,16,'Ngày nào cũng nên học'),
(15,17,'CSDL rất quan trọng'),
(16,18,'FK giúp tránh lỗi'),
(17,19,'Index tăng tốc'),
(18,20,'Thiết kế chuẩn rất quan trọng'),
(19,1,'SQL dễ mà'),
(20,2,'Backend không thể thiếu DB');


INSERT INTO Friends (user_id, friend_id, status) VALUES
(1,2,'accepted'),
(1,3,'accepted'),
(1,4,'pending'),
(2,5,'accepted'),
(2,6,'pending'),
(3,7,'accepted'),
(3,8,'accepted'),
(4,9,'pending'),
(5,10,'accepted'),
(6,11,'accepted'),
(7,12,'pending'),
(8,13,'accepted'),
(9,14,'accepted'),
(10,15,'pending'),
(11,16,'accepted'),
(12,17,'accepted'),
(13,18,'pending'),
(14,19,'accepted'),
(15,20,'accepted'),
(16,1,'pending');


INSERT INTO Likes (user_id, post_id) VALUES
(1,1),
(2,1),
(3,1),
(4,1),
(5,2),
(6,2),
(7,2),
(8,3),
(9,3),
(10,3),
(11,4),
(12,4),
(13,5),
(14,5),
(15,6),
(16,7),
(17,8),
(18,9),
(19,10),
(20,10);

-- Bài 2
CREATE VIEW vw_public_users AS
SELECT user_id, username, created_at
FROM users;

SELECT * from vw_public_users;
-- Truy vấn từ bảng users sẽ lộ các cột nhạy cảm như password và email. Truy vấn từ View đã lọc bỏ các thông tin này.
-- View cho phép quản trị viên chỉ cung cấp các cột dữ liệu cần thiết cho người dùng hoặc ứng dụng, ẩn đi các thông tin quan trọng như mật khẩu hoặc email cá nhân.
-- Thay vì cho phép người dùng truy cập trực tiếp vào toàn bộ bảng chính, ta chỉ cấp quyền xem trên View, giúp giảm thiểu rủi ro bị rò rỉ dữ liệu.

-- Bài 3
CREATE INDEX idx_username ON users(username);
SELECT * FROM users WHERE username = 'nguyenvana';
-- Có Index: MySQL sử dụng cấu trúc B-Tree để tìm trực tiếp vị trí dữ liệu, tốc độ cực nhanh (O(log n)).
-- Không Index: MySQL phải quét toàn bộ bảng, tốn tài liệu và thời gian (O(n)).

-- Bài 4
delimiter //
CREATE procedure sp_create_post(IN p_user_id int, IN p_content text)
begin
	IF EXISTS (SELECT * FROM users WHERE user_id = p_user_id) THEN
		INSERT INTO posts(user_id, content)
        VALUES(p_user_id, p_content);
        SELECT 'Đăng bài viết thành công!' AS message;
	ELSE
		SELECT 'Người dùng không tồn tại. Không thể đăng bài.' AS message;
	end if;
end //
delimiter ;
CALL sp_create_post(1, 'Học CSDL');
CALL sp_create_post(999, 'Lỗi');
SELECT * FROM posts;

-- Bài 5
CREATE VIEW vw_recent_posts AS
SELECT post_id, user_id, content, created_at
FROM posts
ORDER BY created_at desc
LIMIT 7;

SELECT * FROM vw_recent_posts;

-- BÀI 6
CREATE INDEX idx_user_id ON posts(user_id);
CREATE INDEX idx_user_created ON posts(user_id, created_at DESC);
SELECT *
FROM posts 
WHERE user_id = 1 
ORDER BY created_at DESC;

-- BÀI 7
Delimiter //
CREATE procedure sp_count_posts(IN p_user_id int, OUT p_total int)
begin
	SET p_total =  (SELECT COUNT(user_id) FROM posts WHERE user_id = p_user_id);
end //
delimiter ;
call sp_count_posts(1, @total_post);
SELECT @total_post;

-- BÀI 8
CREATE VIEW vw_test AS 
SELECT * FROM users 
WHERE created_at > '2025-01-01'
WITH CHECK OPTION;

-- BÀI 9
DELIMITER //

CREATE PROCEDURE sp_add_friend(
    IN p_user_id INT,
    IN p_friend_id INT
)
BEGIN
    IF p_user_id = p_friend_id THEN
        SELECT 'Không thể kết bạn với chính mình' as message;
    ELSE
        INSERT INTO Friends(user_id, friend_id, status)
        VALUES (p_user_id, p_friend_id, 'pending');
    END IF;
END //

CALL sp_add_friend(1,1);


-- BÀI 10
Delimiter //
CREATE PROCEDURE sp_suggest_friends(
    IN p_user_id INT,
    INOUT p_limit INT
)
BEGIN
    DECLARE counter INT DEFAULT 0;
    SELECT u.user_id, u.username
	FROM Users u
	WHERE u.user_id != p_user_id AND u.user_id NOT IN (
              SELECT friend_id FROM Friends WHERE user_id = p_user_id
          )
        LIMIT p_limit;
END //
delimiter ;
SET @limit = 5;
CALL sp_suggest_friends(1,@limit);

-- BÀI 11
CREATE INDEX idx_likes_post_id ON Likes(post_id);
CREATE VIEW vw_top_posts AS SELECT p.post_id, p.content, COUNT(l.post_id) AS total_likes
FROM Posts p
JOIN Likes l ON p.post_id = l.post_id
GROUP BY p.post_id
ORDER BY total_likes DESC
LIMIT 5;

SELECT * FROM vw_top_posts;

-- BÀI 12
DELIMITER //

CREATE PROCEDURE sp_add_comment(
    IN p_user_id INT,
    IN p_post_id INT,
    IN p_content TEXT
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Users WHERE user_id = p_user_id) THEN
        SELECT 'User không tồn tại' as message;
    ELSEIF NOT EXISTS (SELECT 1 FROM Posts WHERE post_id = p_post_id) THEN
        SELECT 'Post không tồn tại' as message;
    ELSE
        INSERT INTO Comments(user_id, post_id, content)
        VALUES (p_user_id, p_post_id, p_content);
    END IF;
END //

CALL sp_add_comment(1,1,'hihi');

CREATE VIEW vw_post_comments AS
SELECT c.content, u.username, c.created_at
FROM Comments c
JOIN Users u ON c.user_id = u.user_id;

SELECT *
FROM vw_post_comments;

-- BÀI 13
DELIMITER //
CREATE PROCEDURE sp_like_post(
    IN p_user_id INT,
    IN p_post_id INT
)
BEGIN
    IF EXISTS (
        SELECT 1 FROM Likes
        WHERE user_id = p_user_id AND post_id = p_post_id
    ) THEN
        SELECT 'Đã thích bài viết này' as message;
    ELSE
        INSERT INTO Likes(user_id, post_id)
        VALUES (p_user_id, p_post_id);
    END IF;
END //

CALL sp_like_post(1,2);

CREATE VIEW vw_post_likes AS
SELECT post_id, COUNT(*) AS total_likes
FROM Likes
GROUP BY post_id;

SELECT *
FROM vw_post_likes;

-- BÀI 14
DELIMITER //

CREATE PROCEDURE sp_search_social(
    IN p_option INT,
    IN p_keyword VARCHAR(100)
)
BEGIN
    IF p_option = 1 THEN
        SELECT user_id, username
        FROM Users
        WHERE username LIKE CONCAT('%', p_keyword, '%');
    ELSEIF p_option = 2 THEN
        SELECT post_id, content
        FROM Posts
        WHERE content LIKE CONCAT('%', p_keyword, '%');
    ELSE
        SELECT 'Option không hợp lệ' as message;
    END IF;
END //

CALL sp_search_social(1, 'anhtuan');
CALL sp_search_social(2, 'MySQL');