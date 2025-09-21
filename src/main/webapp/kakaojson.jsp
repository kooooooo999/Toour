<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
    console.log(${requestScope.result})
    var linePath = [];
    var points = [];

    <c:forEach var="vertex" begin="0" end="${fn:length(requestScope.vertex_x)-1}" varStatus="vs">
    <%--    linePath.push(new kakao.maps.LatLng(<%= lats[i] %>, <%= lngs[i] %>));--%>
    linePath.push(new kakao.maps.LatLng(${requestScope.vertex_x[vs.index]}, ${requestScope.vertex_y[vs.index]}));
    points.push(new kakao.maps.LatLng(${requestScope.vertex_x[vs.index]}, ${requestScope.vertex_y[vs.index]}));
    </c:forEach>

    var polyline = new kakao.maps.Polyline({
        path: linePath,
        strokeWeight: 5,
        strokeColor: '#0000ff',
        strokeOpacity: 0.55,
        strokeStyle: 'solid'
    });
    polyline.setMap(map);

    // 지도 재설정할 범위정보를 가지고 있을 LatLngBounds 객체 생성
    var bounds = new kakao.maps.LatLngBounds();

    // LatLngBounds 객체에 좌표 추가
    for (let i = 0; i < points.length - 1; i++) {
        bounds.extend(points[i]);
    }

    // 지도 범위 재설정
    map.setBounds(bounds);

</script>