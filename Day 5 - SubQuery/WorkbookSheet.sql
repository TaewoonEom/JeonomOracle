-- == [Basic SELECT] ==
-- 2번
-- 학과의 학과 정원을 다음과 같은 형태로 화면에 출력핚다.
SELECT DEPARTMENT_NAME||'의 정원은 '||CAPACITY||'명 입니다.' "학과별 정원" 
FROM TB_DEPARTMENT;

-- 6번
-- 춘 기술대학교는 총장을 제외하고 모든 교수들이 소속 학과를 가지고 있다. 
-- 그럼 춘 기술대학교 총장의 이름을 알아낼 수 있는 SQL 문장을 작성하시오.
SELECT PROFESSOR_NAME 
FROM TB_PROFESSOR 
WHERE DEPARTMENT_NO IS NULL;

-- 10번
-- 02 학번 젂주 거주자들의 모임을 맊들려고 핚다. 휴학핚 사람들은 제외하고 
-- 재학중인 학생들의 학번, 이름, 주민번호를 출력하는 구문을 작성하시오.
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'N' 
    AND STUDENT_ADDRESS LIKE '%전주%'
    AND ENTRANCE_DATE LIKE '02%';


-- == [Additional SELECT - 함수] ==
-- 4번
-- 교수들의 이름 중 성을 제외핚 이름맊 출력하는 SQL 문장을 작성하시오. 
-- 출력 헤더는 "이름" 이 찍히도록 핚다. (성이 2 자인 경우는 교수는 없다고 가정하시오)
SELECT SUBSTR(PROFESSOR_NAME, 2, 2) "이름"
FROM TB_PROFESSOR;

-- 8번
-- 춘 기술대학교의 2000 년도 이후 입학자들은 학번이 A 로 시작하게 되어있다. 
-- 2000 년도 이전 학번을 받은 학생들의 학번과 이름을 보여주는 SQL 문장을 작성하시오.
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%';

-- 12번
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


-- == [Additional SELECT - Option] ==
-- 2번
-- 휴학중인 학생들의 이름과 주민번호를 나이가 적은 순서로 화면에 출력하시오.
SELECT STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY 2 DESC;

-- 6번
-- 학생 번호, 학생 이름, 학과 이름을 학생 이름으로 오름차순 정렬하여 
-- 출력하는 SQL문을 작성하시오.
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT
LEFT OUTER JOIN TB_DEPARTMENT
USING(DEPARTMENT_NO)
ORDER BY 2 ASC;

-- 10번 *****************
-- ‘음악학과’ 학생들의 평점을 구하려고 한다. 음악학과 학생들의 "학번", "학생 이름", 
-- "전체 평점"을 출력하는 SQL 문장을 작성하시오. (단, 평점은 소수점 1 자리까지만
-- 반올림하여 표시한다.)
SELECT STUDENT_NO "학번", STUDENT_NAME "학생 이름"
    , (SELECT ROUND(AVG(POINT),1) FROM TB_GRADE G WHERE STUDENT_NO = G.STUDENT_NO) "전체 평점"
FROM TB_STUDENT S
LEFT OUTER JOIN TB_GRADE USING(STUDENT_NO)
LEFT OUTER JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NO = '059';

SELECT SUBSTR(TERM_NO, 1, 4) "년도"
    , ROUND(AVG((SELECT ROUND(AVG(POINT),1) FROM TB_GRADE 
        WHERE STUDENT_NO = 'A112113' AND G.TERM_NO = TERM_NO)),1) "년도 별 평점"
FROM TB_GRADE G
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4)
ORDER BY 1 ASC;


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


-- 18번 
-- 국어국문학과에서 총 평점이 가장 높은 학생의 이름과 학번을 
-- 표시하는 SQL 문을 작성하시오.
SELECT STUDENT_NAME, STUDENT_NO
FROM TB_STUDENT; 





-- == [DDL] ==
CREATE TABLE TB_CATEGORY(
    NAME VARCHAR2(10),
    USE_YN CHAR(1) DEFAULT 'Y'
);
CREATE TABLE TB_CLASS_TYPE(
    NO VARCHAR2(5) PRIMARY KEY,
    NAME VARCHAR2(10)
);

-- 3번
ALTER TABLE TB_CATEGORY
ADD CONSTRAINT PK_NAME PRIMARY KEY(NAME);

-- 7번
ALTER TABLE TB_CATEGORY
DROP CONSTRAINT PK_NAME;
ALTER TABLE TB_CATEGORY
ADD CONSTRAINT PK_TB_CATEGORY PRIMARY KEY(NAME);

ALTER TABLE TB_CLASS_TYPE
DROP CONSTRAINT SYS_C007183;
ALTER TABLE TB_CLASS_TYPE
ADD CONSTRAINT PK_TB_CLASS_TYPE PRIMARY KEY(NO);



-- == [DML] ==
-- 4번
-- 현 학과들의 정원을 10% 증가시키게 되었다. 이에 사용핛 SQL 문을 작성하시오.
-- (단, 반올림을 사용하여 소수점 자릿수는 생기지 않도록 한다)


-- 8번
-- 성적 테이블(TB_GRADE) 에서 휴학생들의 성적항목을 제거하시오.







