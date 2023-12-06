<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLDecoder" %>

<%@ page session="false" %> <%-- 이 페이지에서는 세션을 새로 생성 안하겠다 라는 뜻 --%>
<c:set var="logInOutLink" value="${ pageContext.request.getSession(false).getAttribute('id')==null?'/member/login':'/member/logout'}"/>
<c:set var="logInOutTxt" value="${empty sessionScope.loginEmail ? '로그인' : '로그아웃'}" />
<c:set var="userId" value="${empty sessionScope.loginEmail ? '' : sessionScope.loginEmail}" />

<html>
<head>
    <title>로그인</title>
    <link rel="stylesheet" href="<c:url value='/css/login.css' />">
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

    <main>
        <div class="loginbox">
            <h2>로그인</h2>
            <!-- 에러 메시지 출력 -->
            <p style="color: red;text-align: center;">${errorMessage}</p>
            <form action="/member/login" method="post">
                <fieldset>
                    <legend>로그인 구역</legend>
                    <label for="loginid">아이디(e-mail)</label>
                    <input type="text" id="loginid" name="memberEmail" placeholder="아이디(e-mail)을 입력해 주세요">
                    <label for="loginpw">비밀번호</label>
                    <input type="password" id="loginpw" name="memberPassword" placeholder="비밀번호를 입력해 주세요">
                    <ul>
                        <li><a href="<c:url value='/member/findById'/> ">아이디 찾기ㅣ</a></li>
                        <li><a href="<c:url value='/member/findPw'/> ">비밀번호 찾기</a></li>
                        <li><a href="<c:url value="/member/join"/>">회원가입</a></li>
                    </ul>

                    <button type="submit">로그인</button>
                </fieldset>
            </form>
        </div>
    </main>

    <footer></footer>

</div>
<script>
    const loginFormCheck = () => {
        const email = document.getElementById("loginid").value;
        const password = document.getElementById("loginpw").value;

        // 이메일 형식 확인
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            alert("유효한 이메일을 입력하세요.");
            return false;
        }

        // 비밀번호 길이 확인
        if (password.length < 6) {
            alert("비밀번호는 6자 이상이어야 합니다.");
            return false;
        }

        // 유효성 검사 통과 시, 서버에 로그인 요청 전송
        $.ajax({
            type: "POST",
            url: "/member/login",
            data: {
                "memberEmail": email,
                "memberPassword": password
            },
            success: function(response) {
                if (response === "success") {
                    alert("로그인되었습니다.");
                    // 로그인이 성공하면 어떤 작업을 수행할지 여기에 추가
                } else {
                    alert("아이디 또는 비밀번호가 올바르지 않습니다.");
                }
            },
            error: function(err) {
                console.error("에러 발생: ", err);
            }
        });

        return false; // 폼이 실제로 서버로 전송되는 것을 막음
    };
</script>
</body>

</html>