CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(50) NOT NULL,
    student_email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL
);

CREATE TABLE Feedback (
    feedback_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    rating INT,
    feedback_text TEXT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE PROCEDURE AddStudent(IN p_name VARCHAR(50), IN p_email VARCHAR(100))
BEGIN
    INSERT INTO Students(student_name, student_email) VALUES (p_name, p_email);
END;

CREATE PROCEDURE AddCourse(IN p_name VARCHAR(100))
BEGIN
    INSERT INTO Courses(course_name) VALUES (p_name);
END;

CREATE PROCEDURE AddFeedback(IN p_student_id INT, IN p_course_id INT, IN p_rating INT, IN p_feedback_text TEXT)
BEGIN
    INSERT INTO Feedback(student_id, course_id, rating, feedback_text) VALUES (p_student_id, p_course_id, p_rating, p_feedback_text);
END;

CREATE FUNCTION GetAverageRating(p_course_id INT) RETURNS FLOAT
DETERMINISTIC
BEGIN
    DECLARE avg_rating FLOAT;
    SELECT AVG(rating) INTO avg_rating FROM Feedback WHERE course_id = p_course_id;
    RETURN avg_rating;
END;

CREATE PROCEDURE GetCourseFeedback(IN p_course_id INT)
BEGIN
    SELECT student_name, rating, feedback_text
    FROM Feedback
    JOIN Students ON Feedback.student_id = Students.student_id
    WHERE course_id = p_course_id;
END;

CALL AddStudent('John Doe', 'john@example.com');
CALL AddCourse('Introduction to MySQL');
CALL AddFeedback(1, 1, 4, 'Great course! Enjoyed learning MySQL.');
select * from Students; 
select * from Courses ;
select * from Feedback;