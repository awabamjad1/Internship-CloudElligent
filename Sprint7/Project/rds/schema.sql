USE sampledbawab;
CREATE TABLE Department (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(50) NOT NULL,
    location VARCHAR(100)
);
CREATE TABLE Student (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(50) NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);
INSERT INTO Department (department_name, location) VALUES
    ('Computer Science', 'Building A'),
    ('Accounting and Finance', 'Building B'),
    ('EE', 'Building C');
INSERT INTO Student (student_name, department_id) VALUES
    ('Awab', 1),
    ('Shaheer', 2),      
    ('Razin', 1),  
    ('Izyan', 3);    
