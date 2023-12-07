document.addEventListener('DOMContentLoaded', function() {
    // URL에서 'msg' 파라미터 값 가져오기
    var urlParams = new URLSearchParams(window.location.search);
    var msgParam = urlParams.get('msg');

    // 'msg' 파라미터 값이 있다면 alert 창 띄우기
    if (msgParam !== null) {
        alert(decodeURIComponent(msgParam));
        urlParams.delete('msg');

        // 'msg' 파라미터를 삭제하여 새로고침시에 더 이상 띄우지 않도록 함
        var newUrl = window.location.pathname + '?' + urlParams.toString();
        window.history.replaceState({}, document.title, newUrl);
    }
});