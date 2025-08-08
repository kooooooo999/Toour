<%--
  Created by IntelliJ IDEA.
  User: 쌍용교육센터
  Date: 25. 8. 8.
  Time: 오전 11:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:if test="${requestScope.resultAr != null}">
<h3>검색 결과</h3>
<c:forEach items="${requestScope.resultAr}" var="vo">
  <%-- 주소 있는 결과들만 검색창에 표현 --%>
  <c:if test="${fn:length(vo.addr1) > 0 }">
    <c:if test="${vo.mapy ne '19.6944274800'}">
      <a href="">
      <div id="places_list">
        <div>
          <p style="font-weight: bold;">${vo.title}</p>
          <p style="display: block; font-weight: bold; font-size: 10px; color: #6c757d">${vo.addr1}</p>
        </div>
      </div>
        <hr style="margin-top: 10px;" color="#eee" size="1px" width="100%"/>
      </a>
    </c:if>
  </c:if>
</c:forEach>


  <script>



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
</c:if>


  </script>
