--Part – A 

--1.	Retrieve all unique departments from the STUDENT table.

SELECT DISTINCT StuDepartment
FROM STUDENT

--2.	Insert a new student record into the STUDENT table.
--(9, 'Neha Singh', 'neha.singh@univ.edu', '9876543218', 'IT', '2003-09-20', 2021)

INSERT INTO STUDENT VALUES
(9, 'Neha Singh', 'neha.singh@univ.edu', '9876543218', 'IT', '2003-09-20', 2021)

--3.	Change the Email of student 'Raj Patel' to 'raj.p@univ.edu'. (STUDENT table)

UPDATE STUDENT
SET StuEmail='raj.p@univ.edu'
WHERE StuName='Raj Patel'

--4.	Add a new column 'CGPA' with datatype DECIMAL(3,2) to the STUDENT table.

ALTER TABLE STUDENT
ADD CGPA DECIMAL(3,2)

--5.	Retrieve all courses whose CourseName starts with 'Data'. (COURSE table)

SELECT CourseName
FROM COURSE
WHERE CourseName LIKE 'DATA%'

--6.	Retrieve all students whose Name contains 'Shah'. (STUDENT table)

SELECT StuName
FROM STUDENT
WHERE StuName LIKE '%Shah%'

--7.	Display all Faculty Names in UPPERCASE. (FACULTY table)

SELECT UPPER(FacultyName)
FROM FACULTY

--8.	Find all faculty who joined after 2015. (FACULTY table)

SELECT FacultyName
FROM FACULTY
WHERE FacultyJoiningDate>'2015-12-31'

--9.	Find the SQUARE ROOT of Credits for the course 'Database Management Systems'. (COURSE table)

SELECT SQRT(CourseCredits)
FROM COURSE
WHERE CourseName='Database Management Systems'

--10.	Find the Current Date using SQL Server in-built function.

SELECT GETDATE()

--11.	Find the top 3 students who enrolled earliest (by EnrollmentYear). (STUDENT table)

SELECT TOP 3 STUNAME
FROM STUDENT
ORDER BY StuEnrollmentYear

--12.	Find all enrollments that were made in the year 2022. (ENROLLMENT table)

SELECT S.STUNAME
FROM STUDENT S
JOIN ENROLLMENT E
ON S.StudentID=E.StudentID
WHERE EnrollmentDate BETWEEN '2022-01-01' AND '2022-12-31'

--13.	Find the number of courses offered by each department. (COURSE table)

SELECT CourseDepartment,COUNT(CourseName)
FROM COURSE
GROUP BY CourseDepartment

--14.	Retrieve the CourseID which has more than 2 enrollments. (ENROLLMENT table)

SELECT CourseID,COUNT(CourseID)
FROM ENROLLMENT
GROUP BY CourseID
HAVING COUNT(CourseID)>2

--15.	Retrieve all the student name with their enrollment status. (STUDENT & ENROLLMENT table)

SELECT StuName S,EnrollmentStatus E
FROM STUDENT S 
JOIN ENROLLMENT E
ON S.StudentID=E.StudentID

--16.	Select all student names with their enrolled course names. (STUDENT, COURSE, ENROLLMENT table)

SELECT STUNAME S ,CourseName C
FROM STUDENT S 
JOIN ENROLLMENT E
ON S.StudentID=E.StudentID
JOIN COURSE C
ON E.CourseID=C.CourseID

--17.	Create a view called 'ActiveEnrollments' showing only active enrollments with student name and  course name. (STUDENT, COURSE, ENROLLMENT,  table)

CREATE VIEW ActiveEnrollments
AS
SELECT STUNAME S ,CourseName C,EnrollmentStatus E
FROM STUDENT S 
JOIN ENROLLMENT E
ON S.StudentID=E.StudentID
JOIN COURSE C
ON E.CourseID=C.CourseID
WHERE E.EnrollmentStatus='ACTIVE'

SELECT * FROM ActiveEnrollments

--18.	Retrieve the student’s name who is not enrol in any course using subquery. (STUDENT, ENROLLMENT TABLE)

SELECT STUNAME 
FROM STUDENT
WHERE StudentID NOT IN ( SELECT StudentID
					FROM ENROLLMENT)
					

--19.	Display course name having second highest credit. (COURSE table)
SELECT TOP 1 CourseName
FROM COURSE 
WHERE CourseCredits IN (SELECT DISTINCT  TOP 2 CourseCredits
					FROM COURSE
					ORDER BY CourseCredits DESC)
ORDER BY CourseCredits


--Part – B 
--20.	Retrieve all courses along with the total number of students enrolled. (COURSE, ENROLLMENT table)

SELECT E.CourseID, COUNT(E.CourseID),CourseName
FROM COURSE C JOIN ENROLLMENT E
ON C.CourseID=E.CourseID
GROUP BY E.CourseID, C.COURSENAME

--21.	Retrieve the total number of enrollments for each status, showing only statuses that have more than 2 enrollments. (ENROLLMENT table)

SELECT ENROLLMENTSTATUS,COUNT(ENROLLMENTSTATUS)
FROM ENROLLMENT
GROUP BY EnrollmentStatus
HAVING COUNT(ENROLLMENTSTATUS)>2

--22.Retrieve all courses taught by 'Dr. Sheth' and order them by Credits. (FACULTY, COURSE, COURSE_ASSIGNMENT table)

SELECT C.COURSENAME,C.COURSECREDITS
FROM COURSE C
JOIN COURSE_ASSIGNMENT CA
ON C.CourseID=CA.CourseID
JOIN FACULTY F
ON CA.FacultyID=F.FacultyID
WHERE FacultyName='Dr. Sheth'

--Part – C 
--23.List all students who are enrolled in more than 3 courses. (STUDENT, ENROLLMENT table)

SELECT S.STUNAME,COUNT(E.StudentID)
FROM STUDENT S
JOIN ENROLLMENT E
ON S.StudentID=E.StudentID
GROUP BY S.StuName,E.StudentID
HAVING COUNT(E.StudentID)>3

--24.Find students who have enrolled in both 'CS101' and 'CS201' Using Sub Query. (STUDENT, ENROLLMENT table)

SELECT StuName
FROM STUDENT
WHERE StudentID IN (
        SELECT StudentID
        FROM ENROLLMENT
        WHERE CourseID = 'CS101')
AND StudentID IN (
        SELECT StudentID
        FROM ENROLLMENT
        WHERE CourseID = 'CS201');



--25.	Retrieve department-wise count of faculty members along with their average years of experience (calculate experience from JoiningDate). (Faculty table)

SELECT
  FacultyDepartment AS Department,
  COUNT(*) AS FacultyCount,
  AVG(DATEDIFF(YEAR, FacultyJoiningDate, GETDATE())) AS AvgExperienceYears
FROM FACULTY
GROUP BY FacultyDepartment;
