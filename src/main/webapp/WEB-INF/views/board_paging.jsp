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
    <title>게시판</title>

    <link rel="stylesheet" href="<c:url value='/css/header.css' />">
    <link rel="stylesheet" href="<c:url value='/css/common.css' />">
    <link rel="stylesheet" href="<c:url value='/css/board-paging.css' />">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div id="wrap">
    <jsp:include page="include/header.jsp" flush="false" />
<%--<form action="/board/search" method="GET" id="search-form">--%>
<%--    <input type="text" name="keyword" placeholder="검색어 입력">--%>
<%--    <input type="submit" value="검색">--%>
<%--</form>--%>
<%-- 검색 결과 표시 부분 --%>
<h2>검색 결과</h2>
<c:if test="${not empty searchResults}">
    <ul>
        <c:forEach items="${searchResults}" var="result">
            <li class="package_tour_review_li">
                <a href="/board?id=${result.boardId}">
                    <div class="user_info">
                        <div class="user_info_name"><b class="writer_b">${result.boardWriter}님</b><b class="r_date">
                            <fmt:formatDate value="${result.boardCreate}" pattern="MM-dd HH:mm" /></b> </div>
                        <div class="user_info_start_travel">
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
<%--<c:if test="${empty searchResults}">--%>
<%--    <p>검색 결과가 없습니다.</p>--%>
<%--</c:if>--%>
<%--ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ--%>
<div class="accompany_review review" id="accompany_review_review">
    <div class="orderby_desc">
        <button id="orderby_desc_btn_newest">
            <span id="orderby_desc_title_newest"><a href="/board/price_asc">금액 높은 순</a></span>
        </button>
        <button id="orderby_desc_btn_popularity" >
            <span id="orderby_desc_title_popularity"><a href="/board/price_desc">금액 낮은 순</a></span>
        </button>
    </div>
    <div id="sell_card">
        <ul class="accompany_review_ul" id="accompany_review_ul">
            <%--게시글 들어가는 부분--%>
            <c:forEach items="${boardList}" var="board">
                <li class="package_tour_review_li">
                    <a href="/board?id=${board.boardId}&page=${paging.page}">
                        <div class="user_info_travelinfo">
                            <div class="user_info_travelinfo_content">
                                <span>${board.saleStatus}</span>
                            </div>
                        </div>

                        <div class="accompany_review_img">
                            <img src="<c:url value='/upload/${board.boardFileName}'/>" alt="이미지 설명" />
                        </div>

                        <div class="user_info">
                            <div class="user_info_name">
                                <span>${board.boardTitle}</span>
                                <span class="r_date">
                                <fmt:formatDate value="${board.boardCreate}" pattern="MM월dd일 HH시" /></span>
                            </div>

                            <div class="user_info_start_travel"><!-- 여행 출발한 월 -->
                                <!-- 판매 상태 -->
                                <span class="user_info_contents">${board.boardContents}</span>
                                <!-- 상품 가격 -->
                                <span>${board.boardPrice} 원</span>
                            </div>
                        </div>
                    </a>
                </li>
            </c:forEach>
        </ul>

        <ul class="package_tour_review_ul" id="package_tour_review_ul">
            <%--게시글 들어가는 부분--%>

            <div class="select_review_page"> <%-- 하단 페이지 넘기는 방식 --%>
                <c:choose>
                    <%-- 현재 페이지가 1페이지면 이전 글자만 보여줌 --%>
                    <c:when test="${paging.page<=1}">
                        <span>[이전]</span>
                    </c:when>
                    <%-- 1페이지가 아닌 경우에는 [이전]을 클릭하면 현재 페이지보다 1 작은 페이지 요청 --%>
                    <c:otherwise>
                        <a href="/board/paging?page=${paging.page-1}">[이전]</a>
                    </c:otherwise>
                </c:choose>

                <%--  for(int i=startPage; i<=endPage; i++)      --%>
                <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="i" step="1">
                    <c:choose>
                        <%-- 요청한 페이지에 있는 경우 현재 페이지 번호는 텍스트만 보이게 --%>
                        <c:when test="${i eq paging.page}">
                            <span>${i}</span>
                        </c:when>

                        <c:otherwise>
                            <a href="/board/paging?page=${i}">${i}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:choose>
                    <c:when test="${paging.page>=paging.maxPage}">
                        <span>[다음]</span>
                    </c:when>
                    <c:otherwise>
                        <a href="/board/paging?page=${paging.page+1}">[다음]</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </ul>
    </div>
</div>
</div>
</body>
</html>
