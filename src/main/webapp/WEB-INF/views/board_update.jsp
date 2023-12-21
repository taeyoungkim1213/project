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
    <title>게시글 수정</title>

    <link rel="stylesheet" href="<c:url value='/css/header.css' />">
    <link rel="stylesheet" href="<c:url value='/css/common.css' />">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div id="wrap">
    <jsp:include page="include/header.jsp" flush="false" />

    <main style="width: 100%; height: 1000px; border: 1px solid; box-sizing: border-box">

        <form action="/board/update" id="frm" method="post" enctype="multipart/form-data">
        <%--추후 추가 할거 넣기--%>
        게시글 번호: ${boardDTO.boardId}
            <input type="hidden" name="boardId" value="${boardDTO.boardId}">
            <input type="hidden" name="boardWriter" value="${boardDTO.boardWriter}">

           <p>작성자: ${boardDTO.boardWriter}</p>
           제목:<input type="text" id="boardTitle" name="boardTitle" value="${boardDTO.boardTitle}">
            내용:<input type="text" id="boardContents" name="boardContents" value="${boardDTO.boardContents}">
            상품 가격(숫자만):
            <input type="text" id="boardPrice" name="boardPrice" value="${boardDTO.boardPrice}">
            판매상태:
            <select name="saleStatus" id="saleStatus">
                <option value="판매중">판매중</option>
                <option value="거래중">거래중</option>
                <option value="거래완료">거래완료</option>
            </select>

            <div id="image_container">
                <img src="/upload/${boardDTO.boardFileName}" style="width: 300px" alt="이미지설명">
                <p id="image_container_txt">판매 상품 이미지를 수정해주세요</p>
            </div>

            <label for="file-upload1" class="file-upload-btn1">
                <p>상품 이미지 업로드</p>
            </label>
            <input type="file" name="imageFile" id="file-upload1" class="input-file" multiple onchange="checkFile(event);">
            <input type="hidden" name="imageFileExists" value="${not empty boardDTO.boardFileName}">

            <input type="button" value="수정" onclick="updateReqFn()">

            <button onclick="deleteFn()" <c:if test="${board.boardWriter ne loginEmail}">style="display: none"</c:if> >삭제</button>

        </form>
    </main>
    <jsp:include page="include/footer.jsp" flush="false" />

    <script>
        function updateReqFn(){
            // 인풋값 비어있으면 유효성 검사 할까 말까..
            let title = document.getElementById('boardTitle').value
            let contents = document.getElementById('boardContents').value
            let price = document.getElementById('boardPrice').value
            let salestatus = document.getElementById('saleStatus').value
            let frm = document.getElementById('frm')
            if (title ==''){
                alert("제목을 입력해주세요.")
                return;
            }
            if (contents ==''){
                alert("내용을 입력해주세요")
                return;
            }
            if (price ==''){
                alert("가격을 입력해주세요")
                return;
            }
            if (salestatus === "거래완료"){
                if (confirm("거래완료시 게시글이 삭제됩니다. 진행하겠습니까?")){
                    // 여기에 게시글 삭제 로직 추가
                    deleteFn(); // 게시글 삭제 함수 호출
                    frm.submit();
                    return;
                }
                return;
            }

            alert("게시글이 수정 되었습니다.")
            frm.submit();
        }

        const deleteFn = () => {
            const id = '${boardDTO.boardId}';
            alert("해당 게시글을 삭제하였습니다.")
            location.href = "/board/delete?id=" + id;
        }



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
</div>
</body>
</html>
