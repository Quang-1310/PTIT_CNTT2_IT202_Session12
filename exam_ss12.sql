CREATE DATABASE StudentDB;
USE StudentDB;
-- 1. Bảng Khoa
CREATE TABLE Department (
    DeptID CHAR(5) PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL
);

-- 2. Bảng SinhVien
CREATE TABLE Student (
    StudentID CHAR(6) PRIMARY KEY,
    FullName VARCHAR(50),
    Gender VARCHAR(10),
    BirthDate DATE,
    DeptID CHAR(5),
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- 3. Bảng MonHoc
CREATE TABLE Course (
    CourseID CHAR(6) PRIMARY KEY,
    CourseName VARCHAR(50),
    Credits INT
);

-- 4. Bảng DangKy
CREATE TABLE Enrollment (
    StudentID CHAR(6),
    CourseID CHAR(6),
    Score FLOAT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);
INSERT INTO Department VALUES
('IT','Information Technology'),
('BA','Business Administration'),
('ACC','Accounting');

INSERT INTO Student VALUES
('S00001','Nguyen An','Male','2003-05-10','IT'),
('S00002','Tran Binh','Male','2003-06-15','IT'),
('S00003','Le Hoa','Female','2003-08-20','BA'),
('S00004','Pham Minh','Male','2002-12-12','ACC'),
('S00005','Vo Lan','Female','2003-03-01','IT'),
('S00006','Do Hung','Male','2002-11-11','BA'),
('S00007','Nguyen Mai','Female','2003-07-07','ACC'),
('S00008','Tran Phuc','Male','2003-09-09','IT');

INSERT INTO Course VALUES
('C00001','Database Systems',3),
('C00002','C Programming',3),
('C00003','Microeconomics',2),
('C00004','Financial Accounting',3);

INSERT INTO Enrollment VALUES
('S00001','C00001',8.5),
('S00001','C00002',7.0),
('S00002','C00001',6.5),
('S00003','C00003',7.5),
('S00004','C00004',8.0),
('S00005','C00001',9.0),
('S00006','C00003',6.0),
('S00007','C00004',7.0),
('S00008','C00001',5.5),
('S00008','C00002',6.5);

-- PHẦN A
-- Câu 1
CREATE VIEW View_StudentBasic AS
SELECT s.StudentID, s.FullName, d.DeptName 
FROM student as s
JOIN department as d ON s.DeptID = d.DeptID;

SELECT * FROM View_StudentBasic;

-- Câu 2
CREATE INDEX idx_fullname on student(StudentID);

-- Câu 3
delimiter //
CREATE procedure GetStudentsIT()
begin 
	SELECT * FROM student as s
    JOIN department as d ON s.DeptID = d.DeptID
    WHERE d.DeptName = 'Information Technology';
end //
delimiter ;
call GetStudentsIT;

-- PHẦN B
-- Câu 4
CREATE VIEW View_StudentCountByDept AS
SELECT DeptName, COUNT(DeptName) as TotalStudents
FROM department as d
JOIN student as s ON d.DeptID = s.DeptID
GROUP BY DeptName;
SELECT * FROM View_StudentCountByDept;

-- Câu 5
delimiter //
CREATE procedure GetTopScoreStudent(IN p_CourseID char(6))
begin
	SELECT * FROM student WHERE StudentID = (	SELECT StudentID FROM Enrollment
												WHERE score = (SELECT MAX(Score) FROM Enrollment WHERE CourseID = p_CourseID)
											);
end //
delimiter ;
call GetTopScoreStudent('C00001');

-- Câu 6
-- a)
CREATE VIEW View_IT_Enrollment_DB AS
SELECT * FROM student as s
JOIN Enrollment as e ON s.studentID = e.studentID
JOIN Department as d ON s.DeptID = d.DeptID
WHERE d.DeptID = 'IT' AND e.CourseID = 'C00001'
With check option;

SELECT * FROM View_IT_Enrollment_DB;

-- b)
delimiter //
CREATE procedure UpdateScore_IT_DB(IN p_StudentID char(6), INOUT p_NewScore int)
begin 
	if p_NewScore > 10 then set p_NewScore = 10;
    else p_NewScore set p_NewScore = p_NewScore
    end if
end

