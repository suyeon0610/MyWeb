package com.spring.myweb.command;

/*
 CREATE TABLE freereply(
    rno NUMBER(10, 0),
    bno NUMBER(10, 0),
    reply VARCHAR2(1000),
    reply_id VARCHAR2(50),
    reply_pw VARCHAR2(50),
    reply_date DATE DEFAULT SYSDATE,
    update_date DATE DEFAULT NULL
);

CREATE SEQUENCE freereply_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 1000
    NOCYCLE
    NOCACHE;
    
ALTER TABLE freereply
ADD CONSTRAINT freereply_pk PRIMARY KEY(rno);

# 1. ON DELETE CASCADE:
참조되는 부모 테이블의 행에 대한 DELETE를 허용함.
즉, fk를 통한 자식 테이블의 참조가 있더라도, 부모 테이블의 데이터가 삭제되면
연계된 자식 테이블의 데이터까지 모두 삭제 됨
테이블의 구조가 복잡하다면 (하나의 테이블에 여러 테이블이 연계 되어 있는 경우)
CASCADE 사용을 고려해 봐야 함

# 2. ON DELETE SET NULL;
부모 테이블의 값이 삭제된다면 해당 값을 참조하던 자식 테이블의 값을 null로 설정.
 fk로 설정된 bno의 값을 null로 설정
 
 FOREIGN KEY를 설정하면, 참조 무결성 규칙 발동 됨
 참조 무결성 -> 참조 관계에 있는 도 테이블의 데이터는 항상 일관된 값을 가져야 함.
 데이터베이스 구조가 많이 복잡하지 않다면 논리적 모델린까지는 FK를 설정하지만
 물리적 모델링의 경우에는 FK를 생략하는 경우도 많음.

ALTER TABLE freereply
ADD CONSTRAINT freereply_fk FOREIGN KEY(bno)
REFERENCES freeboard(bno) ON DELETE CASCADE;
 */

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReplyVO {

	private int rno;
	private int bno;
	
	private String reply;
	private String replyId;
	private String replyPw;
	private Timestamp replyDate;
	private Timestamp updateDate;
	
}
