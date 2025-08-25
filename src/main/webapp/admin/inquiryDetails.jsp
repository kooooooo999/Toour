<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
    /* 문의사항 답변 섹션 스타일 */
    .inquiry-details-container {
        background: #fff;
        border: 1px solid #e1e4e8;
        border-radius: 6px;
        padding: 20px;
        margin-bottom: 20px;
    }

    .inquiry-details-container ul {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .inquiry-details-container li {
        padding: 10px 0;
        border-bottom: 1px solid #f4f6f8;
        font-size: 15px;
        color: #4a4a4a;
    }

    .inquiry-details-container li:last-child {
        border-bottom: none;
    }

    .inquiry-details-container li strong {
        color: #2c3e50;
        margin-right: 10px;
        font-weight: 600;
    }

    /* 답변 입력 폼 스타일 */
    .answer-container {
        background: #fff;
        border: 1px solid #e1e4e8;
        border-radius: 6px;
        padding: 20px;
    }

    .answer-container h2 {
        margin-top: 0;
        font-size: 20px;
        color: #2c3e50;
        padding-bottom: 10px;
        border-bottom: 2px solid #3498db;
    }

    .answer-textarea {
        width: 100%;
        min-height: 200px;
        padding: 15px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
        resize: vertical;
        transition: border-color 0.3s ease;
    }

    .answer-textarea:focus {
        outline: none;
        border-color: #3498db;
    }

    .submit-btn {
        display: block;
        width: 150px;
        margin-top: 20px;
        padding: 12px;
        background-color: #3498db;
        color: white;
        border: none;
        border-radius: 4px;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .submit-btn:hover {
        background-color: #2980b9;
    }

    #confirmDialog {
        display: none;
    }

    /* jQuery UI 다이얼로그 전체 컨테이너 */
    .ui-dialog {
        padding: 0;
        border: none;
        border-radius: 8px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
        font-family: 'Noto Sans KR', sans-serif;
    }

    /* 다이얼로그 제목 영역 */
    .ui-dialog-titlebar {
        background-color: #3498db;
        color: white;
        padding: 15px 20px;
        border-bottom: none;
        border-radius: 8px 8px 0 0;
        font-size: 18px;
        font-weight: 600;
    }

    /* 다이얼로그 제목 텍스트 */
    .ui-dialog-title {
        color: white;
    }

    /* 다이얼로그 닫기 버튼 */
    .ui-dialog-titlebar-close {
        background: transparent;
        border: none;
        color: white;
        font-size: 24px;
        top: 50%;
        right: 15px;
        transform: translateY(-50%);
        cursor: pointer;
        transition: transform 0.2s ease;
    }

    .ui-dialog-titlebar-close:hover {
        transform: translateY(-50%) scale(1.2);
    }

    /* 다이얼로그 내용 영역 */
    .ui-dialog-content {
        padding: 30px;
        background-color: #fff;
        color: #4a4a4a;
    }

    /* 버튼 그룹 컨테이너 */
    .button-group {
        text-align: right;
        padding-top: 20px;
        border-top: 1px solid #e1e4e8;
        margin-top: 20px;
    }

    /* 버튼 스타일 */
    .button-group button {
        padding: 10px 20px;
        font-size: 14px;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease, border-color 0.3s ease;
    }

    /* 등록 버튼 (파란색) */
    .button-group button:first-child {
        background-color: #3498db;
        color: white;
        border: none;
        margin-right: 10px;
    }

    .button-group button:first-child:hover {
        background-color: #2980b9;
    }

    /* 취소 버튼 (회색 테두리) */
    .button-group button:last-child {
        background-color: #fff;
        color: #2c3e50;
        border: 1px solid #ccc;
    }

    .button-group button:last-child:hover {
        background-color: #f4f6f8;
    }

    /* 뒤로가기 버튼 스타일 */
    .back-button {
        position: fixed; /* 👈 스크롤에 상관없이 화면에 고정 */
        bottom: 20px; /* 👈 화면 아래쪽에서 20px 떨어진 위치 */
        left: 20px; /* 👈 화면 왼쪽에서 20px 떨어진 위치 */
        z-index: 1000; /* 다른 요소보다 위에 표시 */

        /* 버튼 디자인 */
        background-color: #337ab7;
        color: white;
        border-radius: 50%; /* 원형 모양 */
        width: 50px;
        height: 50px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 24px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        transition: background-color 0.3s;
        text-decoration: none; /* 밑줄 제거 */
    }

    .back-button:hover {
        background-color: #286090;
    }

</style>

<h1>사용자 문의사항</h1>
<div class="inquiry-details-container">
    <c:set var="Type" value="${requestScope.searchType}"/>
    <c:set var="Status" value="${requestScope.searchStatus}"/>

    <c:set var="Ivo" value="${requestScope.reqInquiry}"/>
    <c:set var="p" value="${requestScope.page}" scope="page"/>
    <c:set var="Ar" value="${requestScope.IvoArr}"/>

    <a href="AdminController?type=adminInquiry&cPage=${p.nowPage}&searchType=${Type}&searchStatus=${Status}"
       class="back-button">
        <i class="fas fa-arrow-left"></i>
    </a>

    <ul>
        <li><strong>번호:</strong> ${Ivo.inquiry_idx}</li>
        <li><strong>카테고리:</strong> ${Ivo.category}</li>
        <li><strong>제목:</strong> ${Ivo.title}</li>
        <li><strong>작성자:</strong> ${Ivo.member_nickname}</li>
        <li><strong>상태:</strong>
            <span class="status">${Ivo.status}</span>
        </li>
        <li><strong>작성일:</strong> ${Ivo.created_at}</li>
        <li class="inquiry-content"><strong>내용</strong>
            <p>${Ivo.content}</p>
        </li>

    </ul>
</div>

<div class="answer-container">
    <h2>관리자 답변</h2>
    <c:if test="${Ivo.status != '삭제'}">
        <form id="answer" name="answer" method="post"
              action="AdminController?type=adminInquiry&pageType=inquiryDetails&answer=1">
            <input type="hidden" name="inquiry_idx" value="${Ivo.inquiry_idx}">
            <input type="hidden" name="status" value="${Ivo.status}">
            <c:if test="${empty Ivo.answer_content}">
        <textarea id="answer_content" name="answer_content" class="answer-textarea" placeholder="답변을 입력하세요."
                  required></textarea>

                <button type="button" class="submit-btn" onclick="sendAnswer()">답변 등록</button>
            </c:if>
            <c:if test="${not empty Ivo.answer_content}">
                <p><c:out value="${Ivo.answer_content}" escapeXml="false"/></p>
            </c:if>
        </form>
    </c:if>
    <c:if test="${Ivo.status == '삭제'}">
        <div>
            <p>삭제된 문의글입니다.</p>
        </div>
    </c:if>


    <div id="display_answer_content" style="display: none;">
        <p></p>
    </div>

    <div id="confirmDialog">
        <div class="dialog-body">
            <p>문의글 답변을 등록하시겠습니까?</p>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<script src="../js/summernote-lite.js"></script>
<script src="../js/lang/summernote-ko-KR.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.css" rel="stylesheet">
<script>


    $(function () {
        let option = {
            modal: true,
            autoOpen: false,
            resizable: false,
            width: 400,
            height: 'auto',
        };
        $("#confirmDialog").dialog(option)
    });

    function sendAnswer() {
        let answerContent = document.getElementById('answer_content').value;

        if (answerContent.trim() === '') {
            // 내용이 비어 있을 때 경고 다이얼로그 설정
            $("#confirmDialog").dialog("option", "title", "⚠️ 경고");
            //find:하위요소 선택
            $("#confirmDialog").find(".dialog-body").html("<p>답변 내용을 입력해주세요.</p>");
            $("#confirmDialog").dialog("option", "buttons", [{
                text: "확인",
                click: function () {
                    $(this).dialog("close");
                }
            }]);

            $("#confirmDialog").dialog("open");

        } else {
            // 내용이 있을 때 등록 확인 다이얼로그 설정
            $("#confirmDialog").dialog("option", "title", "✅ 확인");
            $("#confirmDialog").find(".dialog-body").html("<p>문의글 답변을 등록하시겠습니까?</p>");
            $("#confirmDialog").dialog("option", "buttons", [{
                text: "등록",
                click: function () {
                    // 폼 제출 로직 (실제 DB 저장)
                    $.ajax({
                        url: "AdminController?type=adminInquiry&pageType=inquiryDetails&answer=1",
                        method: "POST",
                        data: {idx: ${Ivo.inquiry_idx}, status: '${Ivo.status}', answer_content: answerContent}, // 폼의 모든 입력 데이터를 직렬화하여 전송
                        success: function (response) {
                            $('#answer_content').hide().prop('disabled', true);
                            $('.submit-btn').hide(); // 버튼도 숨김

                            $('#display_answer_content p').text(answerContent);
                            $('#display_answer_content').show();

                            $('.status').html("답변완료");
                        }
                    });
                    $(this).dialog("close");
                }
            }, {
                text: "취소",
                click: function () {
                    $(this).dialog("close");
                }
            }]);

            $("#confirmDialog").dialog("open");
        }
    }

</script>