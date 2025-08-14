<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
  <title>👋🏻toour</title>
  <link rel="stylesheet" href="<c:url value="/css/header.css" />">
  <link rel="stylesheet" href="<c:url value="/css/footer.css" />">
  <link rel="stylesheet" href="<c:url value="/css/style.css" />">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<style>
  .courseGrid {
    /* 이미지들을 담는 부모 컨테이너 */
    display: grid; /* Grid 레이아웃 사용 */
    grid-template-columns: repeat(3, 1fr); /* 3개의 열을 동일한 너비로 설정 */
    grid-auto-rows: 1fr; /* 각 행의 높이를 동일하게 설정 */
    gap: 20px; /* 박스들 간의 간격 */
    width: 100%;
    max-width: 1200px;
    margin: 0 auto; /* 부모 컨테이너를 중앙 정렬 */
    padding: 30px 30px;
  }

  .courseBox {
    /* 각 아이템 박스 */
    width: 350px;
    border: 1px solid #ddd;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
    overflow: hidden; /* 이미지가 박스 밖으로 튀어나가지 않도록 숨김 */
    display: flex;
    flex-direction: column;
  }

  .courseBox img {
    /* 이미지 자체 */
    width: 350px; /* 부모(courseBox)의 너비에 맞춤 */
    height: 250px; /* 높이를 고정값으로 설정 */
    object-fit: cover; /* 이미지를 잘라서 박스에 꽉 채움 */
    object-position: center; /* 이미지를 중앙을 기준으로 잘라냄 */
  }

  /* 마우스를 올렸을 때 적용될 스타일 */
  .courseBox:hover {
    border-color: #007bff; /* 테두리 색상 변경 */
    box-shadow: 0 4px 8px rgba(0, 123, 255, 0.2); /* 그림자 효과 추가 */
    transform: translateY(-5px); /* 박스가 살짝 위로 올라가는 효과 */
  }

  .courseText {
    /* 텍스트 영역 */
    flex-grow: 1; /* 남은 공간을 모두 차지하여 텍스트 영역의 높이도 일정하게 만듦 */
    padding: 15px;
    text-align: center;
  }

  .courseText h4 {
    margin-top: 0;
    margin-bottom: 5px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }

  .courseText p {
    margin-bottom: 0;
    font-size: 14px;
    color: #555;
    /* 텍스트를 한 줄로 표시하고, 넘치는 부분은 ... 으로 표시 */
    white-space: nowrap; /* 텍스트를 강제로 한 줄에 유지 */
    overflow: hidden; /* 넘치는 부분 숨김 */
    text-overflow: ellipsis; /* 넘치는 부분 ... 으로 표시 */
  }


  ol.paging {
    display: flex; /* flexbox로 가로 정렬 */
    padding: 0;
    justify-content: center; /* 가운데 정렬 */
    position: relative;
    top: 5px; /* 위쪽 여백 */
    margin-bottom: 50px; /* 아래쪽 여백 */
  }

  ol.paging li {
    list-style-type: none; /* 기본 번호를 제거 */
    margin-right: 12px; /* 각 항목 간의 간격 */
  }

  ol.paging li a {
    display: block;
    text-decoration: none;
    padding: 10px 20px;
    border: 2px solid #0056b3;
    color: #2f313e;
    font-weight: bold;
    border-radius: 5px;
    background-color: transparent;
    transition: background-color 0.3s, color 0.3s;
  }

  /* hover 시 배경색 변경 */
  ol.paging li a:hover {
    background-color: #0056b3;
    color: white;
  }

  /* 클릭한 항목의 색 변경 */
  ol.paging li a:focus {
    background-color: #0056b3;
    color: white;
    border: 2px solid #0056b3;
  }

  /* 비활성화된 페이지 항목 (현재 페이지) */
  .current {
    background-color: #0056b3;
    color: white;
    pointer-events: none; /* 클릭 불가 */
    border: 2px solid #0056b3; /* 활성화된 페이지는 동일 색 */
    display: block;
    text-decoration: none;
    padding: 10px 20px;
    font-weight: bold;
    border-radius: 5px;
    transition: background-color 0.3s, color 0.3s;
  }

  ol.paging li a.disable {
    background-color: transparent;
    color: silver;
    border: 2px solid silver;
    pointer-events: none; /* 클릭 불가 */
    display: none; /* 요소를 완전히 숨기기 */
  }
  ol.paging li.disable {
    display: none; /* li 태그 자체를 숨김 (a 태그도 포함) */
  }
  .courseImage{
    width: 350px;
    height: 250px;
    background-color: #f0f0f0; /* 배경색 */
    color: #888; /* 텍스트 색상 */
    font-size: 24px;
    font-weight: bold;
    display: flex; /* Flexbox를 사용하여 내부 요소를 정렬 */
    justify-content: center; /* 가로 중앙 정렬 */
    align-items: center; /* 세로 중앙 정렬 */
  }
</style>
</head>
<body>

<c:import url="/common/header.jsp" />
<c:set var="p" value="${requestScope.page}" scope="page"/>
<div class="courseGrid">
  <c:forEach var="Dvo" items="${requestScope.dataAr}" varStatus="count">
    <a href="#" class="data-link" data-title="${Dvo.title}" data-addr1="${Dvo.addr1}" data-overview="${Dvo.overview}" data-firstimage="${Dvo.firstimage}" data-mapx="${Dvo.mapx}" data-mapy="${Dvo.mapy}" data-contentid="${Dvo.contentId}" data-homepageurl="${Dvo.homepageUrl}" data-homepagetext="${Dvo.homepageText}" data-totalcount="${p.totalCount}">
        <div class="courseBox">
          <div class="courseImage">
          <c:if test="${not empty Dvo.firstimage}">
          <img src="${Dvo.firstimage}">
          </c:if>
          <c:if test="${empty Dvo.firstimage}">
          [이미지없음]
          </c:if>
          </div>
          <div class="courseText">
      <h4>${Dvo.title}</h4>
          </div>
        </div>
    </a>
  </c:forEach>
  <input type="hidden" value="25" name="contentTypeId" id="contentTypeId"/>
</div>

<div id="page">
  <ol class="paging">
    <c:if test="${p.startPage < p.pagePerBlock}">
      <li class="disable">&lt;</li>
    </c:if>

    <c:if test="${p.startPage >= p.pagePerBlock}">
      <li><a href="javascript:moveBigPage(${p.nowPage-p.pagePerBlock}),movePage(${p.nowPage-p.pagePerBlock})">&lt;</a></li>
    </c:if>

    <c:forEach begin="${p.startPage}" end="${p.endPage}" varStatus="vs">
      <c:if test="${p.nowPage == vs.index}">
        <li class="current" value="${vs.index}" id="${vs.index}">${vs.index}</li>
      </c:if>

      <c:if test="${p.nowPage != vs.index}">
        <li value="${vs.index}" id="${vs.index}">
          <a href="javascript:movePage(${vs.index})">${vs.index}</a>
        </li>
      </c:if>
    </c:forEach>

    <c:if test="${p.endPage < p.totalPage}">
      <li><a href="javascript:moveBigPage(${p.nowPage+p.pagePerBlock}) , movePage(${p.nowPage+p.pagePerBlock})">&gt;</a></li>
    </c:if>

    <c:if test="${p.endPage >= p.totalPage}">
      <li class="disable">&gt;</li>
    </c:if>
  </ol>
</div>

<c:import url="/common/footer.jsp" />

<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script>

  function movePage(npage) {
    let contentTypeId = $("#contentTypeId").val();
    let currentedPage = $(".current").val();
    $("#"+currentedPage).removeClass('current');
    $("#"+currentedPage).html("<a href='javascript:movePage("+currentedPage+")'>"+currentedPage+"</a>")

    // 사용자가 선택한 페이지에 class로 current를 부여하고 <a> 삭제
    $("#"+npage).addClass('current');
    $("#"+npage).html(npage);

    $.ajax({
      url: "Controller?type=tripSuggestion&pageType=courseUpdate",
      method: "POST",
      data: {contentTypeId: contentTypeId , cPage:npage}
    }).done(function (res){
      $(".courseGrid").html(res);
    });
  }

  function moveBigPage(npage) {
    let totalCount =${p.totalCount};
    $.ajax({
      url: "Controller?type=tripPaging",
      method: "POST",
      data: {cPage:npage, totalCount:totalCount}
    }).done(function (res){
      $("#page").html(res);
    });
  }

  $(document).ready(function() { //보안을 위해 거쳐서 이동
    $(document).on('click', '.data-link', function(e) {
      e.preventDefault(); // a태그 href 링크 이동 방지
      let title = $(this).data('title');
      let addr1 = $(this).data('addr1');
      let overview = $(this).data('overview');
      let firstimage = $(this).data('firstimage');
      let mapx = $(this).data('mapx');
      let mapy = $(this).data('mapy');
      let contentTypeId = $("#contentTypeId").val();
      let contentId = $(this).data('contentid');
      let homepageUrl = $(this).data('homepageurl');
      let homepageText = $(this).data('homepagetext');
      let totalCount = $(this).data('totalcount');
      submitData(title, addr1, overview, firstimage, mapx, mapy, contentTypeId, contentId, homepageUrl,homepageText,totalCount);
    });
  });

  function submitData(title, addr1, overview, firstimage, mapx, mapy, contentTypeId, contentId, homepageUrl,homepageText,totalCount){
    console.log(contentTypeId);
    let form = document.createElement('form');
    form.method = 'POST';
    form.action = 'Controller?type=courseDetails';

    let titleInput = document.createElement('input');
    titleInput.type = 'hidden';
    titleInput.name = 'title';
    titleInput.value = title;

    let addr1Input = document.createElement('input');
    addr1Input.type = 'hidden';
    addr1Input.name = 'addr1';
    addr1Input.value = addr1;

    let overviewInput = document.createElement('input');
    overviewInput.type = 'hidden';
    overviewInput.name = 'overview';
    overviewInput.value = overview;

    let firstimageInput = document.createElement('input');
    firstimageInput.type = 'hidden';
    firstimageInput.name = 'firstimage';
    firstimageInput.value = firstimage;

    let mapxInput = document.createElement('input');
    mapxInput.type = 'hidden';
    mapxInput.name = 'mapx';
    mapxInput.value = mapx;

    let mapyInput = document.createElement('input');
    mapyInput.type = 'hidden';
    mapyInput.name = 'mapy';
    mapyInput.value = mapy;

    let contentTypeIdInput = document.createElement('input');
    contentTypeIdInput.type = 'hidden';
    contentTypeIdInput.name = 'contentTypeId';
    contentTypeIdInput.value = contentTypeId;
    console.log(contentId);

    let contentIdInput = document.createElement('input');
    contentIdInput.type = 'hidden';
    contentIdInput.name = 'contentId';
    contentIdInput.value = contentId;

    let homepageUrlInput = document.createElement('input');
    homepageUrlInput.type = 'hidden';
    homepageUrlInput.name = 'homepageUrl';
    homepageUrlInput.value = homepageUrl;

    let homepageTextInput = document.createElement('input');
    homepageTextInput.type = 'hidden';
    homepageTextInput.name = 'homepageText';
    homepageTextInput.value = homepageText;

    let totalCountInput = document.createElement('input');
    totalCountInput.type = 'hidden';
    totalCountInput.name = 'totalCount';
    totalCountInput.value = totalCount;

    form.appendChild(titleInput);
    form.appendChild(addr1Input);
    form.appendChild(overviewInput);
    form.appendChild(firstimageInput);
    form.appendChild(mapxInput);
    form.appendChild(mapyInput);
    form.appendChild(contentTypeIdInput);
    form.appendChild(contentIdInput);
    form.appendChild(homepageUrlInput);
    form.appendChild(homepageTextInput);
    form.appendChild(totalCountInput);

    document.body.appendChild(form);

    form.submit();
  }

</script>
</body>
</html>
