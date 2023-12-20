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
    <title>상품 상세 내용</title>

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


    <%--input으로 할 필요없음 -작성자- --%>
    <div class="info">
        <div class="content_info">
            <input type="hidden" name="boardWriter" placeholder="작성자" readonly value="${loginEmail}">
            <p class="wirter_u"><b>작성자 :</b> ${memberName}</p>
            <!-- 판매 상태 -->
            <span>상태: ${board.saleStatus}</span>
<%--            이부분에 찜 하기 버튼 추가--%>
            <button id="likeButton" onclick="toggleLike()" style="background-color: ${isLiked ? 'yellow' : 'white'}">
                ${isLiked ? '찜 취소' : '찜 하기'}
            </button>
            <p><a href="/echo/?id=${board.boardId}">구매자한테 채팅하기</a></p>
        </div>
        <div class="content_lcoation">
            <span><b>조회수</b> : ${board.boardHits}</span>
            <span><b> | 게시글 번호</b> : ${board.boardId}</span>
            <span><b> | 작성일</b> : ${board.boardCreate}</span>
        </div>
    </div>
    <%--썸네일 및 메인 이미지--%>
    <div class="flex_con">
        <div class="con1">
            <div id="image_container">
                <img src="<c:url value='/upload/${board.boardFileName}'/>" alt="이미지 설명" />
                <p id="image_container_txt">프로필 이미지</p>
            </div>
        </div>
        <div class="con2">
            <div class="save_review_content_write_title">
                <span>제목</span>
                <h1 style="font-size: 25px"> ${board.boardTitle}</h1>
                <%--                    <input type="text" name="boardTitle" class="board_title" placeholder="게시글 제목">--%>
            </div>
            <hr>
            <div class="board_content">
                <span>내용</span>
                <p>${board.boardContents}</p>
                <%--                    <textarea name="boardContents" class="boardContents" cols="30" rows="10" placeholder="후기 내용을 작성해 주세요"></textarea>--%>
            </div>
        </div>
    </div>



<div class="content_title_button">
    <button onclick="listFn()">목록</button>
    <button class="btn_2" onclick="updateFn()" <c:if test="${board.boardWriter ne memberName}">style="display: none"</c:if> >수정</button>
    <button onclick="deleteFn()" <c:if test="${board.boardWriter ne memberName}">style="display: none"</c:if> >삭제</button>
</div>

<script>
    const listFn = () => {
        const page = '${page}';
        location.href = "/board/?page=" + page;
    }
    const updateFn = () => {
        const id = '${board.boardId}';
        location.href = "/board/update?id=" + id;
    }
    const deleteFn = () => {
        const id = '${board.boardId}';
        alert("해당 게시글을 삭제하였습니다.")
        location.href = "/board/delete?id=" + id;
    }

    let liked = false;
    function toggleLike() {
        if (liked) {
            // 이미 찜한 상태이면 찜 취소
            unlikeFunction();
            liked = false;
        } else {
            // 찜하지 않은 상태이면 찜하기
            likeFunction();
            liked = true;
        }
    }

    $(document).ready(function() {
        // 페이지가 로드될 때, 찜한 상태인지 확인
        checkLikedStatus();
    });

    function checkLikedStatus() {
        $.ajax({
            type: "GET",
            url: "/checkLikedStatus",
            data: {
                boardId: '${board.boardId}'
            },
            success: function (response) {
                if (response) {
                    // 찜한 상태라면 버튼 스타일 및 텍스트 변경
                    document.getElementById('likeButton').style.backgroundColor = 'yellow';
                    document.getElementById('likeButton').innerText = '찜 취소';
                    liked = true;
                } else {
                    document.getElementById('likeButton').style.backgroundColor = 'white';
                    document.getElementById('likeButton').innerText = '찜 하기';
                    liked = false;
                }
            },
            error: function (error) {
                console.log(error);
            }
        });
    }

    function likeFunction() {
        $.ajax({
            type: "POST",
            url: "/like",
            data: {
                boardId: '${board.boardId}'
            },
            success: function (response) {
                console.log(response);
                // 성공적으로 찜하기를 처리한 경우
                // 버튼 디자인 및 메시지 변경 등의 UI 업데이트를 수행할 수 있습니다.
                // 예: 찜하기 버튼의 색 변경
                document.getElementById('likeButton').style.backgroundColor = 'yellow';
                document.getElementById('likeButton').innerText = '찜 취소';
            },
            error: function (error) {
                console.log(error);
            }
        });
    }

    function unlikeFunction() {
        $.ajax({
            type: "POST",
            url: "/unlike",
            data: {
                boardId: '${board.boardId}'
            },
            success: function (response) {
                console.log(response);
                // 성공적으로 찜 취소를 처리한 경우
                // 버튼 디자인 및 메시지 변경 등의 UI 업데이트를 수행할 수 있습니다.
                // 예: 찜하기 버튼의 색 변경
                document.getElementById('likeButton').style.backgroundColor = 'white';
                document.getElementById('likeButton').innerText = '찜 하기';
            },
            error: function (error) {
                console.log(error);
            }
        });
    }

</script>
</body>
</html>
