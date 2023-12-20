<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLDecoder" %>

<c:set var="logInOutLink" value="${ pageContext.request.getSession(false).getAttribute('id')==null?'/member/login':'/member/logout'}" />
<c:set var="logInOutTxt" value="${empty sessionScope.loginEmail ? '로그인' : '로그아웃'}" />
<c:set var="userId" value="${empty sessionScope.loginEmail ? '' : sessionScope.loginEmail}" />
<c:set var="memberName" value="${ pageContext.request.getSession(false).getAttribute('memberName')==null?'':pageContext.request.getSession(false).getAttribute('memberName')}" />
<html>
<head>
    <title>update</title>
    <link rel="stylesheet" href="<c:url value='/css/join.css' />">
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

<main>
    <div class="wrapper">
        <form action="/member/update" method="post" name="updateForm" >

            <div class="title"><h1 style="font-size: 21px;">회원 정보 수정</h1></div>
            <div class="name">
                <label for="memberEmail">이메일(변경불가)</label>
                <input type="text" class="Check" id="memberEmail" name="memberEmail" value="${member.memberEmail}"readonly>
                <p id="check-result"></p>
            </div>
            <div class="password">
                <label for="memberPassword">사용자 비밀번호</label>
                <input type="password" class="Check" name="memberPassword" id="memberPassword">
                <div id="pwError" class="error"></div>
            </div>
            <div class="membername">
                <label for="nameCheck">닉네임</label>
                <input type="text" class="Check" id="nameCheck" name="memberName" value="${member.memberName}">
                <div id="nameCheckError" class="error"></div>
            </div>
            <div class="memberage">
                <label for="ageCheck">나이 변경</label>
                <input type="text" class="Check" name="memberAge" id="ageCheck" placeholder="ex 25" maxlength="8" value="${member.memberAge}">
                <div id="ageCheckError" class="error"></div>
            </div>
            <div class="memberphon">
                <label for="phonCheck">전화번호 변경</label>
                <input type="text" id="phonCheck" class="Check" name="memberMobile" placeholder="ex 010-1234-5678" value="${member.memberMobile}">
                <div id="phonCheckError" class="error"></div>
            </div>

            <div class="line">
                <hr>
            </div>
            <div class="signUp">
                <input style="width: 100%;height: 50px; cursor: pointer;" type="button" value="수정" onclick="update()">
                <input style="width: 100%;height: 50px; cursor: pointer; background-color: red;" type="button" value="회원 탈퇴" onclick="deleteMember(${member.id})">
            </div>
        </form>
    </div>
</div>
    <div class="right_box">
        <ul>
            <li></li>
            <li></li>
            <li></li>
        </ul>
    </div>
</main>
</body>
<script>
    const validatePhoneNumber = (phoneNumber) => {
        // 전화번호 형식에 맞는지 확인하는 정규식
        const phoneRegex = /^\d{3}-\d{3,4}-\d{4}$/;
        return phoneRegex.test(phoneNumber);
    };

    const validateForm = () => {
        const name = document.getElementById('nameCheck').value.trim();
        const age = document.getElementById('ageCheck').value.trim();
        const phoneNumber = document.getElementById('phonCheck').value.trim();

        const errorName = document.getElementById('nameCheckError');
        const errorAge = document.getElementById('ageCheckError');
        const errorPhoneNumber = document.getElementById('phonCheckError');

        // 닉네임, 나이, 전화번호가 비어 있는지 확인
        if (name === '') {
            errorName.innerHTML = '닉네임을 입력해주세요.';
            errorName.style.color = 'red';
            return false;
        } else {
            errorName.innerHTML = ''; // 에러 메시지 초기화
        }

        if (age === '') {
            errorAge.innerHTML = '나이를 입력해주세요.';
            errorAge.style.color = 'red';
            return false;
        } else {
            errorAge.innerHTML = ''; // 에러 메시지 초기화
        }

        if (phoneNumber === '') {
            errorPhoneNumber.innerHTML = '전화번호를 입력해주세요.';
            errorPhoneNumber.style.color = 'red';
            return false;
        } else if (!validatePhoneNumber(phoneNumber)) {
            errorPhoneNumber.innerHTML = '올바른 전화번호 형식이 아닙니다. ex) 010-1234-5678';
            errorPhoneNumber.style.color = 'red';
            return false;
        } else {
            errorPhoneNumber.innerHTML = ''; // 에러 메시지 초기화
        }

        // 모든 필드가 유효하면 true 반환
        return true;
    };

    const update = () => {
        const passwordDB = '${member.memberPassword}';
        const password = document.getElementById("memberPassword").value;

        // 폼 유효성 검사 수행
        if (!validateForm()) {
            // 폼이 유효하지 않으면 함수 종료
            return;
        }

        if (passwordDB === password) {
            alert("회원 정보가 수정 되었습니다.")
            document.updateForm.submit();
        } else {
            alert("비밀번호가 일치하지 않습니다!");
        }
    };
    const deleteMember = (memberId) => {
        if (confirm("정말로 회원을 탈퇴하시겠습니까?")) {
            // 확인을 누르면 탈퇴를 위한 요청을 보냄
            const email = '${member.memberEmail}';
            const passwordDB = '${member.memberPassword}';
            const password = document.getElementById("memberPassword").value;
            // 이메일을 서버로 보내 탈퇴 작업 수행
            $.ajax({
                type: "POST",
                url: '/member/delete?id=' + memberId,
                data: { email: email },
                success: function (response) {
                    if (passwordDB == password) {
                        // 탈퇴 성공 시의 동작
                        alert("회원 탈퇴가 완료되었습니다.");
                        window.location.href = "/"; // 홈페이지로
                    }
                    else {
                        alert("비밀번호가 일치하지 않습니다!");
                    }
                },
                error: function (error) {
                    // 탈퇴 실패 시의 동작
                    alert("회원 탈퇴를 실패했습니다. 다시 시도해주세요.");
                    console.error(error);
                }
            });
        }
    }



</script>
</html>