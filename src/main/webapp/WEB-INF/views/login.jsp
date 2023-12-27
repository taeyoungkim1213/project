<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLDecoder" %>

<%@ page session="false" %> <%-- 이 페이지에서는 세션을 새로 생성 안하겠다 라는 뜻 --%>
<c:set var="logInOutLink" value="${ pageContext.request.getSession(false).getAttribute('loginEmail')==null?'/member/login':'/member/logout'}"/>
<c:set var="logInOutTxt" value="${empty sessionScope.loginEmail ? '로그인' : '로그아웃'}" />
<c:set var="loginEmail" value="${empty sessionScope.loginEmail ? '' : sessionScope.loginEmail}" />

<html>
<head>
    <title>로그인</title>
    <link rel="stylesheet" href="<c:url value='/css/login.css' />">
    <link rel="stylesheet" href="<c:url value='/css/header.css' />">
    <link rel="stylesheet" href="<c:url value='/css/common.css' />">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
</head>
<body>
<div id="wrap">
    <jsp:include page="include/header.jsp" flush="false" />
    <main>
        <div class="loginbox">
            <p class="loginbox_txt">로그인</p>
            <!-- 에러 메시지 출력 -->
            <p style="color: red;text-align: center;">${errorMessage}</p>
            <form action="/member/login" method="post">
                <fieldset>
                    <legend>로그인 구역</legend>
                    <label for="loginid">아이디</label>
                    <input type="text" id="loginid" name="memberEmail" placeholder="아이디(e-mail)을 입력해 주세요">
                    <label for="loginpw">비밀번호</label>
                    <input type="password" id="loginpw" name="memberPassword" placeholder="비밀번호를 입력해 주세요">
                    <div class="rememberMe" ${empty cookie.id.value?"":"checked"}>
                        <input style="width: 15px;height: 15px" type="checkbox" id="rememberMe" name="rememberMe">
                        <label for="rememberMe">아이디 기억하기</label>
                        <ul>
                            <li><a href="<c:url value='/member/findById'/> ">아이디 찾기</a></li>
                            <li><a href="<c:url value='/member/findPw'/> ">ㅣ비밀번호 찾기ㅣ</a></li>
                            <li><a href="<c:url value="/member/join"/>">회원가입</a></li>
                        </ul>
                    </div>
                    <input czlass="prevpage" type="hidden" name="prevPage" value="${param.prevPage}" >
                    <button type="submit">로그인</button>
                    <%--카카오 테스트--%>
                    <a id="kakao-login-btn"></a>
                    <a href="http://developers.kakao.com/logout">Logout</a>
                    <script type='text/javascript'>
                        //<![CDATA[
                        // 사용할 앱의 JavaScript 키를 설정해 주세요.
                        Kakao.init('b759efb644a1993fc9136bf0930eb712');
                        // 카카오 로그인 버튼을 생성합니다.
                        Kakao.Auth.createLoginButton({
                            container: '#kakao-login-btn',
                            success: function (authObj) {
                                alert(JSON.stringify(authObj));
                            },
                            fail: function (err) {
                                alert(JSON.stringify(err));
                            }
                        });
                        //]]>
                    </script>
                </fieldset>
            </form>
        </div>
    </main>

    <jsp:include page="include/footer.jsp" flush="false" />

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
    Kakao.Auth.createLoginButton({
        container: '#kakao-login-btn',
        success: function (authObj) {
            // 카카오 로그인 성공 시 서버로 해당 토큰을 보내 로컬 로그인 처리
            $.ajax({
                type: "POST",
                url: "/member/kakaoLogin", // 카카오 로그인 요청을 처리할 컨트롤러 경로
                data: { token: authObj.access_token }, // 카카오 토큰 전달
                success: function(response) {
                    if (response === "success") {
                        alert("로그인되었습니다.");
                        // 로그인이 성공하면 필요한 작업 수행
                        // 예: 홈페이지로 리다이렉트
                        window.location.href = "/"; // 홈페이지로 이동
                    } else {
                        alert("로그인 실패");
                    }
                },
                error: function(err) {
                    console.error("에러 발생: ", err);
                }
            });
        },
        fail: function (err) {
            alert(JSON.stringify(err));
        },
    });

</script>
</body>

</html>