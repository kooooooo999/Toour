
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
  <link rel="stylesheet" href="<c:url value="/css/header.css" />">
  <link rel="stylesheet" href="<c:url value="/css/footer.css" />">
  <style>
    .listArea{
      border: 0.5px solid #1e40af;
      width: 500px;
      height: 500px;
      background-color: #EFF7FF;
      overflow: hidden;
    }
    .div44{
      display: grid;
      grid-template-columns: 500px 500px;
    }
    .divSmall44{
        display: grid;
        grid-template-columns: 250px 250px;
    }
    .oneDiv{
        height: 238px;
        width: 250px;
    }
    .imgSize{
        height: 160px;
        width: 250px;
    }
    .overflowHidden{
        overflow: hidden;
    }

  </style>
</head>
<body>
<c:import url="/common/header.jsp" />

  <table>
    <div>
      <%--내 정보--%>
    </div>

    <div class="div44">
        <div id="zzim_list" class="listArea">
          <a href="Controller">찜 목록</a>
          <div class="divSmall44">
            <c:forEach var="dataVO" items="${requestScope.tour_ar}" varStatus="vs">
              <div class="oneDiv" >
                  <a href="#">${dataVO.title}</a>
                  <img src="${dataVO.firstimage}" class="imgSize">
                  <p class="overflowHidden">${dataVO.addr1}</p>
              </div>
            </c:forEach>
          </div>
        </div>

        <div id="course_list" class="listArea">
          <a href="Controller">내 코스 목록</a>
            <div class="divSmall44">
                <c:forEach var="courseVO" items="${requestScope.course_ar}" varStatus="vs">
                    <div class="oneDiv" >
                        <a href="#">${courseVO.course_name}</a>
                        <p> ${courseVO.course_summary}</p>
                    </div>
                </c:forEach>
            </div>

        </div>

        <div id="post_list" class="listArea">
          <a href="Controller">내 게시글/ 댓글</a>

        </div>

      <div id="suggest_list" class="listArea">
        <a href="Controller">건의사항</a>

      </div>
    </div>

<c:import url="/common/footer.jsp" />
</body>
</html>
