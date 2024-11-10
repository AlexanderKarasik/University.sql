-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema University
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `University` ;

-- -----------------------------------------------------
-- Schema University
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `University` DEFAULT CHARACTER SET utf8 ;
USE `University` ;

-- -----------------------------------------------------
-- Table `University`.`college`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University`.`college` ;

CREATE TABLE IF NOT EXISTS `University`.`college` (
  `college_id` INT NOT NULL AUTO_INCREMENT,
  `college_title` VARCHAR(45) NULL,
  PRIMARY KEY (`college_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University`.`department` ;

CREATE TABLE IF NOT EXISTS `University`.`department` (
  `dep_code` VARCHAR(10) NOT NULL,
  `dep_title` VARCHAR(45) NULL,
  `college_id` INT NOT NULL,
  PRIMARY KEY (`dep_code`),
  INDEX `fk_department_college1_idx` (`college_id` ASC) VISIBLE,
  CONSTRAINT `fk_department_college1`
    FOREIGN KEY (`college_id`)
    REFERENCES `University`.`college` (`college_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University`.`course` ;

CREATE TABLE IF NOT EXISTS `University`.`course` (
  `course_num` INT NOT NULL,
  `course_title` VARCHAR(45) NULL,
  `credits` INT NULL,
  `dep_code` VARCHAR(10) NOT NULL,
  `course` VARCHAR(45) NULL,
  PRIMARY KEY (`course_num`),
  INDEX `fk_course_department1_idx` (`dep_code` ASC) VISIBLE,
  CONSTRAINT `fk_course_department1`
    FOREIGN KEY (`dep_code`)
    REFERENCES `University`.`department` (`dep_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`year`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University`.`year` ;

CREATE TABLE IF NOT EXISTS `University`.`year` (
  `year_id` INT NOT NULL AUTO_INCREMENT,
  `year` YEAR(4) NULL,
  PRIMARY KEY (`year_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`term`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University`.`term` ;

CREATE TABLE IF NOT EXISTS `University`.`term` (
  `term_id` INT NOT NULL AUTO_INCREMENT,
  `term` VARCHAR(45) NULL,
  PRIMARY KEY (`term_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`faculty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University`.`faculty` ;

CREATE TABLE IF NOT EXISTS `University`.`faculty` (
  `faculty_id` INT NOT NULL AUTO_INCREMENT,
  `faculty_fname` VARCHAR(45) NULL,
  `faculty_lname` VARCHAR(45) NULL,
  `capacity` INT NULL,
  PRIMARY KEY (`faculty_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`section`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University`.`section` ;

CREATE TABLE IF NOT EXISTS `University`.`section` (
  `section_id` INT NOT NULL,
  `course_num` INT NOT NULL,
  `year_id` INT NOT NULL,
  `term_id` INT NOT NULL,
  `faculty_id` INT NOT NULL,
  `section` VARCHAR(1) NULL,
  PRIMARY KEY (`section_id`),
  INDEX `fk_section_course1_idx` (`course_num` ASC) VISIBLE,
  INDEX `fk_section_year1_idx` (`year_id` ASC) VISIBLE,
  INDEX `fk_section_term1_idx` (`term_id` ASC) VISIBLE,
  INDEX `fk_section_faculty1_idx` (`faculty_id` ASC) VISIBLE,
  CONSTRAINT `fk_section_course1`
    FOREIGN KEY (`course_num`)
    REFERENCES `University`.`course` (`course_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_year1`
    FOREIGN KEY (`year_id`)
    REFERENCES `University`.`year` (`year_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_term1`
    FOREIGN KEY (`term_id`)
    REFERENCES `University`.`term` (`term_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_faculty1`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `University`.`faculty` (`faculty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University`.`student` ;

CREATE TABLE IF NOT EXISTS `University`.`student` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `gender` ENUM('M', 'F') NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `birthday` DATE NULL,
  PRIMARY KEY (`student_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`enrollment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University`.`enrollment` ;

CREATE TABLE IF NOT EXISTS `University`.`enrollment` (
  `section_id` INT NOT NULL,
  `student_id` INT NOT NULL,
  PRIMARY KEY (`section_id`, `student_id`),
  INDEX `fk_section_has_student_student1_idx` (`student_id` ASC) VISIBLE,
  INDEX `fk_section_has_student_section_idx` (`section_id` ASC) VISIBLE,
  CONSTRAINT `fk_section_has_student_section`
    FOREIGN KEY (`section_id`)
    REFERENCES `University`.`section` (`section_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_has_student_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `University`.`student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



-- -------------------------------
-- Load the University database
-- -------------------------------
use University;

insert into college values
	(NULL, 'Physical Science and Engineering'),
    (NULL, 'College of Business and Communication'),
    (NULL, 'College of Language and Letters');
    

insert into department values
	('CIT', 'Computer Information Technology', 1),
    ('ECON', 'Economics', 2),
    ('HUM', 'Humanities and Philosophy', 3);
    
insert into course values
	('111', 'Intro to Databases', 3, 'CIT', 'CIT 111'),
    ('388', 'Econometrics', 4, 'ECON', 'ECON 388'),
    ('150', 'Micro Economics', 3, 'ECON', 'ECON 150'),
    ('376', 'Classical Heritage', 2, 'HUM', 'HUM 376');
    
    
insert into year values
	(NULL, 2018),
    (NULL, 2019);
    
insert into term values
	(NULL, 'Fall'),
    (NULL, 'Winter');
   
insert into student values
	(NULL, 'Paul', 'Miller', 'M', 'Dallas', 'TX', '1996-02-22'),
    (NULL, 'Katie', 'Smith', 'F', 'Provo', 'UT', '1995-07-22'),
	(NULL, 'Kelly', 'Jones', 'F', 'Provo', 'UT', '1998-06-22'),
    (NULL, 'Devon', 'Merrill', 'M', 'Mesa', 'AZ', '2000-07-22'),
    (NULL, 'Mandy', 'Murdock', 'F', 'Topeka', 'KS', '1996-11-22'),
    (NULL, 'Alece', 'Adams', 'F', 'Rigby', 'ID', '1997-05-22'),
    (NULL, 'Bryce', 'Carlson', 'M', 'Bozeman', 'MT', '1997-11-22'),
    (NULL, 'Preston', 'Larsen', 'M', 'Decatur', 'TN', '1996-09-22'),
    (NULL, 'Julia', 'Madsen', 'F', 'Rexburg', 'ID', '1998-09-22'),
    (NULL, 'Susan', 'Sorensen', 'F', 'Mesa', 'AZ', '1998-08-09');
    

insert into faculty values
	(NULL, 'Marty', 'Morring', 30),
    (NULL, 'Nate', 'Nathan', 50),
	(NULL, 'Ben', 'Barrus', 35),
    (NULL, 'John', 'Jensen', 30),
	(NULL, 'Bill', 'Barney', 35);
    
insert into section values
	(1, '111', 1, 2, 5, '3'),
    (2, '111', 1, 2, 1, '2'),
    (3, '150', 1, 2, 2, '1'),
    (4, '376', 1, 2, 4, '1'),
    (5, '376', 2, 1, 4, '1'),
    (6, '150', 1, 2, 2, '2'),
    (7, '388', 2, 1, 3, '1'),
    (8, '388', 2, 1, 3, '1'),
    (9, '388', 2, 1, 3, '1'),
    (10, '376', 2, 1, 4, '1'),
    (11, '111', 2, 1, 1, '1'),
    (12, '150', 2, 1, 2, '2'),
    (13, '150', 1, 2, 2, '2'),
    (14, '111', 1, 2, 1, '2');
    

insert into enrollment values
	(1, 6),
    (2, 7),
    (3, 7),
    (4, 7),
    (5, 4),
    (6, 9),
    (7, 2),
    (8, 3),
    (9, 5),
    (10, 5),
    (11, 1),
    (12, 1),
    (13, 8),
    (14, 10);
    
 select * from faculty;
  
  
-- --------------------------------
-- Query the University database
-- --------------------------------

-- 1
select first_name as fname, last_name as lname, date_format(birthday, '%M %e, %Y') as 'Sept Birthday'
from student
where month(birthday) = 9
order by lname;

-- 2
select last_name as lname, first_name as fname, floor(datediff('2017-01-05', birthday) / 365) as Years, mod(datediff('2017-01-05', birthday), 365) as Days, concat(floor(datediff('2017-01-05', birthday) / 365), ' - Yrs', ', ', mod(datediff('2017-01-05', birthday), 365), ' - Days') as 'Years and Days'
from student
order by Years desc, Days desc; 

-- 3
select first_name as fname, last_name as lname
from student s
join enrollment e
on s.student_id = e.student_id
join section sn
on sn.section_id = e.section_id
join faculty f
on f.faculty_id = sn.faculty_id
where faculty_fname = 'John' and faculty_lname = 'Jensen'
order by last_name;

-- 4
select faculty_fname as fname, faculty_lname as lname
from faculty f
join section s
on f.faculty_id = s.faculty_id
join year y
on y.year_id = s.year_id
join term t
on t.term_id = s.term_id
join enrollment e
on e.section_id = s.section_id
join student st
on e.student_id = st.student_id
where year = '2018' and term = 'Winter' and st.first_name = 'Bryce'
order by faculty_lname;

-- 5
select first_name as fname, last_name as lname
from faculty f
join section s
on f.faculty_id = s.faculty_id
join year y
on y.year_id = s.year_id
join term t
on t.term_id = s.term_id
join enrollment e
on e.section_id = s.section_id
join student st
on e.student_id = st.student_id
join course c
on c.course_num = s.course_num
where year = '2019' and term = 'Fall' and course_title = 'Econometrics'
order by st.last_name;

-- 6
select dep_code as department_code, c.course_num, course_title as name
from faculty f
join section s
on f.faculty_id = s.faculty_id
join year y
on y.year_id = s.year_id
join term t
on t.term_id = s.term_id
join enrollment e
on e.section_id = s.section_id
join student st
on e.student_id = st.student_id
join course c
on c.course_num = s.course_num
where year = '2018' and term = 'Winter' and st.first_name = 'Bryce' and st.last_name = 'Carlson'
order by c.course_title;
    
-- 7
select term, year, count(*) as Enrollment
from section s
join year y
on y.year_id = s.year_id
join term t
on t.term_id = s.term_id
join enrollment e
on e.section_id = s.section_id
join student st
on e.student_id = st.student_id
where year = '2019' and term = 'Fall';
    
-- 8
select college_title as College, count(course_num) as Courses
from college c
join department d
on c.college_id = d.college_id
join course cs
on cs.dep_code = d.dep_code
group by college_title
order by college_title;

-- 9
select faculty_fname as fname, faculty_lname as lname, sum(capacity) as TeachingCapacity
from faculty f
join section s
on f.faculty_id = s.faculty_id
join year y
on y.year_id = s.year_id
join term t
on t.term_id = s.term_id
join enrollment e
on e.section_id = s.section_id
join student st
on e.student_id = st.student_id
where year = '2018' and term = 'Winter' and st.student_id != '10' and st.student_id != '9' 
group by faculty_fname, faculty_lname
order by TeachingCapacity;

-- 10
select last_name as lname, first_name as fname, sum(credits) as Credits
from section s
join year y
on y.year_id = s.year_id
join term t
on t.term_id = s.term_id
join enrollment e
on e.section_id = s.section_id
join student st
on e.student_id = st.student_id
join course c
on c.course_num = s.course_num
where year = '2019' and term = 'Fall' 
group by first_name, last_name
having sum(credits) > 3
order by Credits desc;


    
    
    




    
    


