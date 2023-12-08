package com.bitstudy.app.service;

import com.bitstudy.app.dao.BoardDAO;
import com.bitstudy.app.domain.BoardDTO;
import com.bitstudy.app.domain.ReviewPageDto;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class BoardService {

    @Autowired
    BoardDAO boardDAO;

    public int insertBoard(BoardDTO boardDTO) {
        return boardDAO.insertBoard(boardDTO);
    }

    public List<BoardDTO> findAllBoards() {
        return boardDAO.findAllBoards();
    }

    public List<BoardDTO> findAllBoardsOrderByPriceAsc() {
        return boardDAO.findAllBoardsOrderByPriceAsc();
    }

    public List<BoardDTO> findAllBoardsOrderByPriceDesc() {
        return boardDAO.findAllBoardsOrderByPriceDesc();
    }

    public List<BoardDTO> findBoardsByKeyword(String keyword) {
        return boardDAO.findBoardsByKeyword(keyword);
    }

    public BoardDTO findBoardById(int boardId) {
        return boardDAO.findBoardById(boardId);
    }

    public int updateHits(int boardId) {
        return boardDAO.updateHits(boardId);
    }

    public int updateBoard(BoardDTO boardDTO) {
        return boardDAO.updateBoard(boardDTO);
    }

    public int deleteBoard(int boardId) {
        return boardDAO.deleteBoard(boardId);
    }

    public int updateSaleStatus(int boardId, String saleStatus) {
        BoardDTO boardDTO = new BoardDTO();
        boardDTO.setBoardId(boardId);
        boardDTO.setSaleStatus(saleStatus);
        return boardDAO.updateSaleStatus(boardDTO);
    }

    //    페이징 리스트 조회

    int pageLimit = 10; // 한 페이지당 보여줄 글 갯수
    int blockLimit = 5; // 하단에 보여줄 페이지 번호 갯수
    //최근순
    public List<BoardDTO> pagingList(int page) {

        int pagingStart = (page - 1) * pageLimit;
        Map<String, Integer> pagingParams = new HashMap<>();
        pagingParams.put("start", pagingStart);
        pagingParams.put("limit", pageLimit);
        return boardDAO.pagingList(pagingParams);
    }

    public ReviewPageDto pagingParam(int page) {
        // 전체 글 갯수 조회
        int boardCount = boardDAO.boardCount();
        // 전체 페이지 갯수 계산(10/3=3.33333 => 4)
        int maxPage = (int) (Math.ceil((double) boardCount / pageLimit));
        // 시작 페이지 값 계산(1, 4, 7, 10, ~~~~)
        int startPage = (((int) (Math.ceil((double) page / blockLimit))) - 1) * blockLimit + 1;
        // 끝 페이지 값 계산(3, 6, 9, 12, ~~~~)
        int endPage = startPage + blockLimit - 1;
        if (endPage > maxPage) {
            endPage = maxPage;
        }
        ReviewPageDto pageDTO = new ReviewPageDto();
        pageDTO.setPage(page);
        pageDTO.setMaxPage(maxPage);
        pageDTO.setStartPage(startPage);
        pageDTO.setEndPage(endPage);
        return pageDTO;
    }

}
