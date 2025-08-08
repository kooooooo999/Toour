
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
  <link rel="stylesheet" href="<c:url value="/css/header.css" />">
  <link rel="stylesheet" href="<c:url value="/css/footer.css" />">
  <style>
    .listArea{
      border: 1px solid #1e40af;
      width: 500px;
      height: 500px;
      background-color: #adb5bd;
    }
    .div44{
      grid-template-columns: 200px 200px;
    }
  </style>
</head>
<body>
<c:import url="/common/header.jsp" />

  <table>
    <div>
      <%--내 정보--%>
    </div>

    <tbody>
    <tr>
      <td>
        <div id="zzim_list" class="listArea">
          <a href="Controller">찜 목록</a>
          <hr/>
          <div class="div44">
            <c:forEach var="data" items="${requestScope.dataVO4List}">
              <div>
                <img src="${data}">
              </div>
            </c:forEach>
          </div>
        </div>
      </td>
      <td>
        <div id="course_list" class="listArea">
          <a href="Controller">내 코스 목록</a>
          <hr/>
        </div>
      </td>
    </tr>
    <tr>
      <td>
        <div id="post_list" class="listArea">
          <a href="Controller">내 게시글/ 댓글</a>
          <hr/>
        </div>
      </td><td>
      <div id="suggest_list" class="listArea">
        <a href="Controller">건의사항</a>
        <hr/>
      </div>
    </td>
    </tr>
    </tbody>
  </table>
<c:import url="/common/footer.jsp" />

</body>
</html>
