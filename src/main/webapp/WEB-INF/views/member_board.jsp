<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLDecoder" %>

<c:set var="logInOutLink" value="${ pageContext.request.getSession(false).getAttribute('loginEmail')==null?'/member/login':'/member/logout'}" />
<c:set var="logInOutTxt" value="${empty sessionScope.loginEmail ? '로그인' : '로그아웃'}" />
<c:set var="loginEmail" value="${empty sessionScope.loginEmail ? '' : sessionScope.loginEmail}" />
<c:set var="loginEmail" value="${ pageContext.request.getSession(false).getAttribute('loginEmail')==null?'':pageContext.request.getSession(false).getAttribute('loginEmail')}" />
<c:set var="memberName" value="${ pageContext.request.getSession(false).getAttribute('memberName')==null?'':pageContext.request.getSession(false).getAttribute('memberName')}" />
<html>
<head>
    <title>내가 쓴 글</title>

    <link rel="stylesheet" href="<c:url value='/css/header.css' />">
    <link rel="stylesheet" href="<c:url value='/css/common.css' />">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div id="wrap">
    <jsp:include page="include/header.jsp" flush="false" />

    <main style="width: 100%; height: 1000px; border: 1px solid; box-sizing: border-box">
        <%--추후 추가 할거 넣기--%>
            <c:if test="${not empty boardDTOList}">
                <ul>
                    <c:forEach items="${boardDTOList}" var="result">
                        <li class="package_tour_review_li">
                            <a href="/board?id=${result.boardId}">
                                <div class="user_info">
                                    <div class="user_info_name"><b class="writer_b">${result.boardWriter}님</b><b class="r_date">
                                        <fmt:formatDate value="${result.boardCreate}" pattern="MM-dd HH:mm" /></b> </div>
                                    <div class="user_info_start_travel"><!-- 여행 출발한 월 -->
                                        <span> 제목 : ${result.boardTitle}</span>
                                        <!-- 상품 가격 -->
                                        <span>가격: ${result.boardPrice}</span>
                                        <!-- 판매 상태 -->
                                        <span>상태: ${result.saleStatus}</span>
                                    </div>
                                </div>
                                <div class="accompany_review_img">
                                    <img src="<c:url value='/upload/${board.boardFileName}'/>" alt="이미지 설명" />
                                </div>
                                <div class="user_info_travelinfo">
                                    <div class="user_info_travelinfo_content">
                                        <p class="user_info_contents">내용 :  ${board.boardContents}</p>
                                    </div>
                                </div>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </c:if>
            <c:if test="${empty searchResults}">
                <p>검색 결과가 없습니다.</p>
            </c:if>

    </main>
    <jsp:include page="include/footer.jsp" flush="false" />
</div>
</body>
</html>
