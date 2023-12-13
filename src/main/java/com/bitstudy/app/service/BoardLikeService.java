package com.bitstudy.app.service;

import com.bitstudy.app.dao.BoardLikeDAO;
import com.bitstudy.app.domain.BoardLikeDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class BoardLikeService {
    @Autowired
    BoardLikeDAO boardLikeDAO;

    public List<BoardLikeDTO> likelist(String userEmail){
        return boardLikeDAO.likelist(userEmail);
    }

    public int likePost(String userEmail, int boardId){
        return boardLikeDAO.likePost(userEmail,boardId);
    }

    public int unlikePost(String userEmail, int boardId) {
        return boardLikeDAO.unlikePost(userEmail , boardId);
    }

    public boolean checkLikedStatus(String userEmail, int boardId) {
        return boardLikeDAO.checkLikedStatus(userEmail,boardId);
    }
}
