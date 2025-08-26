<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="myCourse" value="${requestScope.myCourse}"/>
<c:if test="${fn:length(requestScope.resultAr) > 0}">
  <input type="hidden" id="courseDate_idx" value="${requestScope.courseDate_idx}"/>
  <h3>검색 결과</h3>
  <c:forEach items="${requestScope.resultAr}" var="vo" varStatus="vs">
    <%-- 주소 있는 결과들만 검색창에 표현 --%>
    <c:if test="${fn:length(vo.addr1) > 0 }">
      <c:if test="${vo.mapy ne '19.6944274800'}">
        <div id="places_list">
          <button type="button" class="plusButton" onclick="addList('${vo.title}',${vs.index}, ${myCourse})"></button>
          <div style="display: inline-block;">
            <p class="ellip" style="display: inline-block;">${vo.title}</p>
            <p class="ellip" style="display: block; font-weight: bold; font-size: 10px; color: #6c757d">${vo.addr1}</p>
          </div>
        </div>
          <c:if test="${fn:length(requestScope.resultAr) != (vs.index+1)}">
            <hr style="margin-top: 13px;" color="#eee" size="1px" width="100%"/>
          </c:if>
      </c:if>
    </c:if>
  </c:forEach>




  <%--  페이징 넣는 코드 --%>
  <div id="page" class="paging-area">
    <ol class="paging">
      <c:set var="p" value="${requestScope.mapPage}" />
      <c:if test="${p.startPage < p.pagePerBlock}">
        <li class="disable">&lt;</li>
      </c:if>
      <c:if test="${p.startPage >= p.pagePerBlock}">
        <li><a href="javascript:paging(${p.startPage-p.pagePerBlock})">&lt;</a></li>
      </c:if>
      <c:forEach begin="${p.startPage}" end="${p.endPage}" varStatus="vs">
        <c:if test="${p.nowPage == vs.index}">
          <li class="now">${vs.index}</li>
        </c:if>
        <c:if test="${p.nowPage != vs.index}">
          <li><a href="javascript:paging(${vs.index})">${vs.index}</a></li>
        </c:if>
      </c:forEach>
      <c:if test="${p.endPage < p.totalPage}">
        <li><a href="javascript:paging(${p.endPage+1})">&gt;</a></li>
      </c:if>
      <c:if test="${p.endPage >= p.totalPage}">
        <li class="disable">&gt;</li>
      </c:if>
    </ol>
  </div>

  <script>
    $(function () {


    });

    // 좌표값 저장할 배열
    var points = [];

    // 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성
    var bounds = new kakao.maps.LatLngBounds();

    <c:forEach items="${requestScope.resultAr}" var="vo">
      <%-- 주소 있는 결과들만 지도에 표현 --%>
      <c:if test="${fn:length(vo.addr1) > 0 }">
        <c:if test="${vo.mapy ne '19.6944274800'}">
          var point = new kakao.maps.LatLng(${vo.mapy}, ${vo.mapx})
        console.log(${vo.mapy})
          points.push(point);
        </c:if>
      </c:if>
    </c:forEach>

    // 버튼을 클릭하면 아래 배열의 좌표들이 모두 보이게 지도 범위를 재설정
    var i, marker;
    for (i = 0; i < points.length; i++) {
      // 배열의 좌표들이 잘 보이게 마커를 지도에 추가합니다
      marker = new kakao.maps.Marker({ position : points[i] });
      marker.setMap(map);
      markers.push(marker);

      // LatLngBounds 객체에 좌표를 추가합니다
      bounds.extend(points[i]);
    }
    // 지도 범위 재설정
    map.setBounds(bounds);

  </script>
</c:if>
