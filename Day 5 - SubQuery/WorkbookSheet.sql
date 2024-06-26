-- ================== [Basic SELECT] ==================
-- 2번 O
-- 학과의 학과 정원을 다음과 같은 형태로 화면에 출력핚다.
SELECT DEPARTMENT_NAME||'의 정원은 '||CAPACITY||'명 입니다.' "학과별 정원" 
FROM TB_DEPARTMENT;

-- 6번 O
-- 춘 기술대학교는 총장을 제외하고 모든 교수들이 소속 학과를 가지고 있다. 
-- 그럼 춘 기술대학교 총장의 이름을 알아낼 수 있는 SQL 문장을 작성하시오.
SELECT PROFESSOR_NAME 
FROM TB_PROFESSOR 
WHERE DEPARTMENT_NO IS NULL;

-- 10번 O
-- 02 학번 전주 거주자들의 모임을 맊들려고 한다. 휴학한 사람들은 제외하고 
-- 재학중인 학생들의 학번, 이름, 주민번호를 출력하는 구문을 작성하시오.
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'N' 
    AND STUDENT_ADDRESS LIKE '%전주%'
    AND ENTRANCE_DATE LIKE '02%';


-- ================== [Additional SELECT - 함수] ==================
-- 4번 O
-- 교수들의 이름 중 성을 제외한 이름만 출력하는 SQL 문장을 작성하시오. 
-- 출력 헤더는 "이름" 이 찍히도록 한다. (성이 2 자인 경우는 교수는 없다고 가정하시오)
SELECT SUBSTR(PROFESSOR_NAME, 2, 2) "이름"
FROM TB_PROFESSOR;

-- 8번 O
-- 춘 기술대학교의 2000 년도 이후 입학자들은 학번이 A 로 시작하게 되어있다. 
-- 2000 년도 이전 학번을 받은 학생들의 학번과 이름을 보여주는 SQL 문장을 작성하시오.
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%';

-- 12번 O
-- 학번이 A112113 인 김고운 학생의 년도 별 평점을 구하는 SQL 문을 작성하시오. 
-- 단, 이때 출력 화면의 헤더는 "년도", "년도 별 평점" 이라고 찍히게 하고, 
-- 점수는 반올림하여 소수점 이하 한 자리까지만 표시한다.
SELECT SUBSTR(TERM_NO, 1, 4) "년도"
    , ROUND(AVG((SELECT ROUND(AVG(POINT),1) FROM TB_GRADE 
      WHERE STUDENT_NO = 'A112113' AND G.TERM_NO = TERM_NO)),1) "년도 별 평점"
FROM TB_GRADE G
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4)
ORDER BY 1 ASC;

-- 13번
-- 학과 별 휴학생 수를 파악하고자 한다. 학과 번호와 휴학생 수를 표시하는 
-- SQL 문장을 작성하시오.
SELECT 
    DEPARTMENT_NO "학과코드명"
    , COUNT(DECODE(ABSENCE_YN, 'Y', '1', NULL)) "휴학생 수"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1 ASC;

-- ================== [Additional SELECT - Option] ==================
-- 1번
-- 학생이름과 주소지를 표시하시오. 단, 출력 헤더는 "학생 이름", "주소지"로 하고,
-- 정렬은 이름으로 오름차순 표시하도록 한다.
SELECT STUDENT_NAME "학생 이름", STUDENT_ADDRESS "주소지"
FROM TB_STUDENT
ORDER BY 1 ASC;

-- 2번 O
-- 휴학중인 학생들의 이름과 주민번호를 나이가 적은 순서로 화면에 출력하시오.
SELECT STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY 2 DESC;

-- 5번
-- 2004 년 2 학기에 'C3118100' 과목을 수강한 학생들의 학점을 조회하려고 한다. 
-- 학점이 높은 학생부터 표시하고, 학점이 같으면 학번이 낮은 학생부터 
-- 표시하는 구문을 작성해보시오.
SELECT STUDENT_NO, POINT
FROM TB_GRADE
WHERE CLASS_NO = 'C3118100' AND TERM_NO LIKE '200402'
ORDER BY POINT DESC;

-- 6번 O
-- 학생 번호, 학생 이름, 학과 이름을 학생 이름으로 오름차순 정렬하여 
-- 출력하는 SQL문을 작성하시오.
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT
LEFT OUTER JOIN TB_DEPARTMENT
USING(DEPARTMENT_NO)
ORDER BY 2 ASC;

-- 9번
-- 8 번의 결과 중 ‘인문사회’ 계열에 속한 과목의 교수 이름을 찾으려고 한다. 
-- 이에 해당하는 과목 이름과 교수 이름을 출력하는 SQL 문을 작성하시오.
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_PROFESSOR P
INNER JOIN TB_CLASS_PROFESSOR USING(PROFESSOR_NO)
LEFT OUTER JOIN TB_CLASS USING(CLASS_NO)
LEFT OUTER JOIN TB_DEPARTMENT D ON D.DEPARTMENT_NO = P.DEPARTMENT_NO
WHERE CATEGORY = '인문사회';

-- 10번
-- ‘음악학과’ 학생들의 평점을 구하려고 한다. 음악학과 학생들의 "학번", "학생 이름", 
-- "전체 평점"을 출력하는 SQL 문장을 작성하시오. (단, 평점은 소수점 1 자리까지만
-- 반올림하여 표시한다.)
SELECT STUDENT_NO "학번", STUDENT_NAME "학생 이름"
    , ROUND(AVG(POINT),1) "전체 평점"
FROM TB_STUDENT
LEFT OUTER JOIN TB_GRADE USING(STUDENT_NO)
LEFT OUTER JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '음악학과'
GROUP BY STUDENT_NO, STUDENT_NAME
ORDER BY 1 ASC;

-- 13번
-- 예체능 계열 과목 중 과목 담당교수를 한 명도 배정받지 못한 과목을 찾아 
-- 그 과목 이름과 학과 이름을 출력하는 SQL 문장을 작성하시오.
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
LEFT OUTER JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE CATEGORY = '예체능' AND CLASS_NO NOT IN(SELECT CLASS_NO FROM TB_CLASS_PROFESSOR);

-- 14번 
--  춘 기술대학교 서반아어학과 학생들의 지도교수를 게시하고자 한다. 
-- 학생이름과 지도교수 이름을 찾고 만일 지도 교수가 없는 학생일 경우 
-- "지도교수 미지정‛으로 표시하도록 하는 SQL 문을 작성하시오.
-- 단, 출력헤더는 "학생이름", "지도교수"로 표시하며 고학번 학생이 먼저 표시되도록 한다.
SELECT STUDENT_NAME, NVL(PROFESSOR_NAME, '지도교수 미지정')
FROM TB_STUDENT S
LEFT OUTER JOIN TB_PROFESSOR ON COACH_PROFESSOR_NO = PROFESSOR_NO
WHERE S.DEPARTMENT_NO = '020'
ORDER BY ENTRANCE_DATE ASC;

-- 17번
-- 춘 기술대학교에 다니고 있는 최경희 학생과 같은 과 학생들의 이름과 
-- 주소를 출력하는 SQL 문을 작성하시오.
SELECT STUDENT_NAME, STUDENT_ADDRESS
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '038';

-- 18번
-- 국어국문학과에서 총 평점이 가장 높은 학생의 이름과 학번을 표시하는
-- SQL 문을 작성하시오.
SELECT STUDENT_NO, STUDENT_NAME FROM (
    SELECT STUDENT_NO, AVG(POINT)
    FROM TB_GRADE
    JOIN TB_STUDENT USING(STUDENT_NO)
    WHERE STUDENT_NO IN (
        SELECT STUDENT_NO FROM TB_STUDENT
        WHERE DEPARTMENT_NO = '001')
    GROUP BY STUDENT_NO
    ORDER BY 2 DESC)
LEFT OUTER JOIN TB_STUDENT USING(STUDENT_NO)
WHERE ROWNUM = 1;


-- ================== [DDL] ==================
-- 1번 O
CREATE TABLE TB_CATEGORY(
    NAME VARCHAR2(10),
    USE_YN CHAR(1) DEFAULT 'Y'
);

-- 2번 O
CREATE TABLE TB_CLASS_TYPE(
    NO VARCHAR2(5) PRIMARY KEY,
    NAME VARCHAR2(10)
);

-- 3번 O
ALTER TABLE TB_CATEGORY
ADD CONSTRAINT PK_NAME PRIMARY KEY(NAME);

-- 4번 O
ALTER TABLE TB_CLASS_TYPE
MODIFY NAME VARCHAR2(10) NOT NULL;

-- 5번 O
ALTER TABLE TB_CLASS_TYPE
MODIFY NO VARCHAR2(10)
MODIFY NAME VARCHAR2(20);

ALTER TABLE TB_CATEGORY
MODIFY NAME VARCHAR2(20);

-- 6번 O
ALTER TABLE TB_CATEGORY
RENAME COLUMN NAME TO CATEGORY_NAME;
ALTER TABLE TB_CLASS_TYPE
RENAME COLUMN NAME TO CLASS_TYPE_NAME;
ALTER TABLE TB_CLASS_TYPE
RENAME COLUMN NO TO CLASS_TYPE_NO;

-- 7번 O
ALTER TABLE TB_CATEGORY
DROP CONSTRAINT PK_NAME;
ALTER TABLE TB_CATEGORY
ADD CONSTRAINT PK_TB_CATEGORY PRIMARY KEY(NAME);

ALTER TABLE TB_CLASS_TYPE
DROP CONSTRAINT SYS_C007183;
ALTER TABLE TB_CLASS_TYPE
ADD CONSTRAINT PK_TB_CLASS_TYPE PRIMARY KEY(NO);

-- 8번 O
INSERT INTO TB_CATEGORY VALUES ('공학','Y');
INSERT INTO TB_CATEGORY VALUES ('자연과학','Y');
INSERT INTO TB_CATEGORY VALUES ('의학','Y');
INSERT INTO TB_CATEGORY VALUES ('예체능','Y');
INSERT INTO TB_CATEGORY VALUES ('인문사회','Y');
COMMIT; 

-- 9번 O
ALTER TABLE TB_DEPARTMENT
ADD CONSTRAINT FK_DEPARTMENT_CATEGORY
FOREIGN KEY(CATEGORY) REFERENCES TB_CATEGORY(CATEGORY_NAME);

-- 10번 O
CREATE VIEW VW_학생일반정보(학번, 학생이름, 주소)
AS SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS
FROM TB_STUDENT;
SELECT * FROM VW_학생일반정보;

-- 11번 O
-- 춘 기술대학교는 1년에 두 번씩 학과별로 학생과 지도교수가 지도 면담을 진행한다. 
-- 이를 위해 사용할 학생이름, 학과이름, 담당교수이름 으로 구성되어 있는 VIEW 를 만드시오.
-- 이때 지도 교수가 없는 학생이 있을 수 있음을 고려하시오 
-- (단, 이 VIEW 는 단순 SELECT 만을 할 경우 학과별로 정렬되어 화면에 보여지게 만드시오.)
CREATE OR REPLACE VIEW V_지도면담(학생이름, 학과이름, 담당교수이름)
AS SELECT STUDENT_NAME, DEPARTMENT_NAME, 
    NVL(PROFESSOR_NAME, '지도교수 없음')
FROM TB_STUDENT
LEFT OUTER JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
LEFT OUTER JOIN TB_PROFESSOR ON COACH_PROFESSOR_NO = PROFESSOR_NO
ORDER BY 2 ASC;
SELECT * FROM V_지도면담;
DROP VIEW V_지도면담;

-- 12번 O
-- 모든 학과의 학과별 학생 수를 확인할 수 있도록 적절한 VIEW 를 작성해 보자.
CREATE VIEW VW_학과별학생수(DEPARTMENT_NAME, STUDENT_COUNT)
AS SELECT DEPARTMENT_NAME, COUNT(*)
FROM TB_STUDENT 
LEFT OUTER JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
GROUP BY DEPARTMENT_NAME
ORDER BY 1 ASC;
SELECT * FROM VW_학과별학생수;
DROP VIEW VW_학과별학생수;

-- 13번 O
SELECT * FROM VW_학생일반정보;
COMMIT;
UPDATE VW_학생일반정보 
SET "학생이름" = '엄태운'
WHERE "학번" = 'A213046';
ROLLBACK;

-- 14번 O
CREATE VIEW VW_학생일반정보(학번, 학생이름, 주소)
AS SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS
FROM TB_STUDENT
WITH READ ONLY;

-- 15번
--  춘 기술대학교는 매년 수강신청 기간만 되면 특정 인기 과목들에 수강 신청이 몰려
-- 문제가 되고 있다. 최근 3 년을 기준으로 수강인원이 가장 많았던 3 과목을 찾는 
-- 구문을 작성해보시오.
SELECT * FROM (
SELECT CLASS_NO "과목번호"
    , CLASS_NAME "과목이름"
    , COUNT(*) "누적수강생수(명)"
    , DENSE_RANK() OVER(ORDER BY COUNT(*) DESC) "순위"
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
JOIN TB_CLASS USING(CLASS_NO)
WHERE TERM_NO > 200603
GROUP BY CLASS_NO, CLASS_NAME)
WHERE 순위 < 4;


-- ================== [DML] ==================
-- 3번
-- 국어국문학과 학생들의 정보맊이 포함되어 있는 학과정보 테이블을 맊들고자 한다. 
-- 아래 내용을 참고하여 적절한 SQL 문을 작성하시오. 
-- (힌트 : 방법은 다양함, 소신껏 작성하시오)
CREATE TABLE TB_국어국문학과
AS SELECT
    STUDENT_NO "학번"
    , STUDENT_NAME "학생이름"
    , TO_CHAR(TO_DATE(SUBSTR(STUDENT_SSN, 1, 2), 'RR'), 'YYYY') "출생년도"
    , PROFESSOR_NAME "교수이름"
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
LEFT OUTER JOIN TB_PROFESSOR ON COACH_PROFESSOR_NO = PROFESSOR_NO
WHERE DEPARTMENT_NAME = '국어국문학과';

-- 4번 O
-- 현 학과들의 정원을 10% 증가시키게 되었다. 이에 사용할 SQL 문을 작성하시오.
-- (단, 반올림을 사용하여 소수점 자릿수는 생기지 않도록 한다)
UPDATE TB_DEPARTMENT SET CAPACITY = ROUND(CAPACITY*1.1);

-- 8번 O
-- 성적 테이블(TB_GRADE) 에서 휴학생들의 성적항목을 제거하시오.
DELETE FROM TB_GRADE 
WHERE STUDENT_NO IN 
    (SELECT S.STUDENT_NO FROM TB_GRADE G
    JOIN TB_STUDENT S
    ON S.STUDENT_NO = G.STUDENT_NO
    WHERE S.ABSENCE_YN = 'Y'); -- 483개 행 삭제
    -- DELETE문의 메인쿼리에서는 별칭 사용 불가
ROLLBACK;
COMMIT;
