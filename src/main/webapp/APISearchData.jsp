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


<div id="main">
  <c:forEach var="Dvo" items="${requestScope.dataAr}" varStatus="count">
    <c:if test="${count.index < 5}">
      <div class="item">
        <c:if test="${fn:length(Dvo.firstimage)>0 and fn:length(Dvo.title)>0 and
          fn:length(Dvo.addr2)>0 and fn:length(Dvo.overview)>0 and Dvo.contenttypeid != 25}">
          <img src="${Dvo.firstimage}" class="image" onclick="selectImage(this)">
          <div class="text ellipsis">
            <p class="title"><a href="#">${Dvo.title}</a></p>
            <p class="addr1"><a href="#">[${Dvo.addr1}]</a></p>
            <p class="overview"><a href="#">${Dvo.overview}</a></p>
          </div>
        </c:if>

        <c:if test="${fn:length(Dvo.firstimage)>0 and fn:length(Dvo.title)>0 and
          fn:length(Dvo.addr2)>0 and fn:length(Dvo.overview)>0 and Dvo.contenttypeid == 25}">
          <img src="${Dvo.firstimage}" class="image" onclick="selectImage(this)">
          <div class="text ellipsis">
            <p class="title"><a href="#">${Dvo.title}</a></p>
            <p class="overview"><a href="#">${Dvo.overview}</a></p>
          </div>
        </c:if>

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

      <li><a href="Controller?type=searchKeyword&cPage=${p.nowPage-p.pagePerBlock}">&lt;</a></li>
    </c:if>

    <c:forEach begin="${p.startPage}" end="${p.endPage}" varStatus="vs">
      <c:if test="${p.nowPage == vs.index}">
        <li class="current">${vs.index}</li>
      </c:if>
      <c:if test="${p.nowPage != vs.index}">
        <li><a href="Controller?type=searchKeyword&cPage=${vs.index}">${vs.index}</a></li>
      </c:if>
    </c:forEach>

    <c:if test="${p.endPage < p.totalPage}">

      <li><a href="Controller?type=searchKeyword&cPage=${p.nowPage+p.pagePerBlock}">&gt;</a></li>
    </c:if>
    <c:if test="${p.endPage >= p.totalPage}">
      <li class="disable">&gt;</li>
    </c:if>

  </ol>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script>
  $(function (){
    //contentTypeId = 12 관광지 로 기본선택 되어있기
    $("#areaCode").blur(function () {

      let areaCode = $("#areaCode").val();
      if(areaCode!=0) {
        $.ajax({
          url: "Controller?type=area",
          method: "POST",
          data: {areaCode: areaCode}
        }).done(function (res) {
          $("#sigunguCode").html(res);
        });
      }
    });

    $("#cat1").blur(function (){
      let cat1 = $("#cat1").val();
      if(cat1!= 0) {
        $.ajax({
          url: "Controller?type=area",
          method: "POST",
          data: {cat1: cat1}
        }).done(function (res) {
          $("#cat2").html(res);
          $("#cat3").html("<option value='0'>::선택하시오::</option>");

        });
      }
    });

    $("#cat2").blur(function (){
      let cat1 = $("#cat1").val();
      let cat2 = $("#cat2").val();
      if(cat2!=0 && cat3!=0) {
        $.ajax({
          url: "Controller?type=area",
          method: "POST",
          data: {cat1: cat1,cat2: cat2}
        }).done(function (res) {
          $("#cat3").html(res);
        });
      }
    });
  });

  $(".contentTypeId").on("click",function (value){
    value.preventDefault();
    let contentTypeId = $(this).data("value");
    let areaCode = $("#areaCode").val();
    let sigunguCode = $("#sigunguCode").val();
    let cat1 = $("#cat1").val();
    let cat2 = $("#cat2").val();
    let cat3 = $("#cat3").val();

    $.ajax({
      url: "Controller?type=searchKeyword",
      method: "POST",
      data: {contentTypeId: contentTypeId , areaCode: areaCode , sigunguCode:sigunguCode,
        cat1:cat1, cat2:cat2, cat3:cat3 /*, cPage:cPage */}
    }).done(function (res){
      $("#main").html(res);
    });

    $.ajax({
      url: "Controller?type=area",
      method: "POST",
      data: {contentTypeId: contentTypeId}
    }).done(function (res){
      $("#cat1").html(res);
      $("#cat2").html("<option value='0'>::선택하시오::</option>");
      $("#cat3").html("<option value='0'>::선택하시오::</option>");
    });

  });

</script>

</body>
</html>