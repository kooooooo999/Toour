<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Date" %>
<%@ page import="toour.tripsuggestion.vo.DataVO" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <style>
        #city {
            display: inline-block;
            width: 600px;
            height: 600px;
            /*border: 1px solid #000;*/
        <c:if test="${param.imageChange == null}"> background-image: url("images/total.png");
        </c:if><c:if test="${param.imageChange ne null}"> background-image: url("images/${param.imageChange}.png");
        </c:if> background-repeat: no-repeat;
            margin: auto;
            position: relative;
        }

        #box {
            display: grid;
            grid-template-columns: 280px 280px;
            gap: 30px;
            width: 500px;
            margin-left: 50px;
            padding-top: 25px;
            /*border: 1px solid #4a545e;
            border-collapse: collapse;*/
        }

        #column {
            width: 250px;
        }

        #image {
            width: 250px;
            height: 150px;
        }

        .ellip {
            margin-top: 10px;
            display: inline-block;
            width: 100%;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .ellip_2 {
            margin-top: -10px;
            font-weight: bold;
            display: inline-block;
            width: 100%;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            font-size: 20px;
        }

        #regionWrap {
            margin-top: -50px;
        }
    </style>
</head>
<body>
<%--바디 영역--%>
<div id="regionWrap">
    <c:set var="addrTitle" value="${requestScope.sidodata}"/>
    <div class="tag_2" style="color: #0056b3; margin-left: 50px">
        <strong>
            ${addrTitle.sidoname}
        </strong>
    </div>
    <div id="box">
        <c:forEach var="vo" items="${requestScope.ar2}" varStatus="vs">
            <c:if test="${vs.index < 4}">
                <c:if test="${fn:length(vo.firstimage) > 0}">
                    <div id="column">
                        <img id="image" src="${vo.firstimage}"
                             onerror="this.src='images/noImage.png'"/>
                        <p class="ellip">${vo.addr1}</p>
                        <a href="#" class="data-link ellip_2" data-title="${vo.title}" data-addr1="${vo.addr1}"
                           data-firstimage="${vo.firstimage}"
                           data-mapx="${vo.mapx}" data-mapy="${vo.mapy}" data-contentid="${vo.contentId}"
                        >${vo.title}</a>
                    </div>
                </c:if>
            </c:if>
        </c:forEach>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script>
    $(document).ready(function () {
        $(document).on('click', '.data-link', function (e) {
            e.preventDefault();//a태그 이동 방지
            let title = $(this).data('title');
            let addr1 = $(this).data('addr1');
            let firstimage = $(this).data('firstimage');
            let mapx = $(this).data('mapx');
            let mapy = $(this).data('mapy');
            let contentid = $(this).data('contentid');

            submitData(title, addr1, firstimage, mapx, mapy, contentid)
        });
    });

    function submitData(title, addr1, firstimage, mapx, mapy, contentid) {
        console.log(contentid)
        let form = document.createElement('form');
        form.method = 'POST';
        form.action = 'Controller?type=sidoDetails';

        let titleInput = document.createElement('input');
        titleInput.type = 'hidden';
        titleInput.name = 'title';
        titleInput.value = title;

        let addr1Input = document.createElement('input');
        addr1Input.type = 'hidden';
        addr1Input.name = 'addr1';
        addr1Input.value = addr1;

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

        let contentIdInput = document.createElement('input');
        contentIdInput.type = 'hidden';
        contentIdInput.name = 'contentid';
        contentIdInput.value = contentid;

        form.appendChild(titleInput);
        form.appendChild(addr1Input);
        form.appendChild(firstimageInput);
        form.appendChild(mapxInput);
        form.appendChild(mapyInput);
        form.appendChild(contentIdInput);

        document.body.appendChild(form);

        form.submit();
    }
</script>
</body>
</html>