SELECT notice_no AS 번호, notice_title AS notice_title FROM notice
ORDER BY notice_no DESC
LIMIT 0, 10;   

# 목록에서 500번 글의 제목을 클릭하면 500번 글의 모든 컬럼값 조회 
SELECT * FROM notice WHERE notice_no = 500;