-- 5일차 JOIN

-- @함수 종합실습 - 형변환 함수, 기타 함수
--9. 재직중인 직원과 퇴사한 직원의 수를 조회하시오.
SELECT DECODE(ENT_YN, 'N', '재직', '퇴직') "재직 여부", COUNT(*) "인원수" FROM EMPLOYEE
GROUP BY ENT_YN;

-- 10. 직원명, 직급코드, 연봉(원) 조회
-- 단, 연봉은 ￦57,000,000 으로 표시되게 함
-- 연봉은 보너스포인트가 적용된 1년치 급여임
SELECT EMP_NAME "직원명", JOB_CODE "직급코드", TO_CHAR(SALARY*12+SALARY*NVL(BONUS,0), 'L999,999,999') "연봉(원)"
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

--11. 사원명과, 부서명을 출력하세요.
--   부서코드가 D5이면 총무부, D6이면 기획부, D9이면 영업부로 처리하시오.(case 사용)
--   단, 부서코드가 D5, D6, D9 인 직원의 정보만 조회하고, 부서코드 기준으로 오름차순 정렬함.
SELECT EMP_NAME,
    CASE 
        WHEN DEPT_CODE = 'D5' THEN '총무부'
        WHEN DEPT_CODE = 'D6' THEN '기획부' 
        WHEN DEPT_CODE = 'D9' THEN '영업부' 
    END "부서명"
FROM EMPLOYEE 
WHERE DEPT_CODE IN('D5', 'D6', 'D9') ORDER BY DEPT_CODE ASC;

-- JOIN으로도 가능, JOIN으로 출력해보세요
SELECT * FROM DEPARTMENT;
SELECT EMP_NAME "사원명", DEPT_TITLE "부서명" FROM EMPLOYEE
JOIN DEPARTMENT
ON DEPT_CODE = DEPT_ID
WHERE DEPT_CODE IN('D5', 'D6', 'D9') ORDER BY DEPT_CODE ASC;

-- JOIN의 종류
-- 1.1 INNER JOIN : 교집합, 일반적으로 사용하는 조인
-- 1.2 OUTER JOIN : 합집합, 모두 출력하는 조인
-- ex) 사원명과 부서명을 출력하시오
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID; -- 21개, 2개가 빠짐.
-- 2개는 왜 빠졌나?, DEPT_CODE가 NULL인 데이터를 빠짐
-- -> 이것을 INNER JOIN이라고 함.

SELECT COUNT(*) FROM EMPLOYEE; -- 23

-- LEFT OUTER JOIN은 왼쪽 테이블이 가지고 있는 모든 데이터를 출력
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT OUTER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID; -- 23개임, 2개가 안빠짐

-- RIGHT OUTER JOIN은 오른쪽 테이블이 가지고 있는 모든 데이터를 출력
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
RIGHT OUTER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID; -- 23개임, 2개가 안빠짐

-- FULL OUTER JOIN은 양쪽 테이블이 가지고 있는 모든 데이터를 출력
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
FULL OUTER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- 오라클 전용 구문, JOIN 사용해보기
-- 1. INNER JOIN
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE = DEPT_ID;
-- 2. LEFT OUTER JOIN
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE = DEPT_ID(+);
-- 3. RIGHT OUTER JOIN
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE(+) = DEPT_ID;
-- 4. FULL OUTER JOIN
-- 존재하지 않음