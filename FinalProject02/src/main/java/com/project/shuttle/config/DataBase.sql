
-- 해당 페이지는 수정하지 말아주십셔
-- 깃 사용시 충돌이 가장 많이 일어나는 부분입니다. 상관은 없지만 귀찮습니다..


--의뢰 게시판 테이블
-- 글번호, 아이디, 제목, 내용, 보상, 주소, 유형, 완료여부, 작성날짜, 알바시작날짜, 알바종료날짜, 조회수
--PK : JOB_SEQ(TB_JOB_SEQ)
CREATE TABLE TB_JOB
(
    JOB_SEQ         NUMBER            NOT NULL, 
    USER_ID         VARCHAR2(50)      NOT NULL, 
    JOB_TITLE       VARCHAR2(1000)    NOT NULL, 
    JOB_CONTENT     VARCHAR2(3000)    NOT NULL, 
    JOB_REWARD      NUMBER            NOT NULL, 
    JOB_ADDR        VARCHAR2(2000)    NULL, 
    JOB_CATEGORY    VARCHAR2(50)      NOT NULL, 
    JOB_COMPLETE    VARCHAR2(50)      NOT NULL, 
    JOB_DATE        VARCHAR2(20)      NOT NULL, 
    JOB_START       DATE              NOT NULL, 
    JOB_DONE        DATE              NOT NULL, 
    JOB_VIEW        NUMBER            NULL, 
    CONSTRAINT TB_JOB_PK PRIMARY KEY (JOB_SEQ)
)










SELECT * FROM (SELECT * FROM (SELECT ROWNUM RNM, JOB_SEQ, USER_ID, JOB_TITLE, JOB_CONTENT, JOB_REWARD, JOB_ADDR, JOB_CATEGORY, JOB_COMPLETE, JOB_DATE, JOB_START, JOB_DONE, JOB_VIEW FROM TB_JOB WHERE USER_ID = 'user@naver.com'))

SELECT * FROM (
		SELECT * FROM (
		SELECT ROWNUM RNM, JOB_SEQ, USER_ID, JOB_TITLE, JOB_CONTENT, JOB_REWARD, JOB_ADDR, JOB_CATEGORY, JOB_COMPLETE, JOB_DATE, JOB_START, JOB_DONE, JOB_VIEW
		FROM (SELECT * FROM TB_JOB WHERE USER_ID = 'user@naver.com' ORDER BY JOB_SEQ DESC)) WHERE RNM <=#{pageCount}) WHERE RNM >=#{pageNum}
		
		