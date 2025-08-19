<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Date" %>
<%@ page import="toour.tripsuggestion.vo.DataVO" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>

<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>👋🏻toour</title>
  <link rel="stylesheet" href="<c:url value="/css/header.css" />">
  <link rel="stylesheet" href="<c:url value="/css/footer.css" />">
  <link rel="stylesheet" href="<c:url value="/css/style.css" />">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

  <style>
    .overview {
      width: 650px;
      height: 45px;
      overflow: hidden;
      display: -webkit-box;
      -webkit-line-clamp: 2; /* 최대 5줄까지 표시 */
      -webkit-box-orient: vertical; /* 텍스트를 세로로 쌓기 */
      text-overflow: ellipsis; /* 넘치는 텍스트에 ... 표시 */
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

    #heartImage > p > i {
      color: #f00;
    }

    /* 이미지를 감싸는 부모 컨테이너 */
    .image-container {
      width: 500px;
      height: 250px;
      position: relative; /* 자식 요소의 위치 기준이 됨 */
    }

    /* 이미지 스타일 (이미지가 있을 때) */
    .image-container .image {
      width: 100%;
      height: 100%;
      object-fit: cover; /* 이미지가 컨테이너를 꽉 채우도록 설정 */
    }

    /* 이미지가 없을 때의 텍스트 스타일 */
    .image-container .emptyText {
      width: 100%;
      height: 100%;
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

<c:import url="/common/header.jsp"/>


<%--바디 영역--%>

<h2 class="tag">#나의 찜 목록</h2>

<%--<i class="fa-solid fa-heart"></i>  꽉찬 하트--%>
<div id="main">
  <c:forEach var="Dvo" items="${requestScope.dataAr}" varStatus="count">
    <c:if test="${Dvo ne null}">
      <div class="image-container">
        <c:if test="${empty Dvo.firstimage}">
          <div class="emptyText">
            [이미지없음]
          </div>
        </c:if>
        <c:if test="${not empty Dvo.firstimage}">
          <img src="${Dvo.firstimage}" class="image">
        </c:if>
      </div>
      <div class="text ellipsis item">
        <p class="title"><a href="#" class="data-link" data-title="${Dvo.title}" data-addr1="${Dvo.addr1}"
                            data-overview="${Dvo.overview}" data-firstimage="${Dvo.firstimage}"
                            data-mapx="${Dvo.mapx}" data-mapy="${Dvo.mapy}" data-contentid="${Dvo.contentId}"
                            data-homepageurl="${Dvo.homepageUrl}"
                            data-homepagetext="${Dvo.homepageText}">${Dvo.title}</a></p>
        <p class="addr1"><a href="#" class="data-link" data-title="${Dvo.title}" data-addr1="${Dvo.addr1}"
                            data-overview="${Dvo.overview}" data-firstimage="${Dvo.firstimage}"
                            data-mapx="${Dvo.mapx}" data-mapy="${Dvo.mapy}" data-contentid="${Dvo.contentId}"
                            data-homepageurl="${Dvo.homepageUrl}"
                            data-homepagetext="${Dvo.homepageText}">${Dvo.addr1}</a></p>
        <p class="overview"><a href="#" class="data-link" data-title="${Dvo.title}" data-addr1="${Dvo.addr1}"
                               data-overview="${Dvo.overview}" data-firstimage="${Dvo.firstimage}"
                               data-mapx="${Dvo.mapx}" data-mapy="${Dvo.mapy}" data-contentid="${Dvo.contentId}"
                               data-homepageurl="${Dvo.homepageUrl}"
                               data-homepagetext="${Dvo.homepageText}">${Dvo.overview}</a></p>
      </div>
    </c:if>
  </c:forEach>
</div>

<div id="page">
  <ol class="paging">
    <c:set var="p" value="${requestScope.page}" scope="page"/>
    <c:if test="${p.startPage < p.pagePerBlock}">
      <li class="disable">&lt;</li>
    </c:if>

    <c:if test="${p.startPage >= p.pagePerBlock}">
      <li>
        <a href="javascript:moveBigPage(${p.nowPage-p.pagePerBlock}),movePage(${p.nowPage-p.pagePerBlock})">&lt;</a>
      </li>
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
      <li><a href="javascript:moveBigPage(${p.nowPage+p.pagePerBlock}) , movePage(${p.nowPage+p.pagePerBlock})">&gt;</a>
      </li>
    </c:if>

    <c:if test="${p.endPage >= p.totalPage}">
      <li class="disable">&gt;</li>
    </c:if>
  </ol>
</div>

<c:import url="/common/footer.jsp"/>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script>

  function movePage(npage) {
    document.location.href = "Controller?type=myZzimlist&nPage=" + npage;
  }

  function moveBigPage(npage) {
    let totalCount =<c:out value="${p.totalCount}" default="10"/>;
    console.log(totalCount);
    $.ajax({
      url: "Controller?type=tripPaging",
      method: "POST",
      data: {cPage: npage, totalCount: totalCount}
    }).done(function (res) {
      $("#page").html(res);
    });
  }

  $("#searchBt").on("click", function () {

    document.frm.action = "Controller?type=tripSuggestion&pageType=trip";
    document.frm.submit();
    /*
              $.ajax({
                  url: "Controller?type=tripSuggestion",
                  method: "POST",
                  data: {contentTypeId: contentTypeId , areaCode: areaCode , sigunguCode:sigunguCode,
                      cat1:cat1, cat2:cat2, cat3:cat3, cPage:1}
              }).done(function (res){
                    $("#main").html(res);
              });*/

  });

  $(document).ready(function () { //보안을 위해 거쳐서 이동
    $(document).on('click', '.data-link', function (e) {
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
      submitData(title, addr1, overview, firstimage, mapx, mapy, contentTypeId, contentId, homepageUrl, homepageText);
    });
  });

  function submitData(title, addr1, overview, firstimage, mapx, mapy, contentTypeId, contentId, homepageUrl, homepageText) {
    console.log(contentId);
    let form = document.createElement('form');
    form.method = 'POST';
    form.action = 'Controller?type=tripDetails';

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

    document.body.appendChild(form);

    form.submit();
  }

</script>

</body>
</html>