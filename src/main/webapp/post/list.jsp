<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="<c:url value="/css/header.css" />">
    <link rel="stylesheet" href="<c:url value="/css/footer.css" />">
    <link rel="stylesheet" href="<c:url value="/css/post.css" />">
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
            float: right;
            margin-right: 40px;
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
        }
    </style>
</head>
<body>
<c:import url="/common/header.jsp" />

    <div id="post">
        <h1>여행후기</h1>

        <div class="search-area">
            <form method="post" action="Controller?type=postSearch" onsubmit="return validateForm()">
                <input type="hidden" name="category_idx" value="2">
                <select id="searchType" name="searchType">
                    <option value="post_title" <c:if test="${requestScope.searchType eq 'post_title'}">selected</c:if> >제목</option>
                    <option value="post_content" <c:if test="${requestScope.searchType eq 'post_content'}">selected</c:if>>내용</option>
                    <option value="member_nickname" <c:if test="${requestScope.searchType eq 'member_nickname'}">selected</c:if>>글쓴이</option>
                </select>
                <input type="text" id="searchValue" placeholder="검색내용을 입력해주세요" name="searchValue" <c:if test="${requestScope.searchValue ne null}">value="${requestScope.searchValue}"</c:if> />
                <i class="fas fa-search"><button type="submit" class="fas">검색</button></i>
            </form>
        </div>


        <table summary="검색결과 목록">
            <caption>검색결과 목록</caption>

            <c:set var="t" value="${requestScope.totalCount}"/>
            <div class="totalCount">
                <p>총 <strong>${t}건</strong></p>
            </div>

            <thead>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>별점</th>
                <th>조회수</th>
                <th>작성일</th>
            </thead>
            <tbody>
                <c:set var="p" value="${requestScope.page}" />
                <c:forEach items="${requestScope.ar}" var="vo" varStatus="vs">
                    <c:if test="${not empty vo}">
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
                        <td>${vo.member_nickname}</td>
                        <td>${vo.post_star}</td>
                        <td>${vo.post_views}</td>
                        <td>${vo.post_created_at.substring(0,10)}</td>
                    </tr>
                    </c:if>
                </c:forEach>
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
                <li><a href="Controller?type=<c:if test="${requestScope.searchValue ne null}">postSearch</c:if><c:if test="${requestScope.searchValue eq null}">list</c:if>&cPage=${p.startPage-p.pagePerBlock}<c:if test="${requestScope.searchValue ne null}">&searchValue=${requestScope.searchValue}&searchType=${requestScope.searchType}</c:if> ">&lt;</a></li>
            </c:if>
            <c:forEach begin="${p.startPage}" end="${p.endPage}" varStatus="vs">
                <c:if test="${p.nowPage == vs.index}">
                    <li class="now">${vs.index}</li>
                </c:if>
                <c:if test="${p.nowPage != vs.index}">
                    <li><a href="Controller?type=<c:if test="${requestScope.searchValue ne null}">postSearch</c:if><c:if test="${requestScope.searchValue eq null}">list</c:if>&cPage=${vs.index}<c:if test="${requestScope.searchValue ne null}">&searchValue=${requestScope.searchValue}&searchType=${requestScope.searchType}</c:if> ">${vs.index}</a></li>
                </c:if>
            </c:forEach>
            <c:if test="${p.endPage < p.totalPage}">
                <li><a href="Controller?type=<c:if test="${requestScope.searchValue ne null}">postSearch</c:if><c:if test="${requestScope.searchValue eq null}">list</c:if>&cPage=${p.endPage+1}<c:if test="${requestScope.searchValue ne null}">&searchValue=${requestScope.searchValue}&searchType=${requestScope.searchType}</c:if> ">&gt;</a></li>
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
<c:import url="/common/footer.jsp" />

</html>
