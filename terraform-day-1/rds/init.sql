CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(150)
);

INSERT INTO users (name, email)
VALUES
('Vamshi', 'vamshi@example.com'),
('Rahul', 'rahul@example.com');