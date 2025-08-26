
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="ko">
<head>
    <title>Title</title>
    <link rel="stylesheet" href="<c:url value="/css/header.css" />">
    <link rel="stylesheet" href="<c:url value="/css/footer.css" />">
    <link rel="stylesheet" href="<c:url value="/css/post.css" />">
    <link rel="stylesheet" href="<c:url value="/css/style.css" />">

    <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #f8f9fa; /* 배경색 추가 */
        }
        /*문의사항 컨테이너*/
        #inquiry-container{
            max-width: 1400px !important;
            margin: 0 auto;
            background-color: #fff;
            border: 1px solid #dee2e6;
            border-radius: 8px !important;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            overflow-x: auto;
            padding: 0 !important;
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
        .inquiry-table {
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
        #inquiry-container th{
            background-color: #f8f9fa;
            font-weight: bold;}

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

        #memberCourse #addCourseTitle{
            min-height: 400px; !important;
        }

        /* === 다이얼로그 전체 박스 === */
        .ui-dialog[aria-describedby="memberCourse"] {
            width: 400px !important;
            max-width: 90% !important;
            height: 100%;
            border-radius: 20px !important;
            overflow: hidden !important;
            border: 0 !important;
            box-shadow: 0 12px 40px rgba(0,0,0,0.25) !important;
            font-family: 'Noto Sans KR', sans-serif;
        }



        /* === 헤더(타이틀바) === */
        .ui-dialog[aria-describedby="memberCourse"] .ui-dialog-titlebar {
            background: linear-gradient(135deg, #2575fc , #99ccff) !important;
            color: #fff !important;
            border: 0 !important;
            padding: 16px 20px !important;
            font-size: 18px !important;
            font-weight: 700 !important;
            border-top-left-radius: 20px !important;
            border-top-right-radius: 20px !important;
        }

        /* === 본문(컨텐츠) === */
        .ui-dialog[aria-describedby="memberCourse"] .ui-dialog-content {
            background: #f9fafc !important;
            padding: 24px !important;
            color: #111 !important;
            font-size: 15px !important;
            line-height: 1.6 !important;
        }

        /* 데이터 카드 스타일 */
        .course-info {
            display: grid;
            gap: 16px;
        }
        .course-info .info-item {
            background: #fff;
            padding: 16px 20px;
            border-radius: 14px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: all 0.25s ease;
        }
        .course-info .info-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }
        .course-info .label {
            font-size: 14px;
            font-weight: 600;
            color: #2563eb;
        }
        .course-info .value {
            font-size: 15px;
            font-weight: 500;
            color: #333;
        }

        /* === 버튼 영역 === */
        .ui-dialog[aria-describedby="memberCourse"] .ui-dialog-buttonpane {
            background: #f9fafc !important;
            border-top: 1px solid #eee !important;
            padding: 16px !important;
            text-align: right !important;
            border-bottom-left-radius: 20px !important;
            border-bottom-right-radius: 20px !important;
        }

        .ui-dialog[aria-describedby="memberCourse"] .ui-dialog-buttonset button {
            background: #2563eb !important;
            border: none !important;
            color: #fff !important;
            font-weight: 600 !important;
            padding: 10px 18px !important;
            border-radius: 10px !important;
            cursor: pointer;
            margin-left: 8px !important;
            transition: background 0.2s ease;
        }
        .ui-dialog[aria-describedby="memberCourse"] .ui-dialog-buttonset button:hover {
            background: #1e40af !important;   /* 딥 블루 */
        }
    </style>


</head>
<body>
<c:set var="mvo" value="${sessionScope.member}"/>
<c:import url="/common/header.jsp" />

<div class="main-container">
    <%-- 내 정보 섹션 --%>
    <div class="left-info-area">
        <h2>내 정보</h2>
        <p><strong><c:out value="${mvo.member_nickname}"/></strong>님, 환영합니다.</p>

        <a href="javascript:changeMyInfo()">개인정보 확인</a>
    </div>

    <%-- 오른쪽 컨텐츠 (2x2 그리드) --%>
    <div class="right-content-area">
        <div class="grid-container">
            <div id="zzim_list" class="listArea">
                <a href="Controller?type=myZzimlist">찜 목록 ${fn:length(requestScope.zzim_ar)}</a>
                <div class="item-grid">
                    <c:forEach var="dataVO" items="${requestScope.tour_ar}" varStatus="vs">
                        <c:if test="${vs.index < 4}">
                            <div class="oneDiv">
                                <c:if test="${dataVO ne null}">
                                    <a href="javascript:goDetail(${vs.index})">${dataVO.title}</a>
                                    <a href="javascript:goDetail(${vs.index})"><img src="${dataVO.firstimage}" class="imgSize" alt="${dataVO.title}"></a>
                                    <p class="overflowHidden">${dataVO.addr1}</p>
                                    <form id="zzim_info${vs.index}" name="zzim_info${vs.index}" action="Controller?type=tripDetails" method="post">
                                        <input type="hidden" name="title" value="${dataVO.title}"/>
                                        <input type="hidden" name="addr1" value="${dataVO.addr1}"/>
                                        <input type="hidden" name="overview" value="${dataVO.overview}"/>
                                        <input type="hidden" name="firstimage" value="${dataVO.firstimage}"/>
                                        <input type="hidden" name="mapx" value="${dataVO.mapx}"/>
                                        <input type="hidden" name="mapy" value="${dataVO.mapy}"/>
                                        <input type="hidden" name="contentTypeId" value="${dataVO.contentTypeId}"/>
                                        <input type="hidden" name="contentId" value="${dataVO.contentId}"/>
                                        <input type="hidden" name="homepageUrl" value="${dataVO.homepageUrl}"/>
                                        <input type="hidden" name="homepageText" value="${dataVO.homepageText}"/>
                                    </form>
                                </c:if>
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
                <a href="javascript:addCourse()">내 코스 목록</a>
                <div class="item-grid">
                    <c:forEach var="courseVO" items="${requestScope.course_ar}" varStatus="vs">
                        <c:if test="${vs.index < 4}">
                            <div class="oneDiv">
                                <a href="javascript:myCourseDate('${courseVO.course_idx}','${courseVO.course_name}')">${courseVO.course_name}</a>
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
                <a href="Controller">내 게시글</a>
                <div id="mypost">
                    <div id="post">
                        <div id="search-area">
                            <input type="hidden" name="category_idx" value="2">
                            <select id="searchType" name="searchType">
                                <option value="post_title">제목</option>
                                <option value="post_content">내용</option>
                            </select>
                            <input type="text" id="searchValue" placeholder="검색내용을 입력해주세요" name="searchValue"/>
                            <button type="button" class="search-btn" id="search-btn" onclick="mysearch()">검색</button>
                        </div>
                        <table summary="검색결과 목록">
                            <caption>검색결과 목록</caption>
                            <thead>
                            <tr>
                                <th>번호</th>
                                <th>제목</th>
                                <th>작성자</th>
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
                    </div>
                </div>
            </div>

            <div id="suggest_list" class="listArea"><c:set var="t" value="${requestScope.QnAtotalCount}"/>

                <a href="Controller?type=QnA">문의사항</a>
                <div id="inquiry-container" style="padding: 20px; text-align: center;">
                    <div class="inquiry_container" >
                        <div class="post-header-container">

                        </div>

                        <!-- 문의 목록 테이블 -->
                        <table class="inquiry-table">
                            <caption>문의 목록 테이블</caption>

                            <thead>
                            <tr>
                                <th width="10%">번호</th>
                                <th width="15%">유형</th>
                                <th width="35%">제목</th>
                                <th width="15%">상태</th>
                                <th width="15%">작성일</th>
                                <th width="10%">관리</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:set var="p2" value="${requestScope.InquiryPage}" />
                            <c:set var="inquiryList" value="${requestScope.myInquiry_ar}"/>
                            <c:choose>
                                <c:when test="${not empty inquiryList and fn:length(inquiryList) > 0}">
                                    <c:forEach items="${inquiryList}" var="ivo" varStatus="vs">
                                        <c:if test="${not empty ivo}">
                                            <c:set var="num2" value="${p2.totalCount -((p2.nowPage-1)*p2.numPerPage+vs.index)}"/>
                                            <tr>
                                                <td>${num2}</td>
                                                <td>${ivo.category}</td>
                                                <td style="text-align: left">
                                                    <a href="Controller?type=inquiryView&inquiry_idx=${ivo.inquiry_idx}&cPage=${p2.nowPage}">
                                                            ${ivo.title}
                                                    </a>
                                                </td>

                                                <td><span class="status-badge status-${ivo.statusColor}">${ivo.status}</span></td>
                                                <td>${ivo.created_at.substring( 0, 10)}</td>
                                                <td>
                                                    <a href="Controller?type=inquiryView&inquiry_idx=${ivo.inquiry_idx}" class="btn btn-primary">보기</a>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </c:when>

                                <c:otherwise>
                                    <tr>
                                        <td colspan="6" class="no-data" style="text-align: center; padding: 50px;">
                                            <div class="no-result">
                                                <c:choose>
                                                    <c:when test="${not empty requestScope.myInquiry_ar}">

                                                    </c:when>
                                                    <c:otherwise> 등록된 문의가 없습니다</c:otherwise>
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
                        <!-- 페이징 -->


                            <div class="paging-area">
                                <ol class="paging">
                                    <!-- 이전 블록 이동 불가 -->
                                    <c:if test="${p2.startPage < p2.pagePerBlock}">
                                        <li class="disable">&lt;</li>
                                    </c:if>

                                    <!-- 이전 블록 이동 -->
                                    <c:if test="${p2.startPage >= p2.pagePerBlock}">
                                        <li><a href="javascript:moveInquiryPage(${p2.startPage - p2.pagePerBlock})">&lt;</a></li>
                                    </c:if>

                                    <!-- 페이지 번호 -->
                                    <c:forEach begin="${p2.startPage}" end="${p2.endPage}" var="i">
                                        <c:if test="${p2.nowPage == i}">
                                            <li class="now">${i}</li>
                                        </c:if>
                                        <c:if test="${p2.nowPage != i}">
                                            <li><a href="javascript:moveInquiryPage(${i})">${i}</a></li>
                                        </c:if>
                                    </c:forEach>

                                    <!-- 다음 블록 이동 -->
                                    <c:if test="${p2.endPage < p2.totalPage}">
                                        <li><a href="javascript:moveInquiryPage(${p2.endPage + 1})">&gt;</a></li>
                                    </c:if>

                                    <!-- 다음 블록 이동 불가 -->
                                    <c:if test="${p2.endPage >= p2.totalPage}">
                                        <li class="disable">&gt;</li>
                                    </c:if>

                                </ol>
                            </div>







                </div>
            </div>
        </div>
    </div>
</div>


<div class="MyInfo-container" id="MyInfo-container">
    <h2>개인정보</h2>
    <form action="Controller?type=myInfo" method="post" name="MyInfo_form">
        <table class="MyInfo-table">
            <caption class="hidden">개인정보 테이블</caption>
            <tbody>
            <c:if test="${sessionScope.member.login_type eq 'LOCAL'}">
            <tr>
                <td>ID:</td>
                <td>
                    <div class="input-group">
                        <div class="input-with-message">
                            <input type="text" id="u_id" name="u_id" class="input-field input-field-full" placeholder="아이디" value="${mvo.member_id}" disabled/>
                            <div id="id_usable" class="validation-message"></div>
                        </div>
                    </div>
                </td>
            </tr>
            <tr id="pw" hidden="hidden">
                <td>PW:</td>
                <td>
                    <div class="input-group">
                        <div class="input-with-message">
                            <input type="password" id="u_pw" name="u_pw" class="input-field input-field-full" placeholder="비밀번호" />
                            <div id="pw_usable" class="validation-message"></div>
                        </div>
                    </div>
                </td>
            </tr>
            <tr id="re-pw" hidden="hidden">
                <td>RE-PW:</td>
                <td>
                    <div class="input-group">
                        <div class="input-with-message">
                            <input type="password" id="u_repw" name="u_repw" class="input-field input-field-full" placeholder="비밀번호 확인"/>
                            <div id="repw_usable" class="validation-message"></div>
                        </div>
                    </div>
                </td>
            </tr>
            </c:if>
            <tr>
                <td>별명:</td>
                <td>
                    <div class="input-group">
                        <div class="input-with-message">
                            <input type="text" id="u_nickname" name="u_nickname" class="input-field input-field-full" placeholder="별명" value="${mvo.member_nickname}" disabled/>
                            <div id="nickname_usable" class="validation-message"></div>
                        </div>
                    </div>
                </td>
            </tr>
            <c:if test="${sessionScope.member.login_type eq 'LOCAL'}">
            <tr>
                <td>이름:</td>
                <td>
                    <input type="text" id="u_name" name="u_name" class="input-field" placeholder="이름" value="${mvo.member_name}" disabled/>
                </td>
            </tr>
            </c:if>
            <tr>
                <td>이메일:</td>
                <td>
                    <div class="input-group">
                        <div class="email-group">
                            <c:set var="emailIndex" value="${fn:indexOf(mvo.member_email, '@')}"/>
                            <c:set var="email1" value="${fn:substring(mvo.member_email,0,emailIndex)}"/>
                            <c:set var="email2" value="${fn:substring(mvo.member_email,emailIndex+1,fn:length(mvo.member_email))}"/>
                            <input type="email" id="u_email" name="u_email" class="input-field" placeholder="이메일" value="${email1}" disabled/>
                            <span class="email-separator">@</span>
                            <input type="email" id="u_email2" name="u_email2" class="input-field" placeholder="직접 입력" value="${email2}" disabled/>
                            <%--<select id="emailAddr" name="emailAddr" class="email-select">
                                <option value="">직접 입력</option>
                                <option value="naver.com" <c:if test="${email2.equals('naver.com')}" > selected</c:if> >naver.com</option>
                                <option value="gmail.com" <c:if test="${email2.equals('gmail.com')}" > selected</c:if> >gmail.com</option>
                                <option value="daum.net" <c:if test="${email2.equals('daum.com')}" > selected</c:if> >daum.net</option>
                                <option value="nate.net" <c:if test="${email2.equals('nate.com')}" > selected</c:if> >nate.net</option>
                            </select>--%>
                        </div>
                    </div>
                </td>
            </tr>
            <tr id="revision_btn">
                <td colspan="2">
                    <button type="button" onclick="goOutMember()" class="">회원 탈퇴</button><button type="button" onclick="goChange()" class="">수정하기</button>
                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>

<div id="matchPassword_dialog">
    <table>
        <tr>
            <td>비밀번호 확인:</td>
            <td>
                <div class="input-group">
                    <div class="input-with-message">
                        <input type="password" id="match_pw" name="match_pw" class="input-field input-field-full" placeholder="비밀번호" />
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan='2'> <button type='button' onClick='matchPW()' className=''>확인</button>
        </tr>
    </table>
</div>

<%-- 여행 추가 --%>
<div id="memberCourse" class="hide" style="position: relative;">
</div>

<form action="Controller?type=GoWay" method="post" name="result_frm">
    <input type="hidden" id="result" name="result" />
    <input type="hidden" id="title" name="title" />
    <input type="hidden" id="course_name" name="course_name" />
</form>




<div id="html-content"></div>
<c:import url="/common/footer.jsp" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<script>
    $(function (){
        let option = {
            modal: true,
            autoOpen: false, /*호출되는 즉시 대화상자 표시(기본값: true)*/
            title: "개인정보",
            resizable: true,
            height:600,
            width:830,
            position: {my: "left top", at: "left top", of: ${'zzim_list'} }
        };
        let option2 = {
            modal: true,
            autoOpen: false, /*호출되는 즉시 대화상자 표시(기본값: true)*/
            title: "비밀번호 확인",
            resizable: true,
            height:200,
            width:400,
            position: {my: "right top", at: "right top", of: ${'zzim_list'} }
        };

        let option3 = {
            modal: true,
            autoOpen: false, /*호출되는 즉시 대화상자 표시(기본값: true)*/
            title: "나의 코스",
            resizable: true,
            height:300,
            width:300,
            position: { my: "right top: ", at: "right top", of: ${'zzim_list'}, offset: "0 100", collision: "none" }
        };
        $("#memberCourse").dialog(option3);

        $("#MyInfo-container").dialog(option);
        $("#matchPassword_dialog").dialog(option2);


        $("#emailAddr").change(function () {
            $("#u_email2").val("");
        })
    });

    //[개인정보 확인] 버튼을 눌렀을 때
    function changeMyInfo() {
        $("#match_pw").val("");
        console.log('${sessionScope.member.login_type}');
        <c:if test="${sessionScope.member.login_type eq 'LOCAL'}">
            $("#matchPassword_dialog").dialog("open");
        </c:if>
        <c:if test="${sessionScope.member.login_type eq 'KAKAO'}">
            $("#MyInfo-container").dialog("open");
        </c:if>
    }

    function mysearch() {
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
    function moveInquiryPage(nPage) {
        $.ajax({
            url: "Controller?type=myinquiry",
            type: "POST",
            data: {nPage: nPage, totalCount: ${requestScope.InquiryPage.totalCount}}
            }).done(function(response) {
                // 여기에 결과 처리 방법을 작성 (예: 특정 영역에 삽입)
                $('#inquiry-container').html(response);
            })
    }


    function goDetail(index) {
        document.forms[index+1].submit();
    }

    //개인정보 확인 dialog에서 [수정하기]를 눌렀을 때
    function goChange(){
        // document.getElementById("u_id").disabled = false;
        document.getElementById("u_nickname").disabled = false;
        // document.getElementById("u_name").disabled = false;
        // document.getElementById("u_email").disabled = false;
        // document.getElementById("u_email2").disabled = false;

        $("#pw").removeAttr("hidden");
        $("#re-pw").removeAttr("hidden");

        $("#revision_btn").html(
            "<td colspan='2'> <button type='button' onClick='saveMyInfo()' className=''>변경</button> <button type='button' onClick='cancelMyInfo()' className=''>취소</button> </td>"
        )

    }

    //개인정보 확인 dialog에서 정보 수정 후 [변경]을 눌렀을 때
    function saveMyInfo() {
        let u_nickname = $("#u_nickname").val();
        console.log("u_nickname:" + u_nickname);
        let pw = $("#u_pw").val();
        let re_pw = $("#u_repw").val();

        let chk =0;
        //비밀번호 검사
        if (pw !=null&&re_pw !=null) {
            if (pw.trim().length < 1 && re_pw.trim().length < 1) {
                //둘 다 입력 안 했을 때
            } else {
                // 둘 중 하나에라도 뭔가 입력했을 때

                //조건 1. 둘 다 입력양식에 만족했는가
                //조건 2. 둘의 값이 동일한가
                if ($("#pw_usable").hasClass("success")) {
                    if ($("#repw_usable").hasClass("success")) {

                    } else {
                        chk = chk + 1;
                    }
                } else {
                    chk = chk + 1;
                }

            }
        }
        //별명 검사
        if ($("#nickname_usable").hasClass("error")) {
            chk=chk+1;
        }

        console.log(chk);
        //여기선 아니고 Action에서 꼭 hash해서 비밀번호를 저장할 수 있도록 하자!
        if (chk == 0){
            console.log("chk==0");
            $.ajax({
                url: "Controller?type=myInfo",
                type: "post",
                data: {u_pw: pw, u_nickname: u_nickname}
            })
            $("#MyInfo-container").dialog("close");
            document.location.href ="Controller?type=mypage"
        }
        else
            alert("입력 양식을 모두 충족해주세요.")


    }

    //개인정보 확인 dialog에서 정보 수정 도중 [취소] 버튼을 눌렀을 때
    function cancelMyInfo() {
        $("#MyInfo-container").dialog("close");
    }



    // 비밀번호 확인 창에서 [확인] 버튼을 눌렀을 때
    function matchPW() {
        let u_pw = $("#match_pw").val().trim();
        
        if(u_pw==""||u_pw.length<1)
            alert("비밀번호를 입력해주세요")
        else {
            $.ajax({
                url:"Controller?type=matchpw",
                data:{u_pw:u_pw},
                type:"POST"
            }).done(function (res){
                console.log(res);
               if(res.trim()=="<p>true</p>"){
                   document.getElementById("u_id").disabled = true;
                   document.getElementById("u_nickname").disabled = true;
                   document.getElementById("u_name").disabled = true;
                   document.getElementById("u_email").disabled = true;
                   document.getElementById("u_email2").disabled = true;

                   //[수정하기] 버튼을 눌렀다가 다시 [개인정보 확인] 버튼을 눌렀을 때 초기화 용도
                   $("#pw").attr("hidden",true);
                   $("#re-pw").attr("hidden",true);
                   $("#revision_btn").html(
                       "<td colspan='2'> <button type='button' onClick='goOutMember()' className=''>회원 탈퇴</button><button type='button' onclick='goChange()' class=''>수정하기</button> </td>"
                   )

                   $("#matchPassword_dialog").dialog("close");
                   $("#MyInfo-container").dialog("open");
               }else
                   alert("비밀번호가 틀렸습니다.")
            });
        }
        
    }

    $("#u_pw").keyup(function (){
        const u_pw_t = $(this).val().trim();
        if (u_pw_t.length > 0) {
            $.ajax({
                url: "Controller?type=chkpw",
                type: "post",
                data:{ u_pw: u_pw_t }
            }).done(function (res) {
                updateValidationMessage("#pw_usable", res);
            });
        } else {
            $("#pw_usable").html("");
        }
        // 비밀번호 확인 필드도 같이 검사
        $("#u_repw").trigger('keyup');
    });

    // 비밀번호 확인(확인번호)에 타이핑을 쳤을 때
    $("#u_repw").keyup(function (){
        const u_pw_v = $("#u_pw").val().trim();
        const u_repw_v = $(this).val().trim();

        const $repw_usable = $("#repw_usable");
        $repw_usable.removeClass('success error');

        if (u_pw_v.length > 0 && u_repw_v.length > 0) {
            if (u_pw_v === u_repw_v) {
                $repw_usable.addClass('success').text("비밀번호가 일치합니다.");
            } else {
                $repw_usable.addClass('error').html("비밀번호와 동일하게 입력해주세요.<input type='hidden' class='disable_check'>");
            }
        } else {
            $repw_usable.html("");
        }
    });


    // 별명 창에 타이핑을 쳤을 때
    $("#u_nickname").keyup(function (){
        const u_nickname_t = $(this).val().trim();
        if (u_nickname_t.length > 0) {
            $.ajax({
                url: "Controller?type=chknickname",
                type: "post",
                data:{ u_nickname: u_nickname_t }
            }).done(function (res) {
                updateValidationMessage("#nickname_usable", res);
                if(u_nickname_t == "${sessionScope.member.member_nickname}"){
                    $("#nickname_usable").removeClass("success error");
                    $("#nickname_usable").addClass("success").html("");
                }
            });
        } else {
            $("#nickname_usable").html("");
        }
    });

    function updateValidationMessage(targetId, res) {
        const $target = $(targetId);
        $target.removeClass('success error');
        if (res.includes("가능")) {
            $target.addClass('success').html(res);
        } else if (res.length > 0) {
            $target.addClass('error').html(res + "<input type='hidden' class='disable_check'>");
        } else {
            $target.html('');
        }
    }

    //코스 관리
    function addCourse() {

        <%-- 1일 때는 '내코스', 2일 때는 '코스 추가' 눌렀을 때 --%>

        $.ajax({
            url: "Controller?type=searchCourse",
            method: "post",
            data: { number: '1' }
        }).done(function (res) {
            console.log(res);
            $("#memberCourse").html(res);
        });
        $("#memberCourse").dialog("open");
    }

    function myCourseDate(course_idx, course_name) {
        $.ajax({
            url: "Controller?type=searchCourseDate",
            method: "post",
            data: { course_idx: course_idx, num: 1 , course_name:course_name}
        }).done(function (res) {
            console.log(res);
            $("#memberCourse").html(res);
            $("#memberCourse").dialog("open");
        })
    }



    // 내 코스 지도 코스 리스트에 띄우기
    function showCourseList(courseDate_idx, title, course_name) {

        $("#course_name").val(course_name);
        $("#title").val(title);
        $.ajax({
            url: "Controller?type=myCourseDay",
            type: "post",
            data: { courseDate_idx: courseDate_idx}
        }).done(function (res) {
            console.log("res:" + res);
            $("#html-content").html(res);
            prepareAndSubmit();
        })
        $("#memberCourse").dialog("close");

    }

    function prepareAndSubmit() {
        // 1. 전송할 HTML 내용을 가져옵니다.
        var htmlContent = document.getElementById("html-content").innerHTML;
        console.log("htmlContent:" + htmlContent);
        // 2. 숨겨진 input의 value에 내용을 넣어줍니다.
        document.getElementById("result").value = htmlContent;

        // 3. 폼을 제출합니다.
        document.result_frm.submit();
    }

    function goOutMember() {
        document.location.href = "Controller?type=delMember";
    }
</script>
</body>
</html>