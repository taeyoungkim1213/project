<%--
  Created by IntelliJ IDEA.
  User: jegalminhyeog
  Date: 12/13/23
  Time: 10:41 AM
  To change this template use File | Settings | File Templates.
--%>
<%--<%@ page contentType="text/html;charset=utf-8"%>--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--<%@ page import="java.net.URLDecoder" %>--%>

<c:set var="logInOutLink" value="${ pageContext.request.getSession(false).getAttribute('id')==null?'/member/login':'/member/logout'}" />
<c:set var="logInOutTxt" value="${empty sessionScope.loginEmail ? '로그인' : '로그아웃'}" />
<c:set var="userId" value="${empty sessionScope.loginEmail ? '' : sessionScope.loginEmail}" />
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="<c:url value='/css/footer.css' />">
</head>
<body>
    <div id="wrap">
        <footer>
            <hr>
            <p>footer영역 추후 수정 plz</p>
        </footer>
    </div>
</body>
</html>
