<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<html>
<head>
    <title>문의 상세보기</title>
    <link rel="stylesheet" href="<c:url value="/css/header.css" />">
    <link rel="stylesheet" href="<c:url value="/css/footer.css" />">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }
        .inquiry-info {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .info-row {
            display: flex;
            margin-bottom: 15px;
            border-bottom: 1px solid #e9ecef;
            padding-bottom: 10px;
        }
        .info-label {
            width: 120px;
            font-weight: bold;
            color: #495057;
        }
        .info-value {
            flex: 1;
            color: #212529;
        }
        .status-badge {
            padding: 6px 12px;
            border-radius: 15px;
            font-size: 14px;
            font-weight: bold;
        }
        .status-warning {
            background-color: #fff3cd;
            color: #856404;
        }
        .status-success {
            background-color: #d4edda;
            color: #155724;
        }
        .status-info {
            background-color: #d1ecf1;
            color: #0c5460;
        }
        .status-secondary {
            background-color: #e2e3e5;
            color: #383d41;
        }
        .content-box {
            background-color: #fff;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            padding: 20px;
            margin: 20px 0;
            min-height: 200px;
        }
        .file-info {
            background-color: #e9ecef;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
        }
        .file-link {
            color: #007bff;
            text-decoration: none;
        }
        .file-link:hover {
            text-decoration: underline;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin: 5px;
            font-size: 14px;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #545b62;
        }
        .btn-success {
            background-color: #28a745;
            color: white;
        }
        .btn-success:hover {
            background-color: #218838;
        }
        .btn-group {
            text-align: center;
            margin-top: 30px;
        }
        .no-file {
            color: #6c757d;
            font-style: italic;
        }
    </style>
</head>
<body>
<c:import url="/common/header.jsp" />

<div class="container">
    <h2>문의 상세보기</h2>
    
    <!-- 에러 메시지 표시 -->
    <% if (request.getAttribute("error") != null) { %>
        <div style="background-color: #ffebee; color: #c62828; padding: 10px; border-radius: 4px; margin-bottom: 20px; border: 1px solid #ffcdd2;">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>
    
    <% 
    Map<String, Object> inquiry = (Map<String, Object>) request.getAttribute("inquiry");
    if (inquiry != null) {
    %>
        <!-- 문의 정보 -->
        <div class="inquiry-info">
            <div class="info-row">
                <div class="info-label">문의 번호</div>
                <div class="info-value"><%= inquiry.get("inquiry_idx") %></div>
            </div>
            <div class="info-row">
                <div class="info-label">문의 유형</div>
                <div class="info-value"><%= inquiry.get("category") %></div>
            </div>
            <div class="info-row">
                <div class="info-label">제목</div>
                <div class="info-value"><%= inquiry.get("title") %></div>
            </div>
            <div class="info-row">
                <div class="info-label">상태</div>
                <div class="info-value">
                    <span class="status-badge status-<%= inquiry.get("statusColor") %>">
                        <%= inquiry.get("status") %>
                    </span>
                </div>
            </div>
            <div class="info-row">
                <div class="info-label">작성자</div>
                <div class="info-value"><%= inquiry.get("member_nickname") %></div>
            </div>
            <div class="info-row">
                <div class="info-label">작성일</div>
                <div class="info-value"><%= inquiry.get("created_at") %></div>
            </div>
            <div class="info-row">
                <div class="info-label">수정일</div>
                <div class="info-value"><%= inquiry.get("updated_at") %></div>
            </div>
        </div>
        
        <!-- 문의 내용 -->
        <div class="content-box">
            <h4>문의 내용</h4>
            <div style="white-space: pre-wrap; line-height: 1.6;">
                <%= inquiry.get("content") %>
            </div>
        </div>
        
        <!-- 첨부파일 -->
        <% if (inquiry.get("file_path") != null && !inquiry.get("file_path").toString().isEmpty()) { %>
            <div class="file-info">
                <h4>첨부파일</h4>
                <a href="inquiry_upload/<%= inquiry.get("file_path") %>" 
                   class="file-link" target="_blank">
                    <%= inquiry.get("file_path") %>
                </a>
            </div>
        <% } else { %>
            <div class="file-info">
                <h4>첨부파일</h4>
                <div class="no-file">첨부된 파일이 없습니다.</div>
            </div>
        <% } %>
        
        <!-- 버튼 그룹 -->
        <div class="btn-group">
            <a href="Controller?type=inquiryList" class="btn btn-secondary">목록으로</a>
            <a href="Controller?type=QnA" class="btn btn-success">새 문의 작성</a>
        </div>
        
    <% } else { %>
        <div style="text-align: center; padding: 50px; color: #666;">
            <p>문의 정보를 찾을 수 없습니다.</p>
            <a href="Controller?type=inquiryList" class="btn btn-primary">목록으로 돌아가기</a>
        </div>
    <% } %>
</div>

<c:import url="/common/footer.jsp" />

</body>
</html>
