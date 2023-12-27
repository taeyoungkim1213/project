<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLDecoder" %>

<c:set var="logInOutLink" value="${ pageContext.request.getSession(false).getAttribute('loginEmail')==null?'/member/login':'/member/logout'}" />
<c:set var="logInOutTxt" value="${empty sessionScope.loginEmail ? '로그인' : '로그아웃'}" />
<c:set var="loginEmail" value="${empty sessionScope.loginEmail ? '' : sessionScope.loginEmail}" />
<c:set var="loginEmail" value="${ pageContext.request.getSession(false).getAttribute('loginEmail')==null?'':pageContext.request.getSession(false).getAttribute('loginEmail')}" />
<c:set var="memberName" value="${ pageContext.request.getSession(false).getAttribute('memberName')==null?'':pageContext.request.getSession(false).getAttribute('memberName')}" />
<c:set var="kakao_Name" value="${ pageContext.request.getSession(false).getAttribute('kakao_Name')==null?'':pageContext.request.getSession(false).getAttribute('kakao_Name')}" />

<html>
<head>
	<title>main</title>

	<link rel="stylesheet" href="<c:url value='/css/header.css' />">
	<link rel="stylesheet" href="<c:url value='/css/common.css' />">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div id="wrap">
	<jsp:include page="include/header.jsp" flush="false" />

	<main style="width: 100%; height: 1000px; border: 1px solid; box-sizing: border-box">
		<%--추후 추가 할거 넣기--%>
	</main>
	<jsp:include page="include/footer.jsp" flush="false" />
</div>

</body>
<script>

</script>
</html>