package com.bitstudy.app.domain;


import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.annotations.ConstructorArgs;

@Getter
@Setter

public class MemberDTO {
    private Long id;
    private String memberEmail;
    private String memberPassword;
    private String memberName;
    private int memberAge;
    private String memberMobile;
    private boolean rememberMe;

    public MemberDTO() {
    }

    public MemberDTO(String memberEmail, String memberPassword, String memberName, int memberAge, String memberMobile) {
        this.memberEmail = memberEmail;
        this.memberPassword = memberPassword;
        this.memberName = memberName;
        this.memberAge = memberAge;
        this.memberMobile = memberMobile;
    }
}
