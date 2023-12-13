package com.bitstudy.app.controller;

import com.bitstudy.app.domain.BoardDTO;
import com.bitstudy.app.domain.BoardLikeDTO;
import com.bitstudy.app.service.BoardLikeService;
import com.bitstudy.app.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class BoardLikeController {
    @Autowired
    BoardLikeService boardLikeService;
    BoardService boardService;


    @GetMapping("/member/like")
    public String memberLike(BoardDTO boardDTO,HttpSession session, Model model) {
        String userEmail = (String) session.getAttribute("loginEmail");
        List<BoardLikeDTO> boardLikeDTOS = boardLikeService.likelist(userEmail);
        System.out.println(boardLikeDTOS);

        model.addAttribute("boardLikeDTOS",boardLikeDTOS);
        return "mypage_like";
    }
    // 찜하기

    @GetMapping("/checkLikedStatus")
    public ResponseEntity<Boolean> checkLikedStatus(@RequestParam int boardId, HttpSession session) {
        String userEmail = (String) session.getAttribute("loginEmail");

        if (userEmail != null) {
            boolean isLiked = boardLikeService.checkLikedStatus(userEmail, boardId);
            return ResponseEntity.ok(isLiked);
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(false);
        }
    }

    @PostMapping("/like")
    public ResponseEntity<String> likePost(@RequestParam int boardId, HttpSession session) {
        String userEmail = (String) session.getAttribute("loginEmail");

        if (userEmail != null) {
            boardLikeService.likePost(userEmail, boardId);
            return ResponseEntity.ok("Liked");
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인을 해주세요.");
        }
    }

    // 찜 취소하기
    @PostMapping("/unlike")
    public ResponseEntity<String> unlikePost(@RequestParam int boardId, HttpSession session) {
        String userEmail = (String) session.getAttribute("loginEmail");

        if (userEmail != null) {
            boardLikeService.unlikePost(userEmail, boardId);
            return ResponseEntity.ok("Unliked");
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인을 해주세요.");
        }
    }

}
