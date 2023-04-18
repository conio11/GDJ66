# table 만드는 SQL 쿼리 - DDL(create, alter, drop, )
# table 사용을 허가하는 권한 - DCL(grant, revoke)
# table 데이터를 입력/수정/삭제/조회 - DML(insert, update, delete, select)
# TCL(commit, rollback)

# 조회 
SELECT * FROM notice;

INSERT INTO notice(notice_title, notice_content, notice_writer, createdate, updatedate) 
VALUES ('첫 번째 공지', '안녕하세요', '구디', NOW(), NOW());
#COMMIT; # auto commit 옵션 on

INSERT INTO notice(notice_title, notice_content, notice_writer, createdate, updatedate) 
VALUES ('두 번째 공지', '반갑습니다', '구디2', NOW(), NOW());

UPDATE notice SET notice_content='안녕히 가세요'
WHERE notice_no = 2;

# 원하는 행만 조회 
SELECT * FROM notice WHERE notice_no = 2;

# 원하는 열만 조회 
SELECT notice_no, notice_title FROM notice; 

DELETE FROM notice WHERE notice_writer = '구디2'

# 테이블 데이터 전체 삭제 
DELETE FROM notice;