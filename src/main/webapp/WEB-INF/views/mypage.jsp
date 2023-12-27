<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLDecoder" %>

<c:set var="logInOutLink" value="${ pageContext.request.getSession(false).getAttribute('id')==null?'/member/login':'/member/logout'}" />
<c:set var="logInOutTxt" value="${empty sessionScope.loginEmail ? '로그인' : '로그아웃'}" />
<c:set var="userId" value="${empty sessionScope.loginEmail ? '' : sessionScope.loginEmail}" />
<c:set var="memberName" value="${ pageContext.request.getSession(false).getAttribute('memberName')==null?'':pageContext.request.getSession(false).getAttribute('memberName')}" />
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
	<jsp:include page="include/header.jsp" flush="false" />
</div>

</body>
<script>
	const update = () => {
		location.href = "/member/update";
	}
</script>
</html>