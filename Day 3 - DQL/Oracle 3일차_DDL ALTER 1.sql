-- 3일차
-- DDL, Data Definition Language 데이터 정의어
-- CREATE, ALTER, DROP           DDL의 종류
-- CREATE USER, CREATE TABLE...  예시
-- DROP TABLE, ...
-- ALTER로 할 수 있었던 것
-- 컬럼추가, 컬럼삭제, 컬럼수정(데이터타입, 이름), 테이블명 수정 2가지

-- 제약조건 추가, 삭제, 수정
-- 제약조건을 추가하면 이름이 생김, 이름을 알아야 삭제 가능

-- 제약조건 삭제
-- 1. 실행하고
ALTER TABLE USER_TBL
DROP CONSTRAINT FK_GRADE_CODE;
-- 2. 실행하면 ROW가 없음
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'USER_TBL';

-- 제약조건 추가
-- CONSTRAINT FK_GRADE_CODE 이름 붙이는거
-- NOT NULL 추가는 좀 다름..
-- 제약조건명을 따로 붙이지 않음.
ALTER TABLE USER_TBL
MODIFY USER_ID NOT NULL;
-- USER_ID        VARCHAR2(20) -> USER_ID     NOT NULL VARCHAR2(20) 
ALTER TABLE USER_TBL
MODIFY USER_DATE DEFAULT SYSDATE;

SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'USER_TBL';

DESC USER_TBL;
ALTER TABLE USER_TBL
ADD CONSTRAINT FK_GRADE_CODE
-- 제약조건 외래키 추가하는 거
FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE(GRADE_CODE);
-- Table USER_TBL이(가) 변경되었습니다.
-- 1. 실행하면 ROW가 1개 있음
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'USER_TBL';
-- 2. CONSTRAINT_NAME이 FK_GRADE_CODE인 것 확인

-- ex) USER_GRADE가 가지고 있는 제약조건 조회하여 삭제 후 같은 이름으로 재생성
-- 제약조건 수정은 삭제하고 추가하는 것. 단 이름은 바꿀 수 있음
ALTER TABLE USER_GRADE
RENAME CONSTRAINT PK_GRADE_CODE TO PRIMARY_GR_CODE;
-- 조회
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'USER_GRADE';
-- 삭제
ALTER TABLE USER_GRADE
DROP CONSTRAINT PK_GRADE_CODE;
-- 재생성
ALTER TABLE USER_GRADE
ADD CONSTRAINT PK_GRADE_CODE PRIMARY KEY(GRADE_CODE);

-- 제약조건 활성화/비활성화
ALTER TABLE USER_TBL
DISABLE CONSTRAINT FK_GRADE_CODE;
ALTER TABLE USER_TBL
ENABLE CONSTRAINT FK_GRADE_CODE;