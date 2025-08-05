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
    <title>대한민국 구석구석 - 한국관광공사</title>
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
      </style>

  </head>
  <body>

  <c:import url="/common/header.jsp" />


  <%--바디 영역--%>

  <h2 class="tag">#테마를 선택</h2>

  <div id="content_check">
      <a href="#" class="contentTypeId" data-value="12">관광지</a>
      <a href="#" class="contentTypeId" data-value="14">문화시설</a>
      <a href="#" class="contentTypeId" data-value="15">축제공연/행사</a>
      <a href="#" class="contentTypeId" data-value="25">여행코스</a>
      <a href="#" class="contentTypeId" data-value="28">레포츠</a>
      <a href="#" class="contentTypeId" data-value="32">숙박</a>
      <a href="#" class="contentTypeId" data-value="38">쇼핑</a>
      <a href="#" class="contentTypeId" data-value="39">음식점</a>
  </div>

  <div id="main">
    <c:forEach var="Dvo" items="${requestScope.ar}" varStatus="count">
      <c:if test="${count.index < 5}">
      <div class="item">
        <img src="${Dvo.firstimage}" class="image" onclick="selectImage(this)">
            <div class="text ellipsis">
       <p class="title"><a href="#">${Dvo.title}</a></p>
        <p class="addr1"><a href="#">[${Dvo.addr1}]</a></p>
        <p class="overview"><a href="#">${Dvo.overview}</a></p>
            </div>
      </div>
      </c:if>
    </c:forEach>
  </div>

  <div id="page">
        <a href="#" class="on"id="1">1</a>
        <a href="#" class="on"id="2">2</a>
        <a href="#" class="on"id="3">3</a>
        <a href="#" class="on"id="4">4</a>
        <a href="#" class="on"id="5">5</a>
  </div>

  <c:import url="/common/footer.jsp" />

  <script src="https://code.jquery.com/jquery-3.7.1.min.js"
          integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
  <script>
      $(function (){
      //contentTypeId = 12 관광지 로 기본선택 되어있기
      });

      $(".contentTypeId").on("click",function (value){
          value.preventDefault();
          var contentTypeId = $(this).data("value");

          $.ajax({
              url: "Controller?type=tripSuggestion",
              method: "POST",
              data: {contentTypeId: contentTypeId}
          }).done(function (res){
                $("#main").html(res);
          });
      });


    function selectImage(selectedImg) {
      let images = document.querySelectorAll('.images img');
      images.forEach(function(img) {
        img.classList.remove('selected');
        img.classList.add('deselected');
      });

      selectedImg.classList.remove('deselected');
      selectedImg.classList.add('selected');
    }

  </script>

  </body>
  </html>