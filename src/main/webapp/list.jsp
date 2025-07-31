<%--
  Created by IntelliJ IDEA.
  User: kke33
  Date: 25. 7. 29.
  Time: 오전 11:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Title</title>
    <style>
            /* 전체 페이지 배경 및 기본 폰트 설정 */
        body {
            font-family: 'Malgun Gothic', '맑은 고딕', sans-serif;
            background-color: #f8f9fa;
            color: #333;
            line-height: 1.6;
            padding: 40px;
        }

        /* 게시판 컨테이너 */
        #post {
            max-width: 1200px;
            margin: 0 auto;
            background-color: #fff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            overflow-x: auto; /* 테이블이 너무 넓을 경우 스크롤바 생성 */
        }

        /* 테이블 공통 스타일 */
        table {
            width: 100%;
            border-collapse: collapse;
            text-align: center;
            min-width: 800px; /* 테이블이 너무 작아지는 것 방지 */
        }

        caption {
            caption-side: top;
            text-align: left;
            font-size: 24px;
            font-weight: bold;
            padding: 20px 20px 10px;
            color: #495057;
        }

        /* 테이블 헤더 (thead) 스타일 */
        thead {
            background-color: #e9ecef;
            border-bottom: 2px solid #adb5bd;
        }

        .title th {
            padding: 15px 10px;
            font-weight: bold;
            color: #495057;
            border: none; /* 기존 border를 제거하고 깔끔하게 */
        }

        /* 테이블 바디 (tbody) 스타일 */
        tbody tr {
            border-bottom: 1px solid #e9ecef;
        }

        tbody tr:nth-child(even) {
            background-color: #f8f9fa; /* 짝수 행 배경색 */
        }

        tbody tr:hover {
            background-color: #e2e6ea; /* 마우스 오버 시 색상 변경 */
        }

        tbody td {
            padding: 15px 10px;
        }

        td a {
            color: #337ab7;
            text-decoration: none;
            transition: color 0.2s ease;
        }

        td a:hover {
            color: #23527c;
            text-decoration: underline;
        }

        /* 페이징 및 글쓰기 버튼이 있는 행 스타일 */
        tbody tr:last-child {
            background-color: #fff;
            border-bottom: none;
        }

        /* 페이징 영역 스타일 */
        .paging {
            display: flex;
            justify-content: center;
            align-items: center;
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .paging li {
            margin: 0 4px;
            font-size: 14px;
        }

        .paging li a, .paging li.now {
            display: block;
            padding: 8px 12px;
            border-radius: 4px;
            transition: background-color 0.2s ease, color 0.2s ease;
            text-decoration: none;
            color: #495057;
            border: 1px solid #dee2e6;
        }

        .paging li a:hover {
            background-color: #e9ecef;
        }

        .paging li.now {
            background-color: #007bff;
            color: #fff;
            font-weight: bold;
            border-color: #007bff;
            pointer-events: none; /* 현재 페이지는 클릭 비활성화 */
        }

        /* 비활성화된 페이징 버튼 (disable 클래스) */
        .paging li.disable {
            pointer-events: none; /* 클릭 이벤트 제거 */
            opacity: 0.5; /* 흐리게 처리 */
            color: #6c757d;
            border: 1px solid #dee2e6;
            padding: 8px 12px;
            border-radius: 4px;
        }

        /* 글쓰기 버튼 스타일 */
        input[type="button"] {
            padding: 10px 20px;
            font-size: 14px;
            font-weight: bold;
            color: #fff;
            background-color: #0056b3; /* 녹색 버튼 */
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.2s ease;
        }
        button[type="submit"]{
            padding: 10px 20px;
            font-size: 14px;
            font-weight: bold;
            color: #fff;
            background-color: #0056b3; /* 녹색 버튼 */
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.2s ease;
        }

        input[type="button"]:hover {
            background-color: #218838;
        }

    </style>
    </style>
</head>
<body>
    <div id="post">
        <div class="search-area">
            <form method="post" action="Controller?type=postSearch" onsubmit="return validateForm()">
                <input type="hidden" name="category_idx" value="2">
                <select id="searchType" name="searchType">
                    <option value="post_title">제목</option>
                    <option value="post_content">내용</option>
                    <option value="member_nickname">글쓴이</option>
                </select>
                <input type="text" id="searchValue" placeholder="검색내용을 입력해주세요" name="searchValue"/>
                <i class="fas fa-search"><button type="submit" class="fas">검색</button></i>
            </form>
        </div>
        <table summary="게시판 목록">
            <caption>게시판 목록</caption>
            <thead>
                <tr class="title">
                    <th class="no">번호</th>
                    <th class="no">제목</th>
                    <th class="no">별점</th>
                    <th class="no">글쓴이</th>
                    <th class="no">조회수</th>
                    <th class="no">작성일</th>
                </tr>
            </thead>
            <tbody>
            <c:if test="${not empty ar}">
                <c:set var="p" value="${requestScope.page}" />
                <c:forEach items="${ar}" var="vo" varStatus="vs">
                    <c:set var="num" value="${p.totalCount -((p.nowPage-1)*p.numPerPage+vs.index)}"/>
                    <tr>
                        <td>${num}</td>
                        <td style="text-align: left">
                            <a href="Controller?type=view&post_idx=${vo.post_idx}&cPage=${nowPage}">
                                    ${vo.post_title}
                                <c:if test="${vo.c_list != null and fn:length(vo.c_list) > 0}">
                                    (<c:out value="${fn:length(vo.c_list)}"/>)
                                </c:if>
                            </a>
                        </td>
                        <td>${fn:length(vo.c_list)}</td>
                        <td>${vo.member_nickname}</td>
                        <td>${vo.post_star}</td>
                        <td>${vo.post_views}</td>
                        <td>${vo.post_created_at.substring(0,10)}</td>
                    </tr>
                </c:forEach>
            </c:if>
            </tbody>
        </table>
    </div>

    <div class="paging-area">
        <ol class="paging">
            <c:set var="p" value="${requestScope.page}" />
            <c:if test="${p.startPage < p.pagePerBlock}">
                <li class="disable">&lt;</li>
            </c:if>
            <c:if test="${p.startPage >= p.pagePerBlock}">
                <li><a href="Controller?type=list&cPage=${p.startPage-p.pagePerBlock}">&lt;</a></li>
            </c:if>
            <c:forEach begin="${p.startPage}" end="${p.endPage}" varStatus="vs">
                <c:if test="${p.nowPage == vs.index}">
                    <li class="now">${vs.index}</li>
                </c:if>
                <c:if test="${p.nowPage != vs.index}">
                    <li><a href="Controller?type=list&cPage=${vs.index}">${vs.index}</a></li>
                </c:if>
            </c:forEach>
            <c:if test="${p.endPage < p.totalPage}">
                <li><a href="Controller?type=list&cPage=${p.endPage+1}">&gt;</a></li>
            </c:if>
            <c:if test="${p.endPage >= p.totalPage}">
                <li class="disable">&gt;</li>
            </c:if>
        </ol>
        <input type="button" value="글쓰기" onclick="javascript:location.href='Controller?type=write'">
    </div>
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
