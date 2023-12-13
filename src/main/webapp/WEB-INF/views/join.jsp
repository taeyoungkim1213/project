<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLDecoder" %>

<%@ page session="false" %> <%-- 이 페이지에서는 세션을 새로 생성 안하겠다 라는 뜻 --%>
<c:set var="logInOutLink" value="${ pageContext.request.getSession(false).getAttribute('loginEmail')==null?'/member/login':'/member/logout'}"/>
<c:set var="logInOutTxt" value="${empty sessionScope.loginEmail ? '로그인' : '로그아웃'}" />
<c:set var="loginEmail" value="${empty sessionScope.loginEmail ? '' : sessionScope.loginEmail}" />


<html>
<head>
    <title>회원가입</title>
    <link rel="stylesheet" href="<c:url value='/css/join.css' />">
    <link rel="stylesheet" href="<c:url value='/css/header.css' />">
    <link rel="stylesheet" href="<c:url value='/css/common.css' />">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="wrap">
    <jsp:include page="include/header.jsp" flush="false" />
    <main>
        <div class="wrapper">
            <form action="#" method="post" name="join" id="ioin" onsubmit="return joinform_check()">

                <div class="title"><h1 style="font-size: 21px;">회원가입</h1></div>
                <div class="name">
                    <label for="memberEmail">이메일</label>
                    <input class="Check" id="memberEmail" name="memberEmail" type="text" placeholder="이메일을 입력해 주세요." onblur="emailCheck()">
                    <p id="check-result"></p>
                </div>
                <div class="password">
                    <label for="pw">비밀번호</label>
                    <input class="Check" id="pw" type="password" name="memberPassword"  placeholder="비밀번호를 입력해 주세요." maxlength="20">
                    <div id="pwError" class="error"></div>
                </div>
                <div class="passwordCheck">
                    <label for="pwCheck">비밀번호 확인</label>
                    <input class="Check" id="pwCheck" type="password" placeholder="비밀번호를 다시 입력해 주세요.">
                    <div id="pwCheckError" class="error"></div>
                </div>
                <div class="membername">
                    <label for="nameCheck">닉네임</label>
                    <input type="text" id="nameCheck" class="Check" name="memberName" placeholder="닉네임(10글자 이내)" maxlength="10">
                    <div id="nameCheckError" class="error"></div>
                </div>
                <div class="memberage">
                    <label for="ageCheck">나이</label>
                    <input type="text" id="ageCheck" class="Check" name="memberAge" placeholder="ex) 25" maxlength="8">
                    <div id="ageCheckError" class="error"></div>
                </div>
                <div class="memberphon">
                    <label for="phonCheck">전화번호</label>
                    <input class="Check" id="phonCheck" type="text" name="memberMobile" placeholder="ex)010-1234-5678">
                    <div id="phonCheckError" class="error"></div>
                </div>

                <div class="signUp">
                    <button type="submit" onclick="joinform_check()">회원가입</button>
                </div>
            </form>
        </div>
    </main>
    <jsp:include page="include/footer.jsp" flush="false" />
</div>
<script>
    // 이메일 입력값을 가져오고,
    // 입력값을 서버로 전송하고 똑같은 이메일이 있는지 체크한 후
    // 사용 가능 여부를 이메일 입력창 아래에 표시
    const validateEmail = (email) => {
        //이메일 유효성검사
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    };
    const validatePhoneNumber = (phoneNumber) => {
        // 전화번호 형식에 맞는지 확인하는 정규식
        const phoneRegex = /^\d{3}-\d{3,4}-\d{4}$/;
        return phoneRegex.test(phoneNumber);
    };



    const emailCheck = () => {
        const email = document.getElementById("memberEmail").value;
        const checkResult = document.getElementById("check-result");

        if (!validateEmail(email)) {
            checkResult.style.color = "red";
            checkResult.innerHTML = "올바른 이메일 형식이 아닙니다.";
            return;
        }


        $.ajax({
            // 요청방식: post, url: "email-check", 데이터: 이메일
            type: "post",
            url: "/member/email-check",
            data: {
                "memberEmail": email
            },
            success: function(res) {
                console.log("요청성공", res);
                if (res == "ok") {
                    console.log("사용가능한 이메일");
                    checkResult.style.color = "green";
                    checkResult.innerHTML = "사용가능한 이메일입니다.";
                } else {
                    console.log("이미 사용중인 이메일");
                    checkResult.style.color = "red";
                    checkResult.innerHTML = "이미 사용중인 이메일입니다.";
                }
            },
            error: function(err) {
                console.log("에러발생", err);
            }
        });
    }

    // ID 입력문자 유효성검사 시작지점

    //   uid.addEventListener('click',function(){
    function joinform_check(){

        var pwd = document.getElementById('pw');
        var error_pwd =  document.getElementById('pwError');

        var repwd = document.getElementById('pwCheck');
        var error_repwd =  document.getElementById('pwCheckError');

        var name = document.getElementById('nameCheck');
        var error_name =  document.getElementById('nameCheckError');

        var phon = document.getElementById('phonCheck');
        var error_phon =  document.getElementById('phonCheckError');

        var age = document.getElementById('ageCheck');
        var error_age =  document.getElementById('ageCheckError');

        if (pwd.value == "") {
            // alert("비밀번호를 입력하세요.");
            error_pwd.innerHTML = '비밀번호를 입력하세요.'
            pwd.focus();
            return false;
        }

        //비밀번호 영문자+숫자+특수조합(8~25자리 입력)
        var pwdCheck = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/;

        if (!pwdCheck.test(pwd.value)) {
            error_pwd.innerHTML = '비밀번호는 영문자+숫자+특수문자 조합으로 8~25자리 사용해야 합니다.'
            pwd.focus();
            return false;
        }

        if (repwd.value !== pwd.value) {
            error_repwd.innerHTML = '비밀번호가 일치하지 않습니다.'
            repwd.focus();
            return false;
        }
        if (name.value.trim() == "") {
            error_name.innerHTML = '닉네임을 입력해주세요.'
            repwd.focus();
            return false;
        }
        if (phon.value.trim() == "") {
            error_phon.innerHTML = '전화번호를 입력해주세요.'
            repwd.focus();
            return false;
        }
        if (age.value.trim() == "") {
            error_age.innerHTML = '나이를 입력해주세요.'
            repwd.focus();
            return false;
        }
        if (!validatePhoneNumber(document.getElementById('phonCheck').value)) {
            error_phon.innerHTML = '올바른 전화번호 형식이 아닙니다. ex)010-1234-5678';
            document.getElementById('phonCheck').focus();
            return false;
        }




        // document.join_form.submit();
    }



</script>
</body>

</html>










