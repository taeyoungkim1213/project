package com.bitstudy.app.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardReportDTO {
    private int reportId;
    private String report_reason;
    private String report_date;
    //아래는 외래키
    private String userEmail;
    private int boardId;

    public BoardReportDTO() {
    }

    public BoardReportDTO(int reportId, String report_reason, String report_date, String userEmail, int boardId) {
        this.reportId = reportId;
        this.report_reason = report_reason;
        this.report_date = report_date;
        this.userEmail = userEmail;
        this.boardId = boardId;
    }
}
