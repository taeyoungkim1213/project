package com.bitstudy.app.domain;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class BoardDTO {
    private int boardId;
    private String boardWriter;//작성자 세션아이디값 받을 예정
    private String boardTitle; //제목
    private String boardContents; //내용
    private int boardPrice; // 상품가격
    private Date boardCreate; // 작성일
    private int boardHits; //조회수
    private String saleStatus; // 판매 상태 기본값 '판매중'
    private String boardFileName; //상품이미지 업로드
    private String boardFileDB; //상품이미지 DB담을 것

    public BoardDTO() {
    }

    public BoardDTO(String boardWriter, String boardTitle, String boardContents, int boardPrice, String saleStatus) {
        this.boardWriter = boardWriter;
        this.boardTitle = boardTitle;
        this.boardContents = boardContents;
        this.boardPrice = boardPrice;
        this.saleStatus = saleStatus;
    }
}

