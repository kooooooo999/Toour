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
        .disable{display: none;}
        table th{
            border: 1px solid #000;
        }
    </style>
</head>
<body>
    <div id="post">
        <table summary="게시판 목록">
            <caption>게시판 목록</caption>
            <thead>
                <tr class="title">
                    <th class="no">번호</th>
                    <th class="no">제목</th>
                    <th class="no">별점</th>
                    <th class="no">작성자</th>
                    <th class="no">조회수</th>
                    <th class="no">작성일</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td colspan="4">
                        <ol class="paging">
                            <c:set var="p" value="${requestScope.page}" scope="page"/>
                            <c:if test="${p.startPage<p.pagePerBlock}">
                                <li class="disable">&lt;</li>
                            </c:if>
                            <c:if test="${p.startPage >= p.pagePerBlock}">
                                <li><a href="Controller?type=list&cPage=${p.nowPage-p.pagePerBlock}">&lt;</a></li>
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
                                <li><a href="Controller?type=list&cPage=${p.nowPage+p.pagePerBlock}">&gt;</a></li>
                            </c:if>
                            <c:if test="${p.endPage >= p.totalPage}">
                                <li class="disable">&gt;</li>
                            </c:if>

                        </ol>
                    </td>
                    <td>
                        <input type="button" value="글쓰기" onclick="javascript:location.href='Controller?type=write'">
                    </td>
                </tr>
                <c:set var="ar" value="${requestScope.ar}"/>
                <c:set var="i" value="0"/>
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
                        <td>${vo.member_idx}</td>
                        <td>${vo.post_created_at}</td>
                        <td>${vo.post_views}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
