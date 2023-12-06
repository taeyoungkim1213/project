<%--
  Created by IntelliJ IDEA.
  User: user1
  Date: 2023-12-06
  Time: 오전 11:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
        <div id="emailResult" style="
    padding: 20px;
    box-sizing: border-box;
    border: 1px solid #bebebe;
    margin-top: 30px;
    border-radius: 10px;
">
            <c:choose>
                <c:when test="${not empty foundPw}">
                    <p class="find_email">${foundPw}</p>
                </c:when>
                <c:otherwise>
                    <p>${notFoundMessage}</p>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="login_find_result_txt">
            <a href="/member/login"><div class="login_join result_btn">
                <span>로그인하기</span>
            </div></a>
            <a class="result_btn" href="/member/findPw"><p>비밀번호 찾기</p></a>
        </div>



</body>
</html>
