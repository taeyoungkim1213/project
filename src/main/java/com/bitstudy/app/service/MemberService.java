package com.bitstudy.app.service;


import com.bitstudy.app.dao.MemberDAO;
import com.bitstudy.app.domain.MemberDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class MemberService {
    private final MemberDAO memberdao;
    public int save(MemberDTO memberDTO) {
        return memberdao.save(memberDTO);
    }

    public boolean login(MemberDTO memberDTO) {
        MemberDTO loginMember = memberdao.login(memberDTO);
        if (loginMember != null) {
            return true;
        } else {
            return false;
        }
    }

    public List<MemberDTO> findAll() {
        return memberdao.findAll();
    }

    public MemberDTO findById(Long id) {
        return memberdao.findById(id);
    }

    public void delete(Long id) {
        memberdao.delete(id);
    }

    public MemberDTO findByMemberEmail(String loginEmail) {
        return memberdao.findByMemberEmail(loginEmail);
    }

    public boolean update(MemberDTO memberDTO) {
        int result = memberdao.update(memberDTO);
        if (result > 0) {
            return true;
        } else {
            return false;
        }
    }

    public String emailCheck(String memberEmail) {
        MemberDTO memberDTO = memberdao.findByMemberEmail(memberEmail);
        if (memberDTO == null) {
            return "ok";
        } else {
            return "no";
        }
    }
    // 전화번호로 아이디 찾기
    public MemberDTO findIdByEmail(String memberMobile) {
        return memberdao.findIdByEmail(memberMobile);
    }

}
