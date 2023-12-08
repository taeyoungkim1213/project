package com.bitstudy.app.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardLikeDTO {
    private int likeId;
    //아래는 외래키
    private String userEmail;
    private int boardId;

    public BoardLikeDTO() {
    }

    public BoardLikeDTO(int likeId, String userEmail, int boardId) {
        this.likeId = likeId;
        this.userEmail = userEmail;
        this.boardId = boardId;
    }
}
