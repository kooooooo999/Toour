<%--

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
      &lt;%&ndash;내 정보&ndash;%&gt;
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
--%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="ko">
<head>
    <title>Title</title>
    <link rel="stylesheet" href="<c:url value="/css/header.css" />">
    <link rel="stylesheet" href="<c:url value="/css/footer.css" />">
    <link rel="stylesheet" href="<c:url value="/css/post.css" />">
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #f8f9fa; /* 배경색 추가 */
        }

        .main-container {
            display: flex;
            max-width: 1600px; /* 전체 컨테이너 너비 확장 */
            margin: 20px auto;
            gap: 30px; /* 섹션 간 간격 확장 */
        }

        .left-info-area {
            flex-basis: 350px; /* 왼쪽 내 정보 섹션 너비 확장 */
            padding: 25px;
            background-color: #fff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            height: fit-content;
        }

        .left-info-area h2 {
            font-size: 1.8em;
            color: #1e40af;
            margin-bottom: 15px;
        }

        .left-info-area p {
            margin-bottom: 8px;
            font-size: 1.2em;
        }

        .left-info-area a {
            display: inline-block;
            margin-top: 15px;
            padding: 10px 20px;
            background-color: #1e40af;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .left-info-area a:hover {
            background-color: #1a328a;
        }

        .right-content-area {
            flex-grow: 1; /* 오른쪽 컨텐츠 영역이 남은 공간을 모두 차지 */
            max-width: 1220px; /* 1600px - 350px - 30px(gap) */
        }

        .grid-container {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 25px; /* 그리드 간 간격 확장 */
        }

        .listArea {
            border: 0.5px solid #1e40af;
            background-color: #EFF7FF;
            overflow: hidden;
            border-radius: 8px;
        }

        .listArea > a {
            display: block;
            padding: 15px; /* 헤더 패딩 확장 */
            background-color: #d0e2f9;
            color: #1e40af;
            text-align: center;
            font-weight: bold;
            font-size: 1.1em; /* 헤더 폰트 사이즈 확장 */
            text-decoration: none;
        }

        .item-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            padding: 15px;
            gap: 15px; /* 아이템 간 간격 확장 */
        }

        .oneDiv {
            height: 220px; /* 아이템 높이 확장 */
            overflow: hidden;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #fff;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .oneDiv > a {
            display: block;
            padding: 8px;
            text-align: center;
            font-size: 1em; /* 아이템 타이틀 폰트 사이즈 확장 */
            font-weight: bold;
            text-decoration: none;
            color: #333;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .imgSize {
            width: 100%;
            height: 140px; /* 이미지 높이 확장 */
            object-fit: cover;
        }

        .overflowHidden {
            padding: 8px;
            font-size: 0.9em; /* 주소 폰트 사이즈 확장 */
            color: #666;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            flex-grow: 1;
            text-align: center;
        }

        .overflowHidden2 {
            padding: 8px;
            font-size: 0.9em; /* 주소 폰트 사이즈 확장 */
            color: #666;
            overflow: hidden;
            flex-grow: 1;
            text-align: center;
        }

        #post_list .listArea > div {
            padding: 15px;
        }

        #post {
            background-color: #fff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            overflow-x: auto;
            margin-bottom: 15px;
        }

        #post table {
            width: 100%;
            border-collapse: collapse;
            text-align: center;
            min-width: 700px; /* 테이블 최소 너비 확장 */
            font-size: 1em; /* 테이블 폰트 사이즈 확장 */
        }

        #post th, #post td {
            padding: 12px; /* 테이블 셀 패딩 확장 */
            border-bottom: 1px solid #f2f2f2;
        }

        #post th {
            background-color: #f8f9fa;
            font-weight: bold;
        }

        .search-area {
            padding: 15px;
            background-color: #f8f9fa;
            border-bottom: 1px solid #dee2e6;
            border-radius: 8px 8px 0 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        #search-area select, #search-area input[type="text"] {
            padding: 10px; /* 검색 입력창 패딩 확장 */
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1em; /* 폰트 사이즈 확장 */
        }

        #search-area .search-btn {
            padding: 10px 15px; /* 검색 버튼 패딩 확장 */
            border: none;
            background-color: #1e40af;
            color: white;
            border-radius: 4px;
            cursor: pointer;
        }

        .paging-area {
            margin-top: 15px;
            text-align: center;
        }

        .paging {
            list-style: none;
            padding: 0;
        }

        .paging li {
            display: inline-block;
            margin: 0 6px;
        }

        .paging li a, .paging li.disable {
            display: block;
            padding: 8px 12px; /* 페이징 버튼 패딩 확장 */
            border: 1px solid #ccc;
            background-color: #fff;
            text-decoration: none;
            border-radius: 4px;
            color: #333;
        }

        .paging li.now {
            background-color: #1e40af;
            color: white;
            border-color: #1e40af;
            font-weight: bold;
        }

        .paging li a:hover {
            background-color: #eee;
        }

        .paging li.disable {
            color: #999;
            border-color: #eee;
            cursor: default;
        }

        .paging-area .comment-btn {
            padding: 10px 15px; /* 댓글 버튼 패딩 확장 */
            border: none;
            background-color: #1e40af;
            color: white;
            border-radius: 4px;
            cursor: pointer;
            margin-left: 15px;
        }
    </style>


</head>
<body>
<c:import url="/common/header.jsp" />

<div class="main-container">
    <%-- 내 정보 섹션 --%>
    <div class="left-info-area">
        <h2>내 정보</h2>
        <p><strong><c:out value="${sessionScope.member.member_nickname}" /></strong>님, 환영합니다.</p>

        <a href="#">개인정보 수정</a>
    </div>

    <%-- 오른쪽 컨텐츠 (2x2 그리드) --%>
    <div class="right-content-area">
        <div class="grid-container">
            <div id="zzim_list" class="listArea">
                <a href="Controller">찜 목록</a>
                <div class="item-grid">
                    <c:forEach var="dataVO" items="${requestScope.tour_ar}" varStatus="vs">
                        <c:if test="${vs.index < 4}">
                            <div class="oneDiv">
                                <a href="#">${dataVO.title}</a>
                                <img src="${dataVO.firstimage}" class="imgSize" alt="${dataVO.title}">
                                <p class="overflowHidden">${dataVO.addr1}</p>
                            </div>
                        </c:if>
                    </c:forEach>
                    <c:forEach begin="${fn:length(requestScope.tour_ar) + 1}" end="4">
                        <div class="oneDiv" style="background-color: #f9f9f9; display: flex; align-items: center; justify-content: center; color: #ccc; font-size: 0.9em;">
                            미리보기
                        </div>
                    </c:forEach>
                </div>
            </div>

            <div id="course_list" class="listArea">
                <a href="Controller">내 코스 목록</a>
                <div class="item-grid">
                    <c:forEach var="courseVO" items="${requestScope.course_ar}" varStatus="vs">
                        <c:if test="${vs.index < 4}">
                            <div class="oneDiv">
                                <a href="#">${courseVO.course_name}</a>
                                <p class="overflowHidden2">${courseVO.course_summary}</p>
                            </div>
                        </c:if>
                    </c:forEach>
                    <c:forEach begin="${fn:length(requestScope.course_ar) + 1}" end="4">
                        <div class="oneDiv" style="background-color: #f9f9f9; display: flex; align-items: center; justify-content: center; color: #ccc; font-size: 0.9em;">
                            미리보기
                        </div>
                    </c:forEach>
                </div>
            </div>

            <div id="post_list" class="listArea">
                <a href="Controller">내 게시글/ 댓글</a>
                <div id="mypost">
                    <div id="post">
                        <div id="search-area">
                            <form method="post" action="Controller?type=postSearch">
                                <input type="hidden" name="category_idx" value="2">
                                <select id="searchType" name="searchType">
                                    <option value="post_title">제목</option>
                                    <option value="post_content">내용</option>
                                </select>
                                <input type="text" id="searchValue" placeholder="검색내용을 입력해주세요" name="searchValue"/>
                                <button type="button" class="search-btn" id="search-btn" onclick="mysearch()">검색</button>
                            </form>
                        </div>
                        <table summary="검색결과 목록">
                            <caption>검색결과 목록</caption>
                            <thead>
                            <tr>
                                <th>번호</th>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>별점</th>
                                <th>조회수</th>
                                <th>작성일</th>
                            </tr>
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
                            <c:if test="${empty requestScope.myPost_ar}">
                                <tr><td colspan="6">작성한 게시글이 없습니다.</td></tr>
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
                        <input type="button" value="댓글" class="comment-btn" onclick="javascript:location.href=''">
                    </div>
                </div>
            </div>

            <div id="suggest_list" class="listArea">
                <a href="Controller">건의사항</a>
                <div style="padding: 20px; text-align: center;">
                    건의사항 관련 내용이 들어갈 자리입니다.
                </div>
            </div>
        </div>
    </div>
</div>

<c:import url="/common/footer.jsp" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script>

    function mysearch(){
        let searchType = $("#searchType").val().trim();
        let searchValue = $("#searchValue").val().trim();
            $.ajax({
              url:"Controller?type=mypostsearch",
              type:"POST",
              data:{searchType:searchType, searchValue:searchValue}
            }).done(function (res) {
                $("#mypost").html(res);
            });
    }

    function moveSearchPage(cPage) {

        $.ajax({
            url:"Controller?type=mypostsearch",
            type:"POST",
            data:{cPage:cPage}
        }).done(function (res) {
            $("#mypost").html(res);
        });
    }


    function movePage(nPage) {
        $.ajax({
            url:"Controller?type=mypost",
            type:"POST",
            data:{nPage:nPage , totalCount:${requestScope.page.totalCount}}
        }).done(function (res) {
            $("#mypost").html(res);
        })
    }
</script>
</body>
</html>