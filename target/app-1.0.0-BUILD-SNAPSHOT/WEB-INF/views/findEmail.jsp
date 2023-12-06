<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLDecoder" %>

<%@ page session="false" %> <%-- 이 페이지에서는 세션을 새로 생성 안하겠다 라는 뜻 --%>
<c:set var="logInOutLink" value="${ pageContext.request.getSession(false).getAttribute('id')==null?'/member/login':'/member/logout'}" />
<<c:set var="logInOutTxt" value="${empty sessionScope.loginEmail ? '로그인' : '로그아웃'}" />
<c:set var="userId" value="${empty sessionScope.loginEmail ? '' : sessionScope.loginEmail}" />
<html>
<head>
    <title>main</title>

    <link rel="stylesheet" href="<c:url value='/css/header.css' />">
    <link rel="stylesheet" href="<c:url value='/css/common.css' />">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div id="wrap">
    <header>
        <div class="header_left">
            <a href="<c:url value='/'/> "><img src="<c:url value='/img/커뮤니티로고.png' />" alt=""></a></div>
        <div class="header_mid"><h1>FREE COMUNITY</h1></div>
        <div class="header_right">
            <ul>
                <li>${userId}님 환영합니다</li>
                <li><a href="<c:url value='${ logInOutLink }' />">${ logInOutTxt }</a></li>
                <!-- 로그인 되있으면 로그아웃. -->

                <a href="<c:url value='/member/join' /> "><li  class="b_r_h">회원가입</li></a>
            </ul>
        </div>
    </header>
    <nav>
        <ul>
            <a href="<c:url value='/board'/> "><li>커뮤니티 게시판</li></a>
            <a href="<c:url value='/board/popul'/> "><li>인기글 보기</li></a>
            <!-- 로그인 됬을떄 보이게 -->
            <a href="<c:url value='/mypage'/> "><li>마이페이지</li></a>
            <!-- 관리자한테는 회원정보리스트 보이게 -->
        </ul>
    </nav>




</div>

</body>

</html>