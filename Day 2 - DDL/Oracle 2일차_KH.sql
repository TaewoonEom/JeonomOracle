CREATE TABLE JOB(
    JOB_CODE CHAR(2) NOT NULL,
    JOB_NAME VARCHAR2(35)
);
COMMENT ON COLUMN JOB.JOB_CODE IS '직급코드';
COMMENT ON COLUMN JOB.JOB_NAME IS '직급명';
SELECT * FROM JOB;

CREATE TABLE DEPARTMENT(
    DEPT_ID CHAR(2) NOT NULL,
    DEPT_TITLE VARCHAR2(35),
    LOCATION_ID CHAR(2) NOT NULL
);
COMMENT ON COLUMN DEPARTMENT.DEPT_ID IS '부서코드';
COMMENT ON COLUMN DEPARTMENT.DEPT_TITLE IS '부서명';
COMMENT ON COLUMN DEPARTMENT.LOCATION_ID IS '지역코드';

CREATE TABLE EMPLOYEE(
    EMP_ID VARCHAR2(3) NOT NULL,
    EMP_NAME VARCHAR2(20) NOT NULL,
    EMP_NO CHAR(14) NOT NULL,
    EMAIL VARCHAR2(25),
    PHONE VARCHAR2(12),
    DEPT_CODE CHAR(2),
    JOB_CODE CHAR(2) NOT NULL,
    SAL_LEVEL CHAR(2) NOT NULL,
    SALARY NUMBER,
    BONUS NUMBER,
    MANAGER_ID VARCHAR2(3),
    HIRE_DATE DATE,
    ENT_DATE DATE,
    ENT_YN CHAR(1) DEFAULT 'N'
);

COMMENT ON COLUMN EMPLOYEE.EMP_ID IS '사원번호';
COMMENT ON COLUMN EMPLOYEE.EMP_NAME IS '직원명';
COMMENT ON COLUMN EMPLOYEE.EMP_NO IS '주민등록번호';
COMMENT ON COLUMN EMPLOYEE.EMAIL IS '이메일';
COMMENT ON COLUMN EMPLOYEE.PHONE IS '전화번호';
COMMENT ON COLUMN EMPLOYEE.DEPT_CODE IS '부서코드';
COMMENT ON COLUMN EMPLOYEE.JOB_CODE IS '직급코드';
COMMENT ON COLUMN EMPLOYEE.SAL_LEVEL IS '급여등급';
COMMENT ON COLUMN EMPLOYEE.SALARY IS '급여';
COMMENT ON COLUMN EMPLOYEE.BONUS IS '보너스율';
COMMENT ON COLUMN EMPLOYEE.MANAGER_ID IS '관리자사번';
COMMENT ON COLUMN EMPLOYEE.HIRE_DATE IS '입사일';
COMMENT ON COLUMN EMPLOYEE.ENT_DATE IS '퇴사일';
COMMENT ON COLUMN EMPLOYEE.ENT_YN IS '퇴직여부';

-- 200, 선동일, 621231-1986634, sun-di@kh.or.kr, 01099546325
-- D9, J1, S1, 8000000, 0.3, X, 2013/02/06, X, N

INSERT INTO EMPLOYEE
VALUES('200', '선동일', '621231-1986634', 'sun-di@kh.or.kr', '01099546325', 'D9', 'J1', 'S1', 8000000, 0.3, null, '2013/02/06', null, DEFAULT);

SELECT * FROM EMPLOYEE WHERE EMP_ID = '200';