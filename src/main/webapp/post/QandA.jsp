<%--
  Created by IntelliJ IDEA.
  User: kke33
  Date: 25. 8. 14.
  Time: 오후 4:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<html>
<head>
    <title>1:1 문의하기</title>
    <link rel="stylesheet" href="<c:url value="/css/header.css" />">
    <link rel="stylesheet" href="<c:url value="/css/footer.css" />">
    <style>

        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
        }
        .container {
            width: 600px;
            margin: 50px auto;
            padding: 30px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 8px;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin-top: 15px;
            font-weight: bold;
            color: #555;
        }
        input[type="text"], input[type="email"], select, textarea {
            margin-top: 5px;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type="text"]:focus, input[type="email"]:focus, select:focus, textarea:focus {
            outline: none;
            border-color: #4CAF50;
            box-shadow: 0 0 5px rgba(76, 175, 80, 0.3);
        }
        textarea {
            resize: vertical;
            height: 150px;
            font-family: inherit;
        }
        input[type="file"] {
            margin-top: 5px;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: #f9f9f9;
        }
        .btn-group {
            margin-top: 25px;
            text-align: center;
        }
        .btn-group input {
            padding: 12px 25px;
            margin: 0 10px;
            font-size: 14px;
            cursor: pointer;
            border: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .btn-submit {
            background-color: #1a73e8;
            color: white;
        }
        .btn-submit:hover {
            background-color: #1a328a;
        }
        .btn-reset {
            background-color: #4CAF50;
            color: white;
        }
        .btn-reset:hover {
            background-color: #45a049;
        }
        .required {
            color: #f44336;
        }
        .form-info {
            font-size: 12px;
            color: #666;
            margin-top: 5px;
        }
    </style>
</head>
<c:import url="/common/header.jsp" />

<body>
<div class="container">
    <h2>1:1 문의하기</h2>
    
    <!-- 에러 메시지 표시 -->
    <% if (request.getAttribute("error") != null) { %>
        <div style="background-color: #ffebee; color: #c62828; padding: 10px; border-radius: 4px; margin-bottom: 20px; border: 1px solid #ffcdd2;">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>
    
    <!-- 성공 메시지 표시 -->
    <% if (request.getAttribute("success") != null) { %>
        <div style="background-color: #e8f5e8; color: #2e7d32; padding: 10px; border-radius: 4px; margin-bottom: 20px; border: 1px solid #c8e6c9;">
            <%= request.getAttribute("success") %>
        </div>
    <% } %>
    
    <form action="Controller?type=QnA" method="post" enctype="multipart/form-data">
        <!-- member_idx는 세션에서 자동으로 가져옴 -->
        <input type="hidden" name="member_idx" value="<%= session.getAttribute("userIdx") != null ? session.getAttribute("userIdx") : "" %>">
        
        <label for="category">문의 유형 <span class="required">*</span></label>
        <select id="category" name="category" required>
            <option value="">--문의 유형을 선택해주세요--</option>
            <option value="계정관리">계정 관리</option>
            <option value="서비스이용">서비스 이용</option>

            <option value="기술지원">기술 지원</option>
            <option value="버그신고">버그 신고</option>
            <option value="기타">기타</option>
        </select>

        <label for="title">제목 <span class="required">*</span></label>
        <input type="text" id="title" name="title" placeholder="문의 제목을 입력해주세요" maxlength="100" required>
        <div class="form-info">최대 100자까지 입력 가능합니다.</div>

        <label for="content">문의 내용 <span class="required">*</span></label>
        <textarea id="content" name="content" placeholder="문의하실 내용을 자세히 작성해주세요" required></textarea>
        <div class="form-info">문의 내용을 구체적으로 작성해주시면 더 빠른 답변이 가능합니다.</div>

        <label for="file_path">첨부파일</label>
        <input type="file" id="file_path" name="file_path" accept=".jpg,.jpeg,.png,.gif,.pdf,.doc,.docx,.txt">
        <div class="form-info">이미지(jpg, jpeg, png, gif), 문서(pdf, doc, docx), 텍스트(txt) 파일만 첨부 가능합니다. (최대 10MB)</div>

        <!-- status는 기본값 '대기중'으로 설정 -->
        <input type="hidden" name="status" value="대기중">
        
        <!-- created_at, updated_at은 서버에서 자동으로 설정 -->
        <!-- inquiry_idx는 데이터베이스에서 자동 생성 -->

        <div class="btn-group">
            <input type="submit" value="문의 등록" class="btn-submit">
            <input type="reset" value="다시 작성" class="btn-reset">
        </div>
    </form>
</div>
<c:import url="/common/footer.jsp" />

<script>
// 파일 크기 체크
document.getElementById('file_path').addEventListener('change', function(e) {
    const file = e.target.files[0];
    const maxSize = 10 * 1024 * 1024; // 10MB
    
    if (file && file.size > maxSize) {
        alert('파일 크기는 10MB를 초과할 수 없습니다.');
        this.value = '';
    }
});

// 폼 제출 전 유효성 검사
document.querySelector('form').addEventListener('submit', function(e) {
    const category = document.getElementById('category').value;
    const title = document.getElementById('title').value.trim();
    const content = document.getElementById('content').value.trim();
    
    if (!category) {
        alert('문의 유형을 선택해주세요.');
        e.preventDefault();
        return;
    }
    
    if (!title) {
        alert('제목을 입력해주세요.');
        e.preventDefault();
        return;
    }
    
    if (!content) {
        alert('문의 내용을 입력해주세요.');
        e.preventDefault();
        return;
    }
    
    if (content.length < 10) {
        alert('문의 내용은 최소 10자 이상 입력해주세요.');
        e.preventDefault();
        return;
    }
});
</script>
</body>
</html>
