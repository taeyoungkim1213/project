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
    <link rel="stylesheet" href="<c:url value='/css/board_save.css' />">
    <link rel="stylesheet" href="<c:url value='/css/header.css' />">
    <link rel="stylesheet" href="<c:url value='/css/common.css' />">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div id="wrap">
    <jsp:include page="include/header.jsp" flush="false" />

    <main style="width: 100%;/* height: 1000px; */border: 1px solid;box-sizing: border-box;padding: 25px;box-sizing: border-box;">
        <div class="save_review_content">
            <form action="/board/save" id="frm" method="post" enctype="multipart/form-data">
                <div class="info">
                    <input type="hidden" name="boardWriter" readonly value="${memberName}">
                </div>
                <div class="flex_con">
                    <!-- Content Section 1 -->
                    <div class="con1">
                        <label for="file-upload1" class="file-upload-btn1">
                            <p>상품 이미지 업로드</p>
                        </label>
                        <div id="image_container">
                            <p id="image_container_txt">판매 상품 이미지를 선택해주세요</p>
                        </div>
                        <input type="file" name="imageFile" id="file-upload1" class="input-file" multiple
                               onchange="checkFile(event);">
                        <div class="input-group">

                            <div class="status_selection">
                                <label for="saleStatus">판매 상태:</label>
                                <select name="saleStatus" id="saleStatus">
                                    <option value="판매중">판매중</option>
                                </select>
                            </div>
                            <div class="save_review_content_write_title">
                                <label for="boardPrice">상품 가격</label>
                                <input type="text" name="boardPrice" id="boardPrice" class="board_price"
                                       placeholder="ex) 20000">
                            </div>
                        </div>
                    </div>
                    <!-- Content Section 2 -->
                    <div class="con2">
                        <div class="save_review_content_write_title">
                            <label for="boardTitle">제목</label>
                            <input type="text" name="boardTitle" id="boardTitle" class="board_title"
                                   placeholder="제목">
                        </div>
                        <hr>
                        <div class="board_content">
                            <label for="boardContents">내용</label>
                            <textarea name="boardContents" id="boardContents" class="boardContents"
                                      placeholder="게시글 내용을 작성해 주세요" cols="30" rows="10"></textarea>
                        </div>
                    </div>
                </div>
                <div class="submit_btn_or_cancel_btn">
                    <input type="submit" class="save_review_content_btn" value="작성">
                    <input type="submit" class="cancel_review_content_btn" value="취소">
                </div>
            </form>
        </div>
    </main>
    <jsp:include page="include/footer.jsp" flush="false" />
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
// form 요소 제출을 위한 함수
function submitForm() {
    let title = document.querySelector('.board_title').value;
    let price = document.querySelector('input[name="boardPrice"]').value;
    let contents = document.querySelector('.boardContents').value;

    if (title.trim() === '' || price.trim() === '' || contents.trim() === '') {
        alert("제목, 상품 가격, 내용을 모두 작성해주세요.");
        return false; // form 제출 방지
    }

    if (isNaN(price)) {
        alert("가격에는 숫자만 입력해주세요.");
        return false; // form 제출 방지
    }

    return true; // form 제출
}

// form submit 이벤트 리스너
document.getElementById('frm').addEventListener('submit', function(event) {
    if (!submitForm()) {
        event.preventDefault(); // form 제출 방지
    }
});

// 가격 입력 필드에 숫자만 입력 받도록 제한
document.querySelector('input[name="boardPrice"]').addEventListener('input', function() {
    this.value = this.value.replace(/[^0-9]/g, ''); // 숫자 이외의 값은 삭제
});

</script>
</body>
</html>
