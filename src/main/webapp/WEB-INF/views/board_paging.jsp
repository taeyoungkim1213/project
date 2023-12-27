<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page contentType="text/html;charset=utf-8"%>

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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<header>
    <div class="header_left">
        <a href="<c:url value='/'/> "><img src="<c:url value='/img/커뮤니티로고.png' />" alt=""></a></div>
    <div class="header_mid"><h1><a href="/">FREE COMUNITY</a></h1></div>
    <div class="header_right">
        <ul>
            <%-- 로그인이 되어 있을 때 --%>
            <c:if test="${not empty sessionScope.loginEmail}">
               <li>${memberName}님 환영합니다</li>
            </c:if>
            <%-- 로그인이 안 되어 있을 때 --%>
            <c:if test="${empty sessionScope.loginEmail}">
                <li>로그인을 해주세요</li>
            </c:if>
            <li><a href="<c:url value='${ logInOutLink }' />">${ logInOutTxt }</a></li>
            <!-- 로그인 되있으면 로그아웃. -->

            <a href="<c:url value='/member/join' /> "><li  class="b_r_h">회원가입</li></a>
        </ul>
    </div>
</header>
<nav>
    <ul>
        <a href="<c:url value='/board/'/> "><li>커뮤니티 게시판</li></a>
        <a href="<c:url value='/board/popul'/> "><li>인기글 보기</li></a>
        <!-- 로그인 됬을떄 보이게 -->
        <a href="<c:url value='/member/update'/> "><li>마이페이지</li></a>
        <!-- 관리자한테는 회원정보리스트 보이게 -->
        <c:if test="${loginEmail eq 'admin@admin.com'}">
            <a href="<c:url value='/member/admin'/> "><li>관리자페이지</li></a>
        </c:if>
    </ul>
</nav>

<form action="/board/search" method="GET">
    <input type="text" name="keyword" placeholder="검색어 입력">
    <input type="submit" value="검색">
</form>
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
ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
<div class="accompany_review review" id="accompany_review_review">
    <div class="orderby_desc">
        <button id="orderby_desc_btn_newest">
            <span id="orderby_desc_title_newest"><a href="/board/price_asc">금액 낮은 순</a></span>
        </button>
        <button id="orderby_desc_btn_popularity" >
            <span id="orderby_desc_title_popularity"><a href="/board/price_desc">금액 높은 순</a></span>
        </button>
    </div>
    <div>
        <ul class="accompany_review_ul" id="accompany_review_ul">
            <%--게시글 들어가는 부분--%>
            <c:forEach items="${boardList}" var="board">
                <li class="package_tour_review_li">
                    <a href="/board?id=${board.boardId}&page=${paging.page}">
                        <div class="user_info">
                            <div class="user_info_name"><b class="writer_b">${board.boardWriter}님</b><b class="r_date">
                                <fmt:formatDate value="${board.boardCreate}" pattern="MM-dd HH:mm" /></b> </div>
                            <div class="user_info_start_travel"><!-- 여행 출발한 월 -->
                                <span> 제목 : ${board.boardTitle}</span>
                                <!-- 상품 가격 -->
                                <span>가격: ${board.boardPrice}</span>
                                <!-- 판매 상태 -->
                                <span>상태: ${board.saleStatus}</span>
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

</body>
</html>
