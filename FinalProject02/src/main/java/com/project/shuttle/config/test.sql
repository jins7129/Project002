SELECT * FROM TB_USER;

SELECT * FROM TB_REPORT;

INSERT INTO TB_REPORT VALUES(1,'ID_TEST','WRITER_TEST',1,'94-01-04',SYSDATE,'CONTENT_TEST','TYPE_TEST','DIE');                                   


UPDATE TB_USER SET USER_IMGPATH = 'imgSample.png'
WHERE USER_ID = 'user@naver.com';


신고글번호 넘버
아이디 바차
신고작성자 바차
글번호 넘버
제재날짜 바차
신고날짜 데이트
신고내용 바차
신고유형 바차
제재상태 바차


INSERT INTO TB_JOB VALUES(TB_JOB_SEQ.NEXTVAL,'user@naver.com','test','test',50,'empty','test','N',SYSDATE,SYSDATE,SYSDATE,0)

SELECT * FROM TB_JOB

