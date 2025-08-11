<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="toour.tripsuggestion.vo.DataVO" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>

<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>👋🏻toour</title>
  <link rel="stylesheet" href="<c:url value="/css/header.css" />">
  <link rel="stylesheet" href="<c:url value="/css/footer.css" />">


  <style>

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      background-color: #f8f9fa;
      padding: 20px;
    }

    /* 기존 코드를 위한 새로운 스타일 */
    #searchwrap {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 20px;
      margin-bottom: 30px;
      position: relative;
    }

    /* 각 카드를 감싸는 컨테이너 */
    .card-container {
      display: flex;
      flex-direction: column;
      background: white;
      border-radius: 12px;
      box-shadow: 0 2px 12px rgba(0,0,0,0.1);
      overflow: hidden;
      transition: transform 0.2s ease, box-shadow 0.2s ease;
      position: relative;
    }

    .card-container:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 20px rgba(0,0,0,0.15);
    }

    /* 이미지 컨테이너 */
    .image-container {
      position: relative;
      width: 100%;
      height: 200px;
      overflow: hidden;
    }

    .searchImage {
      width: 100%;
      height: 100%;
      object-fit: cover;
      transition: transform 0.3s ease;
    }

    .card-container:hover .searchImage {
      transform: scale(1.05);
    }

    /* 하트 아이콘 */
    #heartImage {
      position: absolute;
      top: 12px;
      right: 12px;
      z-index: 10;
    }

    .heartIcon {
      background: rgba(255,255,255,0.9);
      border-radius: 50%;
      width: 36px;
      height: 36px;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      transition: all 0.2s ease;
    }

    .heartIcon:hover {
      background: rgba(255,255,255,1);
      transform: scale(1.1);
    }

    .heartIcon i {
      color: #ff4757;
      font-size: 16px;
    }

    /* 텍스트 영역 */
    .text {
      padding: 16px;
      flex: 1;
    }

    .searchTitle {
      margin-bottom: 8px;
    }

    .searchTitle a {
      color: #2c3e50;
      text-decoration: none;
      font-size: 16px;
      font-weight: 600;
      line-height: 1.4;
      display: block;
    }

    .searchTitle a:hover {
      color: #3498db;
    }

    .searchAddr1 {
      margin-bottom: 8px;
    }

    .searchAddr1 a {
      color: #7f8c8d;
      text-decoration: none;
      font-size: 14px;
      display: block;
    }

    .searchAddr1 a:hover {
      color: #34495e;
    }

    /* 말줄임 효과 */
    .ellipsis {
      overflow: hidden;
    }

    .ellipsis .searchTitle a {
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
      overflow: hidden;
    }

    /* 빈 데이터 메시지 */
    #nullData {
      text-align: center;
      padding: 40px;
      color: #7f8c8d;
      font-size: 16px;
    }

    /* 페이징 스타일 */
    #page {
      margin-top: 40px;
      display: flex;
      justify-content: center;
    }

    .paging {
      display: flex;
      list-style: none;
      gap: 8px;
    }

    .paging li {
      border-radius: 6px;
      overflow: hidden;
    }

    .paging li a,
    .paging li.current,
    .paging li.disable {
      display: block;
      padding: 10px 14px;
      text-decoration: none;
      color: #495057;
      background: white;
      border: 1px solid #dee2e6;
      transition: all 0.2s ease;
    }

    .paging li a:hover {
      background: #e9ecef;
      color: #212529;
    }

    .paging li.current {
      background: #007bff;
      color: white;
      border-color: #007bff;
    }

    .paging li.disable {
      color: #6c757d;
      background: #e9ecef;
      cursor: not-allowed;
    }

    /* 반응형 디자인 */
    @media (max-width: 768px) {
      #searchwrap {
        grid-template-columns: 1fr;
        gap: 16px;
      }

      body {
        padding: 16px;
      }

      .image-container {
        height: 180px;
      }
    }

    #searchText{display: inline-block;}

    #searchwrap{    box-sizing: border-box;
      word-wrap: break-word !important;
      word-break: keep-all !important;
      display: flex
    ;
      flex-wrap: wrap;
      align-content: space-between;
      border: 1px solid #e6e6e6;
      padding: 20px;
      overflow: hidden;
      margin: 20px 0 0;
      position: relative;
      min-height: 195px;
      min-height: 167px;
      padding: 15px;
      margin: 15px 0 0;
    }
    .searchImage{ width: 300px; height: 200px; display: inline-block}
    .searchTitle{  display: inline-block; font-size: 15px;}
    .searchAddr1{  display: inline-block; font-size: 11px;}
    .overview {
      width: 650px;
      height: 120px;
      overflow: hidden;
      display: -webkit-box;
      -webkit-line-clamp: 5; /* 최대 5줄까지 표시 */
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
  </style>

</head>
<body>

<c:import url="/common/header.jsp" />


<%--바디 영역--%>

  <li>
    <button type="button">검색</button>
  </li>


<div id="searchwrap">
      <c:forEach var="Dvo" items="${requestScope.searchAr}" varStatus="count">
        <div class="card-container">
          <div class="image-container">
        <c:if test="${count.index < 5}">
          <div id="heartImage">
            <p class="heartIcon">
            <i class="fa-solid fa-heart"></i>
            </p>
          </div>
        <span>
          <c:choose>
          <c:when test="${empty Dvo.firstimage}">
            <img src="./images/noImage.png" class="searchImage">
          </c:when>
            <c:otherwise>
              <img src="${Dvo.firstimage}" class="searchImage">
            </c:otherwise>
          </c:choose>
        </span>
          <div class="text ellipsis" id="searchText">
            <p class="searchTitle"><a href="javascript:;" class="data-link" onclick="submitData('${Dvo.title}','${Dvo.addr1}','${Dvo.overview}','${Dvo.firstimage}')">${Dvo.title}</a></p>
            <p class="searchAddr1"><a href="javascript:;" class="data-link" onclick="submitData('${Dvo.title}','${Dvo.addr1}','${Dvo.overview}','${Dvo.firstimage}')">[${Dvo.addr1}]</a></p>
            <%--<p class="overview"><a href="javascript:;" onclick="submitData('${Dvo.title}','${Dvo.addr1}','${Dvo.overview}','${Dvo.firstimage}')">${Dvo.overview}</a></p>--%>
          </div>
        </c:if>
          </div>
        </div>
      </c:forEach>

</div>

<div id="nullData">
  <c:if test="${fn:length(Dvo.title) < 0}">
    <p>등록된 게시글이 없습니다</p>
  </c:if>
</div>

<div id="page">

  <ol class="paging">
    <c:set var="p" value="${requestScope.page}" scope="page"/>
    <c:set var="keyword" value="${requestScope.keyword}" scope="page"/>

    <c:if test="${p.startPage >= p.pagePerBlock}">
      <li><a href="javascript:goToPage(${p.nowPage-p.pagePerBlock})">&lt;</a></li>
    </c:if>

    <c:forEach begin="${p.startPage}" end="${p.endPage}" varStatus="vs">
      <c:if test="${p.nowPage == vs.index}">
        <li class="current">${vs.index}</li>
      </c:if>
      <c:if test="${p.nowPage != vs.index}">
        <li><a href="javascript:goToPage(${vs.index})">${vs.index}</a></li>
      </c:if>
    </c:forEach>

    <c:if test="${p.endPage < p.totalPage}">
      <li><a href="javascript:goToPage(${p.nowPage+p.pagePerBlock})">&gt;</a></li>
    </c:if>


  </ol>
</div>
<c:set var="cPage" scope="page" value="${requestScope.cPage}"/>
<c:import url="/common/footer.jsp" />

<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script>

  function goToPage(pageNum) {
    const keyword = '${param.keyword}';
    const url = 'Controller?type=searchKeyword&cPage=' + pageNum + '&keyword=' + encodeURIComponent(keyword);
    window.location.href = url;
  }

  $(function (){
    //contentTypeId = 12 관광지 로 기본선택 되어있기

  });
let keyword = document.getElementById("keyword");
console.log(keyword);
  $(".contentTypeId").on("click",function (value){
    value.preventDefault();
    let contentTypeId = $(this).data("value");
    let areaCode = $("#areaCode").val();
    let sigunguCode = $("#sigunguCode").val();
    let cat1 = $("#cat1").val();
    let cat2 = $("#cat2").val();
    let cat3 = $("#cat3").val();

    $.ajax({
      url: "Controller?type=searchKeyword="+encodedKeyword,
      method: "POST",
      data: {contentTypeId: contentTypeId , areaCode: areaCode , sigunguCode:sigunguCode,
        cat1:cat1, cat2:cat2, cat3:cat3 /*, cPage:cPage */}
    }).done(function (res){
      $("#searchwrap").html(res);
    });


  });



  $(document).ready(function() { //보안을 위해 거쳐서 이동
    $('.data-link').on('click', function(e) {
      e.preventDefault(); // a태그 href 링크 이동 방지
      let title = $(this).data('title');
      let addr1 = $(this).data('addr1');
      let overview = $(this).data('overview');
      let firstimage = $(this).data('firstimage');
      // let mapx = $(this).data('mapx');
      // let mapy = $(this).data('mapy');
      submitData(title, addr1, overview, firstimage);
    });
  });
  function submitData(title, addr1, overview, firstimage){
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

    form.appendChild(titleInput);
    form.appendChild(addr1Input);
    form.appendChild(overviewInput);
    form.appendChild(firstimageInput);

    document.body.appendChild(form);
    form.submit();
  }
</script>

</body>
</html>