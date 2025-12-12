--	Part – A 
--1.	INSERT Procedures: Create stored procedures to insert records into STUDENT tables (SP_INSERT_STUDENT)
--StuID	Name	        Email	        Phone	   Department	DOB  	EnrollmentYear
--10	Harsh Parmar	harsh@univ.edu	9876543218	CSE	    2005-09-18  	2023
--20	Om Patel	    om@univ.edu	    9876543211	IT	    2002-08-22  	2022

CREATE OR ALTER PROC PR_INSERT
@STUID INT,
@NAME VARCHAR(100),
@EMAIL VARCHAR(100),
@PHONE VARCHAR(15),
@DEPARTMENT VARCHAR(100),
@DOB DATE,
@ENROLLMENT_YEAR INT


AS
BEGIN
		INSERT INTO STUDENT VALUES(@STUID,@NAME,@EMAIL,@PHONE,@DEPARTMENT,@DOB,@ENROLLMENT_YEAR)
END

EXEC PR_INSERT 10,'HARSH PARMAR','harsh@univ.edu',9876543218,'CSE', '2005-09-18', 2023
EXEC PR_INSERT 20,'Om Patel','om@univ.edu',9876543211,'IT', '2002-08-22', 2022

--2.	INSERT Procedures: Create stored procedures to insert records into COURSE tables 
--(SP_INSERT_COURSE)
--CourseID	CourseName	Credits	Dept	Semester
--CS330	Computer Networks	4	CSE	5
--EC120	Electronic Circuits	3	ECE	2
GO
CREATE OR ALTER PROC PR_INSERT_COURSE
@COURSEID VARCHAR(100),
@CNAME VARCHAR(100),
@CREDIT INT,
@DEPT VARCHAR(50),
@SEM INT 

AS
BEGIN 
		
		INSERT INTO COURSE VALUES (@COURSEID,@CNAME,@CREDIT,@DEPT,@SEM)
END

EXEC PR_INSERT_COURSE 'CS330','ComputerNetworks',4,'CSE',5

EXEC PR_INSERT_COURSE 'EC120','Electronic Circuits',3,'ECE',2




--3.	UPDATE Procedures: Create stored procedure SP_UPDATE_STUDENT to update Email and Phone in STUDENT table. (Update using studentID)
GO
CREATE OR ALTER PROC PR_UPDATE

@EMAIL VARCHAR(100),
@PHONE VARCHAR(15),
@STUID INT

AS
BEGIN
	
	UPDATE STUDENT
	SET StuEmail=@EMAIL,StuPhone=@PHONE
	WHERE StudentID=@STUID
END
	

	EXEC PR_UPDATE 'harshparmar@univ.edu',98562314545,10


--4.	DELETE Procedures: Create stored procedure SP_DELETE_STUDENT to delete records from STUDENT where Student Name is Om Patel.
GO
CREATE OR ALTER PROC PR_DELETE


AS
BEGIN

	DELETE FROM STUDENT
	WHERE StuName='OM PATEL'
END

EXEC PR_DELETE


--5.	SELECT BY PRIMARY KEY: Create stored procedures to select records by primary key (SP_SELECT_STUDENT_BY_ID) from Student table.

GO
CREATE OR ALTER PROC PR_SELECT_STUDENT_BY_ID
@STUID INT

AS
BEGIN

	SELECT * FROM STUDENT
	WHERE StudentID=@STUID
END

EXEC PR_SELECT_STUDENT_BY_ID 5



--6.	Create a stored procedure that shows details of the first 5 students ordered by EnrollmentYear.

GO 
CREATE OR ALTER PROC PR_TOP_STU

AS
BEGIN

	SELECT TOP 5 STUNAME
	FROM STUDENT
	ORDER BY StuEnrollmentYear
END

EXEC PR_TOP_STU

--Part – B  
--7.	Create a stored procedure which displays faculty designation-wise count.

GO
CREATE OR ALTER PROC PR_COUNT

AS
BEGIN

	SELECT FacultyDesignation,COUNT(FacultyDesignation)
	FROM FACULTY
	GROUP BY FacultyDesignation
END

EXEC PR_COUNT


--8.	Create a stored procedure that takes department name as input and returns all students in that department.

GO
CREATE OR ALTER PROC PR_DEPTSTU
@DEPTNAME VARCHAR(50)

AS
BEGIN

	SELECT @DEPTNAME,StuName
	FROM STUDENT
	WHERE StuDepartment=@DEPTNAME
END

EXEC PR_DEPTSTU 'CSE'





--Part – C 
--9.	Create a stored procedure which displays department-wise maximum, minimum, and average credits of courses.
GO
CREATE OR ALTER PROC PR_MINMAX

AS
BEGIN 

	SELECT COURSENAME,MAX(CourseCredits),MIN(CourseCredits),AVG(CourseCredits)
	FROM COURSE
	GROUP BY CourseName
END

EXEC PR_MINMAX


--10.	Create a stored procedure that accepts StudentID as parameter and returns all courses the student is enrolled in with their grades.
GO
CREATE OR ALTER PROC PR_COURSE_GRADE
@STUID INT

AS
BEGIN

	SELECT S.STUNAME,C.COURSENAME,E.GRADE
	FROM STUDENT S
	JOIN ENROLLMENT E
	ON S.StudentID=E.StudentID
	JOIN COURSE C
	ON E.CourseID=C.CourseID
	WHERE S.StudentID=@STUID
END

EXEC PR_COURSE_GRADE 1


