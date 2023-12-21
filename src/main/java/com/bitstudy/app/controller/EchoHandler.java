package com.bitstudy.app.controller;

import com.bitstudy.app.domain.BoardDTO;
import com.bitstudy.app.service.BoardService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import javax.servlet.http.HttpSession;
import java.net.http.WebSocket;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Component
@RequestMapping("/echo")
public class EchoHandler extends TextWebSocketHandler {
    @Autowired
    BoardService boardService;


    @GetMapping ("/")
    public String getSocket(HttpSession httpSession, Model model,
                            @RequestParam("id") int id) {
        String memberName = (String) httpSession.getAttribute("memberName");
        /*게시글 작성자 정보 가져오기 소켓을위해*****/
        BoardDTO board = boardService.findById(id);
        String writerEmail = board.getBoardWriter();

        // 작성자와 현재 로그인한 사용자 정보를 웹소켓 핸들러로 전달
        model.addAttribute("writerEmail", writerEmail);
        model.addAttribute("memberName", memberName);
        /*소켓을 위해******/
        return "chat_room";
    }

    // 세션 리스트
    private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
    private static Logger logger = LoggerFactory.getLogger(EchoHandler.class);

    // 클라이언트가 연결 되었을 때 실행
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        sessionList.add(session);
        logger.info("{} 연결됨", session.getAttributes().get("memberName"));

        //모든세션에 채팅 전달.
        for (int i=0; i< sessionList.size();i++) {
            WebSocketSession s = sessionList.get(i);
            s.sendMessage(new TextMessage(": ["+session.getAttributes().get("memberName")+"님이 입장 했습니다.]"));

        }

        // ... (기타 로직)
    }

    // 클라이언트가 웹소켓 서버로 메시지를 전송했을 때 실행
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String sender = (String) session.getAttributes().get("memberName");
        String messageToSend = "[" + sender + "]: " + message.getPayload(); // 작성자 식별자 추가
        for (WebSocketSession sess : sessionList) {
            sess.sendMessage(new TextMessage(messageToSend));
        }
    }

    // 클라이언트 연결을 끊었을 때 실행
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        sessionList.remove(session);
        logger.info("{} 연결 끊김.", session.getAttributes().get("memberName"));
    }
}
