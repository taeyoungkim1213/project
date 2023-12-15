package com.bitstudy.app.dao;

import com.bitstudy.app.domain.BoardDTO;
import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@RequiredArgsConstructor
public class BoardDAO {

    private final SqlSession sql;
    // 게시글 작성
    public int insertBoard(BoardDTO boardDTO) {
        return sql.insert("com.bitstudy.app.mapper.BoardMapper.insert", boardDTO);
    }

    // 모든 게시글 조회
    public List<BoardDTO> findAllBoards() {
        return sql.selectList("com.bitstudy.app.mapper.BoardMapper.findAll");
    }

    // 금액 오름차순으로 모든 게시글 조회
    public List<BoardDTO> findAllBoardsOrderByPriceAsc() {
        return sql.selectList("com.bitstudy.app.mapper.BoardMapper.findAllOrderByPriceAsc");
    }

    // 금액 내림차순으로 모든 게시글 조회
    public List<BoardDTO> findAllBoardsOrderByPriceDesc() {
        return sql.selectList("com.bitstudy.app.mapper.BoardMapper.findAllOrderByPriceDesc");
    }

    // 키워드로 게시글 검색
    public List<BoardDTO> findBoardsByKeyword(String keyword) {
        return sql.selectList("com.bitstudy.app.mapper.BoardMapper.findByKeyword", keyword);
    }

    // 아이디로 게시글 조회
    public BoardDTO findById(int boardId) {
        return sql.selectOne("com.bitstudy.app.mapper.BoardMapper.findById", boardId);
    }

    // 조회수 증가
    public int updateHits(int boardId) {
        return sql.update("com.bitstudy.app.mapper.BoardMapper.updateHits", boardId);
    }

    // 게시글 수정
    public int updateBoard(BoardDTO boardDTO) {
        return sql.update("com.bitstudy.app.mapper.BoardMapper.update", boardDTO);
    }

    // 게시글 삭제
    public int deleteBoard(int boardId) {
        return sql.delete("com.bitstudy.app.mapper.BoardMapper.delete", boardId);
    }

    public String findMain(int boardID){
        return sql.selectOne("com.bitstudy.app.mapper.BoardMapper.findMain",boardID);
    }

    // 판매 상태 변경
    public int updateSaleStatus(BoardDTO boardDTO) {
        return sql.update("com.bitstudy.app.mapper.BoardMapper.updateSaleStatus", boardDTO);
    }
    public int boardCount() {

        return sql.selectOne("com.bitstudy.app.mapper.BoardMapper.boardCount", "boardCount");
    }

    //최근순으로 리스트
    public List<BoardDTO> pagingList(Map<String, Integer> pagingParams) {
        return sql.selectList("com.bitstudy.app.mapper.BoardMapper.pagingList", pagingParams);
    }



}
