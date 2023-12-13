<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLDecoder" %>

<%@ page session="false" %> <%-- 이 페이지에서는 세션을 새로 생성 안하겠다 라는 뜻 --%>
<c:set var="logInOutLink" value="${ pageContext.request.getSession(false).getAttribute('id')==null?'/member/login':'/member/logout'}" />
<c:set var="logInOutTxt" value="${empty sessionScope.loginEmail ? '로그인' : '로그아웃'}" />
<c:set var="userId" value="${empty sessionScope.loginEmail ? '' : sessionScope.loginEmail}" />
<c:set var="memberName" value="${ pageContext.request.getSession(false).getAttribute('memberName')==null?'':pageContext.request.getSession(false).getAttribute('memberName')}" />
<html>
<head>
    <title>main</title>
    <link rel="stylesheet" href="<c:url value='/css/findEmail.css' />">
    <link rel="stylesheet" href="<c:url value='/css/header.css' />">
    <link rel="stylesheet" href="<c:url value='/css/common.css' />">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div id="wrap">
    <header>
        <div class="header_left">
            <a href="<c:url value='/'/> "><img src="<c:url value='/img/커뮤니티로고.png' />" alt=""></a></div>
        <div class="header_mid"><h1><a href="/">FREE COMUNITY</a></h1></div>
        <div class="header_right">
            <ul>
                <%-- 로그인이 되어 있을 때 --%>
                <c:if test="${not empty sessionScope.loginEmail}">
                    <li>${userId}님 환영합니다</li>
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

    <main>
        <div class="find_email">
            <h2>전화번호로 이메일 찾기</h2>
            <form id="findEmailForm" onsubmit="return findEmail()">
                <div class="phone_number">
                    <label class="phon_lable" for="phoneNumber">사용자의 전화번호</label>
                    <input type="text" class="phone" id="phoneNumber" name="memberMobile" placeholder="전화번호를 입력하세요">
                </div>
                <div class="submit_button">
                    <button class="sum_btn" type="submit">찾기</button>
                </div>
                <p id="ermsg" style="color: red"></p>
            </form>
            <div id="emailResult"></div>
        </div>
    </main>

</div>
<script>

        const findEmail = () => {
            const phoneNumber = document.getElementById("phoneNumber").value;
            let erMsg = document.getElementById("ermsg")
            //공백제거
            if (phoneNumber.trim() === "") {
                erMsg.innerText = "이메일을 입력하세요.";
                return;
            }else {
                erMsg.innerText="";
            }

            $.ajax({
                type: "post",
                url: "/member/findById",
                data: {
                    "memberMobile": phoneNumber
                },
                success: function(res) {
                    document.getElementById("emailResult").innerHTML = res;
                },
                error: function(err) {
                    console.error("에러 발생: ", err);
                }
            });
            return false;
        };

        $('#findEmailForm').submit(function(event) {
            event.preventDefault(); // 기본 form submit 동작 방지
            findEmail(); // findEmail 함수 호출
        });



</script>
</body>

</html>