<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<html>
<head>
    <title>내 문의 목록</title>
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
            max-width: 1000px;
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
        .search-form {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .search-form select, .search-form input, .search-form button {
            padding: 8px 12px;
            margin: 0 5px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .search-form button {
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
        }
        .search-form button:hover {
            background-color: #0056b3;
        }
        .inquiry-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .inquiry-table th, .inquiry-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .inquiry-table th {
            background-color: #f8f9fa;
            font-weight: bold;
        }
        .inquiry-table tr:hover {
            background-color: #f5f5f5;
        }
        .status-badge {
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
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
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin: 2px;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-success {
            background-color: #28a745;
            color: white;
        }
        .btn-success:hover {
            background-color: #218838;
        }
        .pagination {
            text-align: center;
            margin-top: 30px;
        }
        .pagination a {
            padding: 8px 12px;
            margin: 0 4px;
            border: 1px solid #ddd;
            text-decoration: none;
            color: #007bff;
        }
        .pagination a:hover {
            background-color: #007bff;
            color: white;
        }
        .pagination .current {
            background-color: #007bff;
            color: white;
            border: 1px solid #007bff;
        }
        .no-data {
            text-align: center;
            padding: 50px;
            color: #666;
        }
        .title-link {
            color: #007bff;
            text-decoration: none;
        }
        .title-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<c:import url="/common/header.jsp" />

<div class="container">
    <h2>내 문의 목록</h2>
    
    <!-- 에러 메시지 표시 -->
    <% if (request.getAttribute("error") != null) { %>
        <div style="background-color: #ffebee; color: #c62828; padding: 10px; border-radius: 4px; margin-bottom: 20px; border: 1px solid #ffcdd2;">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>
    
    <!-- 검색 폼 -->
    <div class="search-form">
        <form method="get" action="Controller?type=inquiryList">
            <select name="category">
                <option value="">전체 유형</option>
                <option value="계정관리" <%= "계정관리".equals(request.getAttribute("category")) ? "selected" : "" %>>계정 관리</option>
                <option value="서비스이용" <%= "서비스이용".equals(request.getAttribute("category")) ? "selected" : "" %>>서비스 이용</option>
                <option value="기술지원" <%= "기술지원".equals(request.getAttribute("category")) ? "selected" : "" %>>기술 지원</option>
                <option value="버그신고" <%= "버그신고".equals(request.getAttribute("category")) ? "selected" : "" %>>버그 신고</option>
                <option value="기타" <%= "기타".equals(request.getAttribute("category")) ? "selected" : "" %>>기타</option>
            </select>
            
            <select name="searchType">
                <option value="">검색 조건</option>
                <option value="title" <%= "title".equals(request.getAttribute("searchType")) ? "selected" : "" %>>제목</option>
                <option value="content" <%= "content".equals(request.getAttribute("searchType")) ? "selected" : "" %>>내용</option>
            </select>
            
            <input type="text" name="searchValue" placeholder="검색어를 입력하세요" 
                   value="<%= request.getAttribute("searchValue") != null ? request.getAttribute("searchValue") : "" %>">
            
            <button type="submit">검색</button>
            <a href="Controller?type=inquiryList" class="btn btn-success">전체보기</a>
        </form>
    </div>
    
    <!-- 문의 목록 테이블 -->
    <table class="inquiry-table">
        <thead>
            <tr>
                <th width="10%">번호</th>
                <th width="15%">유형</th>
                <th width="30%">제목</th>
                <th width="15%">상태</th>
                <th width="15%">작성일</th>
                <th width="15%">관리</th>
            </tr>
        </thead>
        <tbody>
            <% 
            List<Map<String, Object>> inquiryList = (List<Map<String, Object>>) request.getAttribute("inquiryList");
            if (inquiryList != null && !inquiryList.isEmpty()) {
                for (Map<String, Object> inquiry : inquiryList) {
            %>
                <tr>
                    <td><%= inquiry.get("inquiry_idx") %></td>
                    <td><%= inquiry.get("category") %></td>
                    <td>
                        <a href="Controller?type=inquiryView&inquiry_idx=<%= inquiry.get("inquiry_idx") %>" 
                           class="title-link">
                            <%= inquiry.get("title") %>
                        </a>
                    </td>
                    <td>
                        <span class="status-badge status-<%= inquiry.get("statusColor") %>">
                            <%= inquiry.get("status") %>
                        </span>
                    </td>
                    <td><%= inquiry.get("created_at") %></td>
                    <td>
                        <a href="Controller?type=inquiryView&inquiry_idx=<%= inquiry.get("inquiry_idx") %>" 
                           class="btn btn-primary">보기</a>
                    </td>
                </tr>
            <%
                }
            } else {
            %>
                <tr>
                    <td colspan="6" class="no-data">등록된 문의가 없습니다.</td>
                </tr>
            <%
            }
            %>
        </tbody>
    </table>
    
    <!-- 페이징 -->
    <% 
    Object pageObj = request.getAttribute("page");
    if (pageObj != null) {
        toour.util.Paging page = (toour.util.Paging) pageObj;
        if (page.getTotalPage() > 0) {
    %>
        <div class="pagination">
            <% if (page.getNowPage() > 1) { %>
                <a href="Controller?type=inquiryList&cPage=1&category=<%= request.getAttribute("category") != null ? request.getAttribute("category") : "" %>&searchType=<%= request.getAttribute("searchType") != null ? request.getAttribute("searchType") : "" %>&searchValue=<%= request.getAttribute("searchValue") != null ? request.getAttribute("searchValue") : "" %>">처음</a>
                <a href="Controller?type=inquiryList&cPage=<%= page.getNowPage()-1 %>&category=<%= request.getAttribute("category") != null ? request.getAttribute("category") : "" %>&searchType=<%= request.getAttribute("searchType") != null ? request.getAttribute("searchType") : "" %>&searchValue=<%= request.getAttribute("searchValue") != null ? request.getAttribute("searchValue") : "" %>">이전</a>
            <% } %>
            
            <% for (int i = page.getStartPage(); i <= page.getEndPage(); i++) { %>
                <% if (i == page.getNowPage()) { %>
                    <span class="current"><%= i %></span>
                <% } else { %>
                    <a href="Controller?type=inquiryList&cPage=<%= i %>&category=<%= request.getAttribute("category") != null ? request.getAttribute("category") : "" %>&searchType=<%= request.getAttribute("searchType") != null ? request.getAttribute("searchType") : "" %>&searchValue=<%= request.getAttribute("searchValue") != null ? request.getAttribute("searchValue") : "" %>"><%= i %></a>
                <% } %>
            <% } %>
            
            <% if (page.getNowPage() < page.getTotalPage()) { %>
                <a href="Controller?type=inquiryList&cPage=<%= page.getNowPage()+1 %>&category=<%= request.getAttribute("category") != null ? request.getAttribute("category") : "" %>&searchType=<%= request.getAttribute("searchType") != null ? request.getAttribute("searchType") : "" %>&searchValue=<%= request.getAttribute("searchValue") != null ? request.getAttribute("searchValue") : "" %>">다음</a>
                <a href="Controller?type=inquiryList&cPage=<%= page.getTotalPage() %>&category=<%= request.getAttribute("category") != null ? request.getAttribute("category") : "" %>&searchType=<%= request.getAttribute("searchType") != null ? request.getAttribute("searchType") : "" %>&searchValue=<%= request.getAttribute("searchValue") != null ? request.getAttribute("searchValue") : "" %>">마지막</a>
            <% } %>
        </div>
    <%
        }
    }
    %>
    
    <!-- 새 문의 작성 버튼 -->
    <div style="text-align: center; margin-top: 30px;">
        <a href="Controller?type=QnA" class="btn btn-success">새 문의 작성</a>
    </div>
</div>
<c:import url="/common/footer.jsp" />

</body>
</html>
