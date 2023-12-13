package com.bitstudy.app.dao;

import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class BoardReportDAO {
    private final SqlSession sql;
    String namespace = "com.bitstudy.app.mapper.BoardReportMapper.";


}
