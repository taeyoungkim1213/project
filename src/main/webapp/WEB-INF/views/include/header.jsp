<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLDecoder" %>

<c:set var="logInOutLink" value="${ pageContext.request.getSession(false).getAttribute('loginEmail')==null?'/member/login':'/member/logout'}" />
<c:set var="logInOutTxt" value="${empty sessionScope.loginEmail ? '로그인' : '로그아웃'}" />
<c:set var="loginEmail" value="${empty sessionScope.loginEmail ? '' : sessionScope.loginEmail}" />
<c:set var="loginEmail" value="${ pageContext.request.getSession(false).getAttribute('loginEmail')==null?'':pageContext.request.getSession(false).getAttribute('loginEmail')}" />
<c:set var="memberName" value="${ pageContext.request.getSession(false).getAttribute('memberName')==null?'':pageContext.request.getSession(false).getAttribute('memberName')}" />

<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="<c:url value='/css/header.css' />">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
        <header>
            <div class="header_left">
                <a href="<c:url value='/'/> "><img src="<c:url value='/img/logo.png' />" alt=""></a></div>
            <%--검색창--%>
            <div class="header_mid">
<%--                <form action="/board/search" method="GET" id="search-form">--%>
<%--                    <input type="text" name="keyword" placeholder="검색어 입력">--%>
<%--                    <input type="submit" value="검색">--%>
<%--                </form>--%>
            </div>


            <div class="header_right">

                <ul>
                    <li id="search">
                        <form action="/board/search" method="GET" id="search-form">
                            <input type="text" name="keyword" placeholder="검색어를 입력해주세요" id="search_bar">
                            <input type="submit" value="" id="search_btn">
                        </form>
                    </li>
                    <%-- 로그인이 되어 있을 때 --%>
                    <c:if test="${not empty sessionScope.loginEmail}">
                        <li>${memberName}님 환영합니다</li>
                    </c:if>
                    <li>
                        <a href="<c:url value='${ logInOutLink }' />">${ logInOutTxt }</a>
                    </li>
                    <!-- 로그인 되있으면 로그아웃. -->
                    <c:if test="${sessionScope.loginEmail eq null}">
                        <li  class="b_r_h">
                            <a href="<c:url value='/member/join' /> ">회원가입</a>
                        </li>
                    </c:if>
                    <c:if test="${loginEmail eq 'admin@admin.com'}">
                        <li><a href="<c:url value='/member/admin'/> ">관리자페이지</a></li>
                    </c:if>


                </ul>
            </div>
        </header>
        <nav>
            <ul>
                <li><a href="<c:url value='/board/'/> ">커뮤니티 게시판</a></li>
                <li><a href="<c:url value='/board/popul/'/> ">인기글 보기</a></li>
                <li><a href="<c:url value='/member/update/'/> ">마이페이지</a></li>

            </ul>
        </nav>
</body>
</html>
