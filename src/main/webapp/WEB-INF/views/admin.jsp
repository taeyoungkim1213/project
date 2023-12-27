<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLDecoder" %>

<c:set var="logInOutLink" value="${ pageContext.request.getSession(false).getAttribute('loginEmail')==null?'/member/login':'/member/logout'}" />
<c:set var="logInOutTxt" value="${empty sessionScope.loginEmail ? '로그인' : '로그아웃'}" />
<c:set var="loginEmail" value="${empty sessionScope.loginEmail ? '' : sessionScope.loginEmail}" />
<c:set var="memberName" value="${ pageContext.request.getSession(false).getAttribute('memberName')==null?'':pageContext.request.getSession(false).getAttribute('memberName')}" />
<html>
<head>
    <title>main</title>
    <link rel="stylesheet" href="<c:url value='/css/admin.css' />">
    <link rel="stylesheet" href="<c:url value='/css/header.css' />">
    <link rel="stylesheet" href="<c:url value='/css/common.css' />">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div id="wrap">
    <jsp:include page="include/header.jsp" flush="false" />

    <main>
        <ul>
            <a href="/member/"><li>회원정보관리</li></a>
            <a href="#"><li>거래완료된 게시글</li></a>
            <a href="#"><li>신고된 게시글</li></a>
        </ul>
    </main>
    <footer></footer>



</div>

</body>
</html>