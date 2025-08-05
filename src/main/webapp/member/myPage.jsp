
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
  <link rel="stylesheet" href="<c:url value="/css/header.css" />">
  <link rel="stylesheet" href="<c:url value="/css/footer.css" />">
</head>
<body>
<c:import url="/common/header.jsp" />

  <table>
    <div>
      <%--내 정보--%>
    </div>

    <tbody>
    <tr>
      <td><a href="Controller?type=test">찜 목록</a></td>
      <td><a href="Controller">내 코스</a></td>
    </tr>
    <tr>
      <td><a href="Controller">내 게시글/댓글</a></td>
      <td><a href="Controller">건의사항</a></td>
    </tr>
    </tbody>
  </table>
<c:import url="/common/footer.jsp" />

</body>
</html>
