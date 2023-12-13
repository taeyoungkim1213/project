package com.bitstudy.app.controller;

import com.bitstudy.app.domain.BoardDTO;
import com.bitstudy.app.domain.MemberDTO;
import com.bitstudy.app.domain.ReviewPageDto;
import com.bitstudy.app.service.BoardService;
import kr.co.util.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.List;

@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    BoardService boardService;

    @GetMapping("/save")
    public String getsave(Model model, HttpSession httpSession, MemberDTO memberDTO) {
        String MemberDTO = (String) httpSession.getAttribute("MemberDTO");

        BoardDTO boardDTO =new BoardDTO();
        boardDTO.setBoardWriter(memberDTO.getMemberName());
        model.addAttribute("boardDTO",boardDTO);
        //로그인 유효성검사
        String loginEmail = (String) httpSession.getAttribute("loginEmail");
        if (loginEmail != null) {
            // 로그인 상태이므로 처리
            // ...
            return "board_save";
        } else {
            // 로그인되지 않은 사용자는 로그인 페이지로 리다이렉트
            return "redirect:/member/login";
        }

    }

    @PostMapping("/save") // 게시물 작성 post
    public ModelAndView Postsave(BoardDTO boardDTO,
                                 HttpServletRequest request,
                                 MultipartFile imageFile
                            ) throws Exception{
        String path = "resources/upload/"; //이미지 넣을 폴더
        String realPath = request.getRealPath(path); //리얼주소
        String fileName = imageFile.getOriginalFilename(); //오리지날 이름
        System.out.println("realPath: " + realPath);
        String defaultImage = "커뮤니티로고.png"; //기본이미지 설정.

        //  realPath 경로에 해당하는 폴더가 없으면 폴더 생성
        File uploadDir = new File(realPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        //         이미지 파일인지 확인
        if (imageFile != null || !imageFile.isEmpty() || !FileUtil.isImageFile(imageFile.getOriginalFilename())) {
            // 이미지 파일이 선택되지 않았거나 선택된 파일이 이미지가 아닌 경우
        }

        if (imageFile!=null&&!imageFile.isEmpty()){
            //저장하려는 파일 시스템의 실제위치와 파일명 찾기
            String saveFileName = FileUtil.checkDuplicate(realPath + fileName);
            //살제적인 파일로 저장
            imageFile.transferTo(new File(saveFileName));
            String uploadFileName = saveFileName.substring(saveFileName.lastIndexOf("\\") + 1); // d이름만 뽑음
            boardDTO.setBoardFileName(uploadFileName);
            boardDTO.setBoardFileDB(fileName);//오리지널이름
        }
        else {
            boardDTO.setBoardFileName(defaultImage);
        }

        boardService.insertBoard(boardDTO);

        return new ModelAndView("redirect:/board/paging");


    }


    // 처음 페이지 요청은 1페이지를 보여줌
    //detail 에서 목록으로 돌아가기
    @GetMapping("/") //최근순
    public String paging(Model model,
                         @RequestParam(value = "page", required = false, defaultValue = "1") int page) {

        List<BoardDTO> boardDTOList = boardService.pagingList(page);

        ReviewPageDto pageDTO = boardService.pagingParam(page);
        model.addAttribute("boardList", boardDTOList);
        model.addAttribute("paging", pageDTO);
        return "board_paging";
    }

    @GetMapping
    public String findById(@RequestParam("id") int id,
                           @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                           Model model,
                           HttpSession httpSession ) {
        String loginId = (String) httpSession.getAttribute("loginEmail");
            Integer viewedPostId = (Integer) httpSession.getAttribute("viewedPostId");

        // 세션에 저장된 ID와 현재 조회하려는 게시글의 ID가 같지 않은 경우에만 조회수 증가 1회만 증가시키기위함.
        if (loginId != null && (viewedPostId == null || !viewedPostId.equals(id)))  {
            boardService.updateHits(id);

            // 현재 조회 중인 게시글의 ID를 세션에 저장
            httpSession.setAttribute("viewedPostId", id);
        }
        // 로그인 여부와 관계없이 게시글 정보를 가져옴
        BoardDTO reviewDto = boardService.findById(id);

        model.addAttribute("board", reviewDto);
        model.addAttribute("page", page);
//        List<ReviewCommentDto> reviewCommentDtoList = reviewCommentService.findAll(id);
//        model.addAttribute("commentList", reviewCommentDtoList);

        if (loginId != null) {
            return "detail";
        } else {
            // 로그인되지 않은 사용자는 로그인 페이지로 리다이렉트
            return "redirect:/member/login";
        }
    }
    // /board/paging?page=2
    // 처음 페이지 요청은 1페이지를 보여줌





}












