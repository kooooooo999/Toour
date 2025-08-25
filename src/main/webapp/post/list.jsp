<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="<c:url value="/css/footer.css" />">
    <link rel="stylesheet" href="<c:url value="/css/post.css" />">
    <link rel="stylesheet" href="<c:url value="/css/header.css" />">
    <style>
        #post {
            max-width: 1400px;
            margin: 0 auto;
            background-color: #fff;
            border: 1px solid #dee2e6;
            border-radius: 8px !important;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            overflow-x: auto; /* 테이블이 너무 넓을 경우 스크롤바 생성 */
        }
        .write-button {
            height: 36px;
            padding: 0 16px;
            font-size: 14px;
            background-color: #1a73e8;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        table {
            width: 100%;
            border-collapse: collapse !important;
            text-align: center;
            min-width: 800px; /* 테이블이 너무 작아지는 것 방지 */
        }

        #post h1{
            color: #222;
            text-align: center;
            margin-top: 40px;
        }

        .totalCount{
            margin-left: 40px;
        }

        .search-area{
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 10px
        }

        .totalCount p{
            font-weight: bold;
        }

        .totalCount strong{
            color: #1a73e8;
        }

        #searchValue {
            height: 38px; /* 버튼과 비슷한 높이 */
            padding: 6px 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            width: 200px;
        }

        #searchType {
            height: 38px;
            padding: 6px 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-right: 5px;
        }

        .search-area button {
            height: 38px;
            padding: 6px 15px;
            font-size: 14px;
            background-color: #1a73e8;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .search-area button:hover {
            background-color: #1557b0;
        }

        .no-result {
            color: #666;
            font-size: 16px;
        }

        .no-result strong {
            color: #1a73e8;
        }

        body {
            margin: 0;
            padding: 0;
        }

        .paging-area {
            margin-bottom: 20px !important;
            padding-bottom: 0 !important;

        }

        footer {
            margin-top: 0 !important;
        }
        .title-wrap {
            position: relative;
            text-align: center;
            margin-top: 40px;
            margin-bottom: 20px;
        }

        .title-wrap h1 {
            font-size: 36px;
            font-weight: bold;
            margin: 0;
        }

        .title-wrap .write-button {
            height: 38px;
            padding: 6px 15px;
            font-size: 14px;
            background-color: #1a73e8;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .filter-search-wrap {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin: 20px 40px;
            flex-wrap: wrap;
        }

        .left-area {
            display: flex;
            gap: 20px;
            align-items: center;     /* 세로 중앙 정렬 */

        }

        /* 정렬 메뉴 상단 위치 */
        .sort-area {
            font-size: 14px;
            color: #444;
            margin-bottom: 0px !important;
        }

        .sort-area a {
            margin: 0 5px;
            color: #444;
            text-decoration: none;
        }

        .sort-area a.active {
            font-weight: bold;
            color: #1a73e8;
        }
        table {
            width: 100%;
            border-collapse: collapse !important;
            text-align: center;
            min-width: 800px;
            table-layout: fixed; /* 열 너비를 고정함 */
        }
        td, th {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .table-container{

        }

    </style>
</head>
<body>
<c:import url="/common/header.jsp" />

<div id="post">
    <h1>여행후기</h1>


    <div class="filter-search-wrap">
        <div class="left-area">
            <p class="totalCount">총 <strong>${requestScope.totalCount}</strong>건</p>
            <div class="sort-area">
                <a href="Controller?type=list&sort=latest" class="${sort eq 'latest' ? 'active' : ''}">최신순</a>
                <span>|</span>
                <a href="Controller?type=list&sort=likes" class="${sort eq 'likes' ? 'active' : ''}">추천순</a>
                <span>|</span>
                <a href="Controller?type=list&sort=popular" class="${sort eq 'popular' ? 'active' : ''}">인기순</a>
            </div>
        </div>

        <div class="search-area">
            <form method="post" action="Controller?type=postSearch" onsubmit="return validateForm()" style="display: flex; gap: 10px;">
                <input type="hidden" name="category_idx" value="2">
                <select id="searchType" name="searchType">
                    <option value="post_title" <c:if test="${requestScope.searchType eq 'post_title'}">selected</c:if>>제목</option>
                    <option value="post_content" <c:if test="${requestScope.searchType eq 'post_content'}">selected</c:if>>내용</option>
                    <option value="title_content" <c:if test="${requestScope.searchType eq 'title_content'}">selected</c:if>>제목+내용</option>
                    <option value="member_nickname" <c:if test="${requestScope.searchType eq 'member_nickname'}">selected</c:if>>글쓴이</option>
                </select>
                <input type="text" id="searchValue" placeholder="검색내용을 입력해주세요" name="searchValue"
                       <c:if test="${requestScope.searchValue ne null}">value="${requestScope.searchValue}"</c:if> />
                <input type="button" value="&#128393; 글쓰기" onclick="location.href='Controller?type=write'" class="write-button">
<%--                <button type="submit">검색</button>--%>
            </form>
        </div>
    </div>
    <div class="table-container">
    <c:set var="t" value="${requestScope.totalCount}"/>
    <table summary="검색결과 목록">
            <caption>검색결과 목록</caption>
            <thead>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>추천수</th>
                <th>조회수</th>
                <th>작성일</th>
            </thead>
            <tbody>
                <c:set var="p" value="${requestScope.page}" />
                <c:choose>
                    <c:when test="${not empty requestScope.ar and fn:length(requestScope.ar) > 0}">
                        <c:forEach items="${requestScope.ar}" var="vo" varStatus="vs">
                            <c:if test="${not empty vo}">
                            <c:set var="num" value="${p.totalCount -((p.nowPage-1)*p.numPerPage+vs.index)}"/>
                            <tr>
                                <td>${num}</td>
                                <td style="text-align: left">
                                    <input type="hidden" name="post_idx" value="${vo.post_idx}" />
                                    <a href="Controller?type=view&post_idx=${vo.post_idx}&cPage=${p.nowPage}">
                                            ${vo.post_title}
                                        <c:if test="${vo.c_list != null and fn:length(vo.c_list) > 0}">
                                            (<c:out value="${fn:length(vo.c_list)}"/>)
                                        </c:if>
                                    </a>
                                </td>
                                <td>${vo.member_nickname}</td>
                                <td>${vo.post_likes}</td>
                                <td>${vo.post_views}</td>
                                <td>${vo.post_created_at.substring(0,10)}</td>
                            </tr>
                            </c:if>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="6" style="text-align: center; padding: 50px;">
                                <div class="no-result">
                                    <c:choose>
                                        <c:when test="${not empty requestScope.searchValue}">
                                            <strong>"${requestScope.searchValue}"</strong>에 대한 검색 결과가 없습니다.<br>
                                            다른 검색어를 입력해보세요.
                                        </c:when>
                                        <c:otherwise>
                                            게시글이 없습니다.
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

    </div>

<div class="paging-area">
    <ol class="paging">
        <c:set var="p" value="${requestScope.page}" />
        <c:set var="baseParams" value="type=${requestScope.searchValue ne null ? 'postSearch' : 'list'}&sort=${sort}" />

        <%-- '이전' 화살표 --%>
        <c:choose>
            <c:when test="${p.startPage <= p.pagePerBlock}">
                <li class="disable">&lt;</li>
            </c:when>
            <c:otherwise>
                <li><a href="Controller?${baseParams}&cPage=${p.startPage - p.pagePerBlock}">&lt;</a></li>
            </c:otherwise>
        </c:choose>


    <%-- 페이지 번호 --%>
        <c:forEach begin="${p.startPage}" end="${p.endPage}" var="pageIndex">
            <c:choose>
                <c:when test="${p.nowPage == pageIndex}">
                    <li class="now">${pageIndex}</li>
                </c:when>
                <c:otherwise>
                    <li><a href="Controller?${baseParams}&cPage=${pageIndex}">${pageIndex}</a></li>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <%-- '다음' 화살표 --%>
        <%-- '다음' 화살표 --%>
        <c:choose>
            <c:when test="${p.endPage >= p.totalPage}">
                <li class="disable">&gt;</li>
            </c:when>
            <c:otherwise>
                <li><a href="Controller?${baseParams}&cPage=${p.endPage + 1}">&gt;</a></li>
            </c:otherwise>
        </c:choose>
    </ol>
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
