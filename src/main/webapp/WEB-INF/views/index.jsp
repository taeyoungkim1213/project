<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLDecoder" %>

<c:set var="logInOutLink" value="${ pageContext.request.getSession(false).getAttribute('loginEmail')==null?'/member/login':'/member/logout'}" />
<c:set var="logInOutTxt" value="${empty sessionScope.loginEmail ? '로그인' : '로그아웃'}" />
<c:set var="loginEmail" value="${empty sessionScope.loginEmail ? '' : sessionScope.loginEmail}" />
<c:set var="loginEmail" value="${ pageContext.request.getSession(false).getAttribute('loginEmail')==null?'':pageContext.request.getSession(false).getAttribute('loginEmail')}" />
<html>
<head>
	<title>main</title>

	<link rel="stylesheet" href="<c:url value='/css/header.css' />">
	<link rel="stylesheet" href="<c:url value='/css/common.css' />">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<button onclick="update()">내정보 수정하기</button>
<div id="wrap">
	<header>
		<div class="header_left">
			<a href="<c:url value='/'/> "><img src="<c:url value='/img/커뮤니티로고.png' />" alt=""></a></div>
		<div class="header_mid"><h1><a href="/">FREE COMUNITY</a></h1></div>
		<div class="header_right">
			<ul>
				<%-- 로그인이 되어 있을 때 --%>
				<c:if test="${not empty sessionScope.loginEmail}">
					<li>${loginEmail}님 환영합니다</li>
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
			<a href="<c:url value='/board'/> "><li>커뮤니티 게시판</li></a>
			<a href="<c:url value='/board/popul'/> "><li>인기글 보기</li></a>
			<!-- 로그인 됬을떄 보이게 -->
			<a href="<c:url value='/member/mypage'/> "><li>마이페이지</li></a>
			<!-- 관리자한테는 회원정보리스트 보이게 -->
			<c:if test="${loginEmail eq 'admin@admin.com'}">
				<a href="<c:url value='/member/admin'/> "><li>관리자페이지</li></a>
			</c:if>
		</ul>
	</nav>
</div>

</body>
<script>
	const update = () => {
		location.href = "/member/update";
	}

</script>
</html>