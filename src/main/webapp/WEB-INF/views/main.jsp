<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLDecoder" %>

<c:set var="logInOutLink" value="${ pageContext.request.getSession(false).getAttribute('id')==null?'/login/login':'/login/logout'}" />
<c:set var="logInOutTxt" value="${ pageContext.request.getSession(false).getAttribute('id')==null?'로그인':'로그아웃'}" />
<c:set var="userId" value="${ pageContext.request.getSession(false).getAttribute('id')==null?'':pageContext.request.getSession(false).getAttribute('id')}" />
<html>
<head>
    <title>main</title>

    <link rel="stylesheet" href="<c:url value='/css/header.css' />">
    <link rel="stylesheet" href="<c:url value='/css/common.css' />">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <h2>${sessionScope.loginEmail} 님 환영합니다.</h2>
    <button onclick="update()">내정보 수정하기</button>
    <button onclick="logout()">로그아웃</button>
<div id="wrap">
    <header>
        <div class="header_left">
            <a href="#"><img src="<c:url value='/img/커뮤니티로고.png' />" alt=""></a></div>
        <div class="header_mid"><h1>FREE COMUNITY</h1></div>
        <div class="header_right">
            <ul>
                <li>xxx님 환영합니다</li>
                <a href=""><li  class="b_r_h">로그인</li></a>
                <!-- 로그인 되있으면 로그아웃. -->
                <a href=""><li  class="b_r_h">회원가입</li></a>
            </ul>
        </div>
    </header>
    <nav>
        <ul>
            <a href=""><li>커뮤니티 게시판</li></a>
            <a href=""><li>인기글 보기</li></a>
            <!-- 로그인 됬을떄 보이게 -->
            <a href=""><li>마이페이지</li></a>
            <!-- 관리자한테는 회원정보리스트 보이게 -->
        </ul>
    </nav>
</div>

</body>
<script>
    const update = () => {
        location.href = "/member/update";
    }
    const logout = () => {
        location.href = "/member/logout";
    }
</script>
</html>