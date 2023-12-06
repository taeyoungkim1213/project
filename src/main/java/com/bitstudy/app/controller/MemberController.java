package com.bitstudy.app.controller;

import com.bitstudy.app.domain.MemberDTO;
import com.bitstudy.app.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    MemberService memberService;

    /*회원 가입 기능*/
    @GetMapping("/join")
    public String saveForm() {
        return "join";
    }


    @PostMapping("/join")
    public String save(@ModelAttribute MemberDTO memberDTO) {
        int saveResult = memberService.save(memberDTO);
        if (saveResult > 0) {
            return "login";
        } else {
            return "join";
        }
    }


    /*로그인 기능*/
    @GetMapping("/login")
    public String loginForm() {
        return "login";
    }

    @PostMapping("/login")
    public String login(@ModelAttribute MemberDTO memberDTO,
                        HttpSession session,
                        Model model) {
        boolean loginResult = memberService.login(memberDTO);
        if (loginResult) {
            session.setAttribute("loginEmail", memberDTO.getMemberEmail());
            return "redirect:/"; // 로그인 성공 시 홈페이지로 이동
        } else {
            model.addAttribute("errorMessage", "아이디 또는 비밀번호가 올바르지 않습니다."); // 로그인 실패 시 에러 메시지 전달
            return "login";
        }
    }
    /*로그아웃 기능*/
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // 세션을 비워 로그아웃
        return "redirect:/"; // 로그아웃 후 홈페이지로 이동
    }





    /*회원 목록 조회 기능(관리자 아이디 로그인시 보이게할것.)*/
    @GetMapping("/admin")
    public String getadmin() {
        return "admin";
    }
    @GetMapping("/")
    public String findAll(Model model) {
        List<MemberDTO> memberDTOList = memberService.findAll();
        model.addAttribute("memberList", memberDTOList);
        return "list";
    }

    // /member?id=1
    @GetMapping
    public String findById(@RequestParam("id") Long id, Model model) {
        MemberDTO memberDTO = memberService.findById(id);
        model.addAttribute("member", memberDTO);
        return "detail";
    }


    @GetMapping("/delete")
    public String delete(@RequestParam("id") Long id) {
        memberService.delete(id);
        return "redirect:/member/";
    }

    /*마이페이지 기능*/
    @GetMapping("/mypage")
    public String getMyPage(HttpSession session) {
        // 세션에서 로그인 정보 가져오기
        String loginEmail = (String) session.getAttribute("loginEmail");

        // 로그인 여부 확인
        if (loginEmail == null || loginEmail.isEmpty()) {
            // 로그인되지 않은 경우
            return "redirect:/member/login";
        } else {
            // 로그인된 경우 마이페이지로 이동
            return "mypage"; // 마이페이지 템플릿 이름으로 변경해야 합니다.
        }
    }

    /*회원 정보 수정 기능 마이페이지 안에서*/
    @GetMapping("/update")
    public String updateForm(HttpSession session, Model model) {
        // 세션에 저장된 나의 이메일 가져오기
        String loginEmail = (String) session.getAttribute("loginEmail");
        MemberDTO memberDTO = memberService.findByMemberEmail(loginEmail);
        model.addAttribute("member", memberDTO);
        return "update";
    }

    // 수정 처리
    @PostMapping("/update")
    public String update(@ModelAttribute MemberDTO memberDTO) {
        boolean result = memberService.update(memberDTO);
        if (result) {
            return "redirect:/member?id=" + memberDTO.getId();
        } else {
            return "index";
        }
    }

    //이메일 중복 확인 기능
    @PostMapping("/email-check")
    public @ResponseBody String emailCheck(@RequestParam("memberEmail") String memberEmail) {
        System.out.println("memberEmail = " + memberEmail);
        String checkResult = memberService.emailCheck(memberEmail);
        return checkResult;
    }

//    전화번호로 이메일 찾기
    @GetMapping("/findById")
    public String findIdByEmail() {
        return "findEmail";
    }
    @PostMapping("/findById")
    public String findEmail(@RequestParam("memberMobile") String memberMobile, Model model) {
        MemberDTO foundMember = memberService.findIdByEmail(memberMobile);
        if (foundMember != null && foundMember.getMemberEmail() != null && !foundMember.getMemberEmail().isEmpty()) {
            model.addAttribute("foundEmail", "찾은 이메일: "+foundMember.getMemberEmail());
        } else {
            model.addAttribute("notFoundMessage", "해당하는 이메일이 없습니다.");
        }

        return "findEmailResult";
    }

    //    이메일로 비밀번호 찾기
    @GetMapping("/findPw")
    public String findPwByEmail() {
        return "findPw";
    }
    @PostMapping("/findPw")
    public String findPw(@RequestParam("memberEmail") String memberMobile, Model model) {
        MemberDTO foundMember = memberService.findPwByEmail(memberMobile);

        if (foundMember != null && foundMember.getMemberPassword() != null && !foundMember.getMemberPassword().isEmpty()) {
            model.addAttribute("foundPw", "찾은 비밀번호: "+foundMember.getMemberPassword());

        } else {
            model.addAttribute("notFoundMessage", "해당하는 비밀번호가 없습니다.");
        }

        return "findPwResult";
    }





}


