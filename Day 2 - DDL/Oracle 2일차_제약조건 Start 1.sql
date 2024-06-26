CREATE TABLE USER_NO_CONSTRAINT (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    USER_GENDER VARCHAR2(10),
    USER_PHONE VARCHAR2(30),
    USER_EMAIL VARCHAR2(50)
);

DROP TABLE USER_NO_CONSTRAINT;

SELECT * FROM USER_NO_CONSTRAINT;
-- 1, khuser01, pass01, 일용자, 남, 01028227373, khuser01@gmail.com

INSERT INTO USER_NO_CONSTRAINT VALUES(1, 'khuser01', 'pass01', '일용자', '남', '01028227373', 'khuser01@gmail.com');
ROLLBACK;
COMMIT;

-- 제약조건 (중복을 최소화하고, 공백을 방지하기 위해)
INSERT INTO USER_NO_CONSTRAINT
VALUES(2, 'khuser02', null, null, null, null, null);

CREATE TABLE USER_NOTNULL (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) NOT NULL, 
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_GENDER VARCHAR2(10),
    USER_PHONE VARCHAR2(30),
    USER_EMAIL VARCHAR2(50)
);
INSERT INTO USER_NOTNULL
VALUES(1, 'khuser01', 'pass01', '일용자', null, null, null);
SELECT * FROM USER_NOTNULL;

CREATE TABLE USER_UNIQUE (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) UNIQUE, 
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_GENDER VARCHAR2(10),
    USER_PHONE VARCHAR2(30),
    USER_EMAIL VARCHAR2(50)
);
INSERT INTO USER_UNIQUE
VALUES(1, 'khuser01', 'pass01', '일용자', null, null, null);
INSERT INTO USER_UNIQUE
VALUES(1, 'khuser01', 'pass01', '일용자', null, null, null);
-- UNIQUE 제약 조건으로 중복은 막았으나 NULL은 막지 못함
SELECT * FROM USER_UNIQUE;

CREATE TABLE USER_PRIMARY_KEY (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) PRIMARY KEY,   -- UNIQUE & NOT NULL
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_GENDER VARCHAR2(10),
    USER_PHONE VARCHAR2(30),
    USER_EMAIL VARCHAR2(50)
);
DROP TABLE USER_PRIMARY_KEY;
INSERT INTO USER_PRIMARY_KEY
VALUES(1, 'khuser01', 'pass01', '일용자', null, null, null);
INSERT INTO USER_PRIMARY_KEY
VALUES(2, 'khuser02', 'pass02', '이용자', null, null, null);
SELECT * FROM USER_PRIMARY_KEY;
COMMIT;

CREATE TABLE USER_CHECK (
    USER_NO NUMBER UNIQUE,
    USER_ID VARCHAR2(20) PRIMARY KEY,   -- UNIQUE & NOT NULL
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_GENDER VARCHAR2(10) CHECK(USER_GENDER IN('M', 'F')),
    USER_PHONE VARCHAR2(30),
    USER_EMAIL VARCHAR2(50)
);
DROP TABLE USER_CHECK;
INSERT INTO USER_CHECK
VALUES(1, 'khuser01', 'pass01', '일용자', 'M', null, null);
INSERT INTO USER_CHECK
VALUES(2, 'khuser02', 'pass02', '이용자', 'M', null, null);
INSERT INTO USER_CHECK
VALUES(3, 'khuser03', 'pass03', '삼용자', 'M', null, null);
SELECT * FROM USER_CHECK;
COMMIT;
-- NOT NULL : NULL이 못 들어가게 함
-- UNIQUE : 중복이 안되게 함. NULL은 가능
-- PRIMARY KEY : 중복이 안되고 NULL도 안됨, 유일한 값
-- CHECK, CHECK( 컬럼명 IN (값1, 값2) ) : 지정한 값만 들어가게 함

CREATE TABLE USER_DEFAULT (
    USER_NO NUMBER UNIQUE,
    USER_ID VARCHAR2(20) PRIMARY KEY,   -- UNIQUE & NOT NULL
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_GENDER VARCHAR2(10) CHECK(USER_GENDER IN('M', 'F')),
    USER_PHONE VARCHAR2(30),
    USER_EMAIL VARCHAR2(50),
    USER_DATE DATE DEFAULT SYSDATE
);
DROP TABLE USER_DEFAULT;
INSERT INTO USER_DEFAULT
VALUES(1, 'khuser01', 'pass01', '일용자', 'M', '01082829292', 'khuser01@naver.com', '24/06/14');
INSERT INTO USER_DEFAULT
VALUES(1, 'khuser01', 'pass01', '일용자', 'M', '01082829292', 'khuser01@naver.com', DEFAULT);
INSERT INTO USER_DEFAULT
VALUES(2, 'khuser02', 'pass02', '이용자', 'M', '01082829292', 'khuser01@naver.com', SYSDATE+7);
SELECT * FROM USER_DEFAULT;
-- 제약조건
-- 1. NOT NULL
-- 2. UNIQUE
-- 3. PRIMARY KEY
-- 4. CHECK
-- 5. DEFAULT
-- 6. FOREIGN KEY(외래키)