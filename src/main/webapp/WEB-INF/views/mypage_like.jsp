<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLDecoder" %>

<c:set var="logInOutLink" value="${ pageContext.request.getSession(false).getAttribute('loginEmail')==null?'/member/login':'/member/logout'}" />
<c:set var="logInOutTxt" value="${empty sessionScope.loginEmail ? '로그인' : '로그아웃'}" />
<c:set var="loginEmail" value="${empty sessionScope.loginEmail ? '' : sessionScope.loginEmail}" />
<c:set var="loginEmail" value="${ pageContext.request.getSession(false).getAttribute('loginEmail')==null?'':pageContext.request.getSession(false).getAttribute('loginEmail')}" />
<c:set var="memberName" value="${ pageContext.request.getSession(false).getAttribute('memberName')==null?'':pageContext.request.getSession(false).getAttribute('memberName')}" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Title</title>

    <link rel="stylesheet" href="<c:url value='/css/header.css' />">
    <link rel="stylesheet" href="<c:url value='/css/common.css' />">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div id="wrap">
    <jsp:include page="include/header.jsp" flush="false" />

    <main style="width: 100%; height: 1000px; border: 1px solid; box-sizing: border-box">
        <%--추후 추가 할거 넣기--%>
            <c:choose>
                <c:when test="${empty boardLikeDTOS}">
                    <p>찜한 상품이 없습니다.</p>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${boardLikeDTOS}" var="boardLikeDTO">
                        <a href="/board?id=${boardLikeDTO.boardId}">
                            게시글번호: <b>${boardLikeDTO.boardId}</b>
                            작성자: <b>${boardLikeDTO.userEmail}</b>
                        </a>
                    </c:forEach>
                </c:otherwise>
            </c:choose>

    </main>
    <jsp:include page="include/footer.jsp" flush="false" />
</div>
</body>
</html>
