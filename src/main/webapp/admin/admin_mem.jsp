<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Title</title>
  <!-- 외부CSS 연결하기 -->


</head>

<body>
<div id="wrap">
  <!--========= 상단영역 =======-->
  <header id="header"><hr width="600" border="1" noshade color="navy">
    <div id="title" class="txt_c">
      <strong>toour</strong>
    </div>
    <hr width="600" border="1" noshade color="navy">
    <div id="header" class="txt_c">
      <a href="admin_main.jsp">HOME</a> |
      <a href="admin_mem.jsp">회원정보 관리</a> |
      <a href="product_list.jsp?category=sp003">공지사항 관리</a>   |
      <a href="product_list.jsp?category=sp003">게시물 관리</a>    |
      <a href="product_list.jsp?category=sp003">관광코스 관리</a>   |
      <a href="product_list.jsp?category=sp003">관광지/맛집 관리</a> |
    </div>
    <hr width="600" border="1" noshade color="navy">
  </header>
</div>
<!--============ 상단영역 끝======-->
<!--========= 콘텐츠영역 =======-->
<body>
<div id="post">
  <table summary="게시판 목록">
    <caption>게시판 목록</caption>
    <thead>
    <tr class="title">
      <th class="no">번호</th>
      <th class="no">이름</th>
      <th class="no">아이디</th>
      <th class="no">별명</th>
      <th class="no">경고횟수</th>
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
        <td>${vo.member_name}</td>
        <td>${vo.member_id}</td>
        <td>${vo.member_nickname}</td>
        <td>${vo.member_warning}</td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</div>
</body>
<!--============ 콘텐츠영역 끝======-->
</body>
</html>