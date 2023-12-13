package com.bitstudy.app.dao;


import com.bitstudy.app.domain.BoardLikeDTO;
import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@RequiredArgsConstructor
public class BoardLikeDAO {
    private final SqlSession sql;
    String namespace = "com.bitstudy.app.mapper.BoardLikeMapper.";

    public List<BoardLikeDTO> likelist(String userEmail) {
        return sql.selectList(namespace + "likelist", userEmail);
    }

    public int likePost(String userEmail, int boardId) {
        // userEmail, boardId를 매개변수로 하는 Mapper 호출
        return sql.insert(namespace + "likePost", Map.of("userEmail", userEmail, "boardId", boardId));
    }

    public int unlikePost(String userEmail, int boardId) {
        // userEmail, boardId를 매개변수로 하는 Mapper 호출
        return sql.delete(namespace + "unlikePost", Map.of("userEmail", userEmail, "boardId", boardId));
    }

    public boolean checkLikedStatus(String userEmail, int boardId) {
       return sql.selectOne(namespace + "checkLikedStatus",Map.of("userEmail", userEmail, "boardId", boardId));
    }
}
