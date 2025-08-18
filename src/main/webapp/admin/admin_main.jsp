<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 페이지</title>
    <style>
        body {
            margin: 0;
            font-family: 'Noto Sans KR', sans-serif;
            display: flex;
            background-color: #f4f6f8;
        }

        .sidebar {
            width: 220px;
            background-color: #2c3e50;
            display: flex;
            flex-direction: column;
            padding: 20px;
            color: white;
            height: 100vh;
        }

        .sidebar a {
            text-decoration: none;
            color: white;
            padding: 12px 10px;
            border-bottom: 1px solid #34495e;
            transition: background-color 0.3s;
        }

        .sidebar a:hover {
            background-color: #34495e;
        }


        .main-content {
            flex: 1;
            padding: 40px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            border-radius: 6px;
            overflow: hidden;
        }

        .dashboard {
            display: grid;
            grid-template-columns: repeat(2, 1fr); /* 2열 */
            gap: 20px; /* 카드 사이 간격 */
            padding: 20px;
        }

        .card {
            background-color: #ffffff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            text-align: center;
            height: 200px;
        }

        .card2 {
            background-color: #ffffff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            text-align: center;
            height: 200px;
        }

        .card-title {
            font-size: 18px;
            font-weight: bold;
            color: #2c3e50;
        }

        .card-title small {
            font-size: 13px;
            color: #7f8c8d;
        }

        .today_visit{
            font-size: 18px;
            font-weight: bold;
            color: #2c3e50;
        }

        .today_board{
            font-size: 18px;
            font-weight: bold;
            color: #2c3e50;
        }

        .today_warning{
            font-size: 18px;
            font-weight: bold;
            color: #2c3e50;
        }


        table caption{text-indent: -9999px;}

    </style>
</head>
<body>

<div class="sidebar">
    <!-- 메뉴 -->
    <a href="AdminController">🏠 HOME</a>
    <a href="AdminController?type=adminnotice">📢 공지사항 관리</a>
    <a href="AdminController?type=adminpost">📝 게시물 관리</a>
    <a href="AdminController?type=adminmemlist">👥 회원정보 관리</a>
    <a href="AdminController?type=AdminInquiry">📬문의사항 관리</a>
</div>

<div class="main-content">
    <h1>관리자 페이지</h1>


<div class="dashboard">
    <div class="card">
        <div class="card-title">
            <c:set var="t" value="${requestScope.totalCount}"/>
            전체 회원 수<br>
            <small>(전체회원수 / 휴면회원수 / 탈퇴회원수 / 강퇴회원수)</small>
            <p>${t}</p>
        </div>
    </div>
    <div class="card">
        <div class="today_visit">
            오늘 방문자 수
        </div>
    </div>
    <div class="card2">
        <div class="today_board">
            오늘 게시글 수
        </div>
    </div>
    <div class="card2">
        <div class="today_warning">
            최근 신고 수 (한달)
        </div>
    </div>
</div>
</div>
<div>
    <table>
        <caption>문의사항 테이블</caption>
        <thead>
           <th>번호</th>
           <th>카테고리</th>
           <th>제목</th>
           <th>작성자</th>
           <th>읽음/안읽음</th>
           <th>답변상태</th>
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
                            <td>${vo.category}</td>
                            <td style="text-align: left">
                                <a href="Controller?type=view&post_idx=${vo.post_idx}&cPage=${nowPage}">
                                        ${vo.title}
                                </a>
                            </td>
                            <td>${vo.member_nickname}</td>
                            <td>${vo.is_read}</td>
                            <td>${vo.status}</td>
                            <td>${vo.post_created_at.substring(0,10)}</td>
                        </tr>
                    </c:if>
                </c:forEach>
            </c:when>
        </c:choose>
        </tbody>
    </table>


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
    </div>
</div>

</body>
</html>
