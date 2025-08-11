
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Title</title>
  <link rel="stylesheet" href="<c:url value="/css/header.css" />">
  <link rel="stylesheet" href="<c:url value="/css/footer.css" />">

    <link rel="stylesheet" href="<c:url value="/css/post.css" />">
    <style>
        #post {
            max-width: 1200px;
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
    </style>

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


            <div id="mypost">
                <div id="post">
                    <div class="search-area">
                        <form method="post" action="Controller?type=postSearch" onsubmit="return validateForm()">
                            <input type="hidden" name="category_idx" value="2">
                            <select id="searchType" name="searchType">
                                <option value="post_title">제목</option>
                                <option value="post_content">내용</option>
                            </select>
                            <input type="text" id="searchValue" placeholder="검색내용을 입력해주세요" name="searchValue"/>
                            <i class="fas fa-search"><button type="submit" class="fas">검색</button></i>
                        </form>
                    </div>
                    <table summary="검색결과 목록">
                        <caption>검색결과 목록</caption>
                        <thead>
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>별점</th>
                        <th>조회수</th>
                        <th>작성일</th>

                        </thead>
                        <tbody>
                        <c:if test="${not empty requestScope.myPost_ar}">
                            <c:set var="p" value="${requestScope.page}" />
                            <c:forEach items="${requestScope.myPost_ar}" var="vo" varStatus="vs">
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
                            <li><a href="javascript:movePage(${p.startPage-p.pagePerBlock})">&lt;</a></li>
                        </c:if>
                        <c:forEach begin="${p.startPage}" end="${p.endPage}" varStatus="vs">
                            <c:if test="${p.nowPage == vs.index}">
                                <li class="now">${vs.index}</li>
                            </c:if>
                            <c:if test="${p.nowPage != vs.index}">
                                <li><a href="javascript:movePage(${vs.index})">${vs.index}</a></li>
                            </c:if>
                        </c:forEach>
                        <c:if test="${p.endPage < p.totalPage}">
                            <li><a href="javascript:movePage(${p.endPage+1})">&gt;</a></li>
                        </c:if>
                        <c:if test="${p.endPage >= p.totalPage}">
                            <li class="disable">&gt;</li>
                        </c:if>
                    </ol>
                    <input type="button" value="댓글" onclick="javascript:location.href=''">
                </div>
            </div>

        </div>

      <div id="suggest_list" class="listArea">
        <a href="Controller">건의사항</a>

      </div>
    </div>

<c:import url="/common/footer.jsp" />
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script>
    function movePage(nPage) {

        $.ajax({
            url:"Controller?type=mypost",
            type:"POST",
            data:{nPage:nPage , totalCount:${requestScope.page.totalCount}}
        }).done(function (res) {
            console.log(${requestScope.page.totalCount})
            $("#mypost").html(res);
        })
    }
</script>
</body>
</html>
