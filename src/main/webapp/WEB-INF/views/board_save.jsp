<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLDecoder" %>

<c:set var="logInOutLink" value="${ pageContext.request.getSession(false).getAttribute('loginEmail')==null?'/member/login':'/member/logout'}" />
<c:set var="logInOutTxt" value="${empty sessionScope.loginEmail ? '로그인' : '로그아웃'}" />
<c:set var="loginEmail" value="${empty sessionScope.loginEmail ? '' : sessionScope.loginEmail}" />
<c:set var="loginEmail" value="${ pageContext.request.getSession(false).getAttribute('loginEmail')==null?'':pageContext.request.getSession(false).getAttribute('loginEmail')}" />
<c:set var="memberName" value="${ pageContext.request.getSession(false).getAttribute('memberName')==null?'':pageContext.request.getSession(false).getAttribute('memberName')}" />
<html>
<head>
    <title>글작성</title>

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

<div class="save_review_content" id="save_review_content">
    <form action="/board/save" method="post" enctype="multipart/form-data">
        <div class="info">
            <!-- 작성자 정보 -->
            <input type="hidden" name="boardWriter" readonly value="${loginEmail}">
            <b class="writer_u">작성자 : ${memberName}</b>
        </div>
        <!-- 게시글 작성 폼 -->
        <div class="flex_con">
            <div class="con1">
                <div class="save_review_content_write_title">
                    <span>제목</span>
                    <input type="text" name="boardTitle" class="board_title" placeholder="게시글 제목">
                </div>
                <div class="status_selection">
                    <label for="saleStatus">판매 상태:</label>
                    <select name="saleStatus" id="saleStatus">
                        <option value="판매중">판매중</option>
                        <option value="거래완료">거래완료</option>
                    </select>
                </div>
                <!-- 이미지 업로드 -->
                <div id="image_container">
                    <p id="image_container_txt">판매 상품 이미지를 선택해주세요</p>
                </div>
                <label for="file-upload1" class="file-upload-btn1">
                    <p>상품 이미지 업로드</p>
                </label>
                <input type="file" name="imageFile" id="file-upload1" class="input-file" multiple onchange="checkFile(event);">
            </div>
            <div class="save_review_content_write_title">
                <span>상품 가격</span>
                <input type="text" name="boardPrice" class="board_title" placeholder="ex) 20000">
            </div>
            <div class="con2">
                <hr>
                <div class="board_content">
                    <span>내용</span>
                    <textarea name="boardContents" class="boardContents" cols="30" rows="10" placeholder="게시글 내용을 작성해 주세요"></textarea>
                </div>
            </div>
        </div>
        <div class="submit_btn_or_cancel_btn">
            <input type="submit" class="save_review_content_btn" value="작성">
            <input type="submit" class="cancel_review_content_btn" value="취소">
        </div>
    </form>
</div>
<script>
<%--    이미지미리보기--%>
    function checkFile(event) {
        var files = event.target.files;
        if (files.length > 1) {
            alert("하나의 이미지만 선택해주세요.");
            event.target.value = "";
        } else {
            var file = files[0];
            var fileType = file.type;
            if (!fileType.startsWith('image/')) {
                alert("이미지 파일만 선택할 수 있습니다.");
                event.target.value = "";
            } else {
                setThumbnail(event);
            }
        }
    }
    <!-- 이미지 미리보기 -->
    function setThumbnail(event) {
        var reader = new FileReader();
        reader.onload = function(event) {
            var img = document.createElement("img");
            img.setAttribute("src", event.target.result);
            img.setAttribute("class", "col-lg-6");
            img.setAttribute("width", 200);
            img.setAttribute("height", 150);
            var container = document.querySelector("div#image_container");
            container.innerHTML = ""; // 기존 이미지 삭제
            container.appendChild(img);

            var prv_txt = document.getElementById("image_container_txt");
            prv_txt.style.display = "none";
        };

        var file = event.target.files[0];
        if (file) {
            reader.readAsDataURL(file);
        }
    }
</script>
</body>
</html>
