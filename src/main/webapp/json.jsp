<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
    console.log(${requestScope.result})
var linePath = [];
<c:forEach var="vertex" begin="0" end="${fn:length(requestScope.vertex_x)-1}" varStatus="vs">
    <%--    linePath.push(new kakao.maps.LatLng(<%= lats[i] %>, <%= lngs[i] %>));--%>
        linePath.push(new kakao.maps.LatLng(${requestScope.vertex_x[vs.index]},${requestScope.vertex_y[vs.index]}));
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