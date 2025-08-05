<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>
var linePath = [];
<c:forEach var="vertex" items="${requestScope.vertex_ar}" varStatus="vs">
    <%--    linePath.push(new kakao.maps.LatLng(<%= lats[i] %>, <%= lngs[i] %>));--%>
        linePath.push(new kakao.maps.LatLng(${vertex[vs.index][1]},${vertex[vs.index][0]}));
</c:forEach>
var polyline = new kakao.maps.Polyline({
    path: linePath,
    strokeWeight: 5,
    strokeColor: '#00aaff',
    strokeOpacity: 0.7,
    strokeStyle: 'solid'
});
polyline.setMap(map);
</script>