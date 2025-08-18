<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

<div class="container">
    <h2>내 문의 목록</h2>
    


    <!-- 검색 폼 -->
    <div class="search-form">
        <form method="get" action="Controller?type=inquirySearch" onsubmit="return validateForm()">
            <c:set var="category" value="${empty param.category ? '' : param.category}" />

            <select id="category" name="category">
                <option value="" >전체 유형</option>
                <option value="계정관리" >계정관리</option>
                <option value="서비스이용">서비스이용</option>
                <option value="기술지원" >기술지원</option>
                <option value="버그신고" >버그신고</option>
                <option value="기타" >기타</option>
            </select>

            <select name="searchType" id="searchType">
                <option value="">검색 조건</option>
                <option value="title" <c:if test="${param.searchType eq 'title'}">selected</c:if>>제목</option>
                <option value="content" <c:if test="${param.searchType eq 'content'}">selected</c:if>>내용</option>
            </select>
            
            <input type="text" name="searchValue" placeholder="검색어를 입력하세요" id="searchValue"
                   value="${param.searchValue}">
            
            <button type="submit">검색</button>
            <a href="Controller?type=inquiryList" class="btn btn-success">전체보기</a>
        </form>
    </div>

    <!-- 문의 목록 테이블 -->
    <table class="inquiry-table">
        <caption>문의 목록 테이블</caption>

        <c:set var="t" value="${requestScope.QnAtotalCount}"/>
        <div class="totalCount">
            <p>총 <strong>${t}건</strong></p>
        </div>

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
        <c:set var="p" value="${requestScope.QnAPage}" />
        <c:set var="inquiryList" value="${requestScope.inquiryList}" scope="page"/>
        <c:choose>
            <c:when test="${not empty inquiryList and fn:length(requestScope.inquiryList) > 0}">
                <c:forEach items="${inquiryList}" var="vo" varStatus="vs">
                    <c:if test="${not empty vo}">
                    <c:set var="num" value="${p.totalCount -((p.nowPage-1)*p.numPerPage+vs.index)}"/>
                        <tr>
                            <td>${num}</td>
                            <td>${vo.category}</td>
                            <td style="text-align: left">
                                <a href="Controller?type=inquiryView&inquiry_idx=${vo.inquiry_idx}&cPage=${p.nowPage}">
                                        ${vo.title}
                                </a>
                            </td>

                            <td><span class="status-badge status-${vo.statusColor}">${vo.status}</span></td>
                            <td>${vo.created_at.substring( 0, 10)}</td>
                            <td>
                                <a href="Controller?type=inquiryView&inquiry_idx=${vo.inquiry_idx}" class="btn btn-primary">보기</a>
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
            </c:when>

            <c:otherwise>
                <tr>
                    <td colspan="6" class="no-data" style="text-align: center; padding: 50px;">
                        <div class="no-result">
                            <c:choose>
                                <c:when test="${not empty requestScope.searchValue}">
                                    <label>"${requestScope.searchValue}"</label>에 대한 검색 결과가 없습니다.<br>
                                    다른 검색어를 입력해보세요.
                                </c:when>
                                <c:otherwise> 등록된 문의가 없습니다</c:otherwise>
                            </c:choose>
                        </div>
                    </td>
                </tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>
    
    <!-- 페이징 -->

    <c:set var="baseUrl" value="Controller?type=inquiryList" />
    <c:if test="${not empty requestScope.searchValue}">
        <c:set var="baseUrl" value="${baseUrl}&searchValue=${requestScope.searchValue}&searchType=${requestScope.searchType}" />
    </c:if>

    <div class="paging-area">
    <ol class="paging">
        <!--이전이나 다음 블록으로 이동 불가-->
    <c:if test="${p.startPage < p.pagePerBlock}">
        <li class="disable">&lt;</li>
    </c:if>
        <!--이전이나 다음 블록으로 이동-->
    <c:if test="${p.startPage >= p.pagePerBlock}">
        <li><a href="Controller?type=<c:if test="${requestScope.searchValue ne null}">inquiryList</c:if><c:if test="${requestScope.searchValue eq null}">list</c:if>&cPage=${p.startPage-p.pagePerBlock}<c:if test="${requestScope.searchValue ne null}">&searchValue=${requestScope.searchValue}&searchType=${requestScope.searchType}</c:if> ">&lt;</a></li>
    </c:if>
    <c:forEach begin="${p.startPage}" end="${p.endPage}" varStatus="vs">
        <c:if test="${p.nowPage == vs.index}">
            <li class="now">${vs.index}</li>
        </c:if>
        <c:if test="${p.nowPage != vs.index}">
            <li><a href="Controller?type=<c:if test="${requestScope.searchValue ne null}">inquiryList</c:if><c:if test="${requestScope.searchValue eq null}">inquiryList</c:if>&cPage=${vs.index}<c:if test="${requestScope.searchValue ne null}">&searchValue=${requestScope.searchValue}&searchType=${requestScope.searchType}</c:if> ">${vs.index}</a></li>
        </c:if>
    </c:forEach>
    <c:if test="${p.endPage < p.totalPage}">
        <li><a href="Controller?type=<c:if test="${requestScope.searchValue ne null}">inquiryList</c:if><c:if test="${requestScope.searchValue eq null}">inquiryList</c:if>&cPage=${p.endPage+1}<c:if test="${requestScope.searchValue ne null}">&searchValue=${requestScope.searchValue}&searchType=${requestScope.searchType}</c:if> ">&gt;</a></li>
    </c:if>
    <c:if test="${p.endPage >= p.totalPage}">
        <li class="disable">&gt;</li>
    </c:if>
    </ol>
    </div>
    <!-- 새 문의 작성 버튼 -->
    <div style="text-align: center; margin-top: 30px;">
        <a href="Controller?type=QnA" class="btn btn-success">새 문의 작성</a>
    </div>
</div>
<c:import url="/common/footer.jsp" />

</body>


<script>
    <%--
    검색 내용 유효성 검사
    --%>
    function validateForm() {
        let searchValue = document.getElementById('searchValue').value;
        if(searchValue.trim() === '' ){
            alert('검색 내용을 입력하세요');
            return false;
        }
        return true;
    }


</script>
</html>
