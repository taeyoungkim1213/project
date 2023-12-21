<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLDecoder" %>

<c:set var="logInOutLink" value="${ pageContext.request.getSession(false).getAttribute('loginEmail')==null?'/member/login':'/member/logout'}" />
<c:set var="logInOutTxt" value="${empty sessionScope.loginEmail ? '로그인' : '로그아웃'}" />
<c:set var="loginEmail" value="${empty sessionScope.loginEmail ? '' : sessionScope.loginEmail}" />
<c:set var="loginEmail" value="${ pageContext.request.getSession(false).getAttribute('loginEmail')==null?'':pageContext.request.getSession(false).getAttribute('loginEmail')}" />
<c:set var="memberName" value="${ pageContext.request.getSession(false).getAttribute('memberName')==null?'':pageContext.request.getSession(false).getAttribute('memberName')}" />
<%
    String writerEmail = (String) request.getAttribute("writerEmail");
    String memberName = (String) request.getAttribute("memberName");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
    <script type="text/javascript"
            src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>

</head>
<body>
<div>
    <% if (writerEmail != null) { %>
    <h2>게시글 작성자: <%= writerEmail %></h2>
    <% } %>
    <h2>현재 사용자: <%= memberName %></h2>
    <!-- 채팅 메시지 영역 등을 여기에 추가 -->
</div>

<input type="text" id="message" />
<input type="button" id="sendBtn" value="채팅"/>

<!-- 채팅 메시지 영역 등을 여기에 추가 -->
<div id="messageArea">
    <!-- 메시지 영역 -->

</div>

</body>
<script type="text/javascript">
    $("#sendBtn").click(function() {
        sendMessage();
        $('#message').val('')
    });

    let sock = new SockJS("http://localhost:8080/echo/");
    sock.onmessage = onMessage;
    sock.onclose = onClose;

    // 메시지 전송
    function sendMessage() {
        sock.send($("#message").val());
    }
    // 서버로부터 메시지를 받았을 때
    function onMessage(msg) {
        var data = msg.data;
        var messageArea = $("#messageArea");

        // 작성자와 사용자 구분하기
        var isWriter = data.startsWith("[작성자:");
        var isUser = data.startsWith("[사용자:");

        // 작성자와 사용자에 따라 다른 스타일로 메시지 출력
        if (isWriter || isUser) {
            var label = isWriter ? "작성자: " : "사용자: ";
            var color = isWriter ? "blue" : "green";
            var message = "<span style='color: " + color + "; font-weight: bold;'>" + label + "</span>" + data.substring(data.indexOf("]") + 2);
            messageArea.append(message + "<br/>");
        } else {
            messageArea.append(data + "<br/>");
        }
    }
    // 서버와 연결을 끊었을 때
    function onClose(evt) {
        $("#messageArea").append("연결 끊김");

    }


</script>
</html>
