<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head id="head">
    <title>👋🏻toour</title>
    <link rel="stylesheet" type="text/css" href="./css/sido.css">
    <style id="style">
        #totalWrap {
            width: 1560px;
            height: auto;
            margin: auto;
            padding-right: 200px;
        }

        #wrap {
            /*border: 1px solid #000;*/
            display: flex;
            width: 1000px;
            height: 600px;
            margin: auto;
        }

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

        #sidoInfo {
            display: inline-block;
            /*border: 1px solid #000;*/
            width: 500px;
            height: 600px;
        }

        #cityName {
            width: 600px;
            height: 600px;
            position: absolute;
        }
    </style>
</head>
<body>
<div id="totalWrap">
    <div id="wrap">
        <div id="city">
            <!-- 서울 : 1, 인천 : 2, 대전 : 3, 대구 : 4, 광주 : 5, 부산 : 6, 울산 : 7, 경기 : 31,
            강원 : 32, 충북 : 33, 충남 : 34, 경북 : 35, 경남 : 36, 전북 : 37, 전남 : 38, 제주 : 39 -->
            <div id="cityName">
                <p class="common gyeonggi">경기</p>
                <a href="javascript:clickSido('31','경기도')" class="common gyeonggi">경기</a>
                <p class="common seoul">서울</p>
                <a href="javascript:clickSido('1','서울특별시')" class="common seoul">서울</a>
                <p aria-readonly="false" class="common smallText incheon">인천</p>
                <a href="javascript:clickSido('2','인천광역시')" class="common smallText incheon">인천</a>
                <p class="common gangwon">강원</p>
                <a href="javascript:clickSido('32','강원특별자치도')" class="common gangwon">강원</a>
                <p class="common gyeongbuk">경북</p>
                <a href="javascript:clickSido('35','경상북도')" class="common gyeongbuk">경북</a>
                <p class="common gyeongnam">경남</p>
                <a href="javascript:clickSido('36','경상남도')" class="common gyeongnam">경남</a>
                <p class="common smallText daegu">대구</p>
                <a href="javascript:clickSido('4','대구광역시')" class="common smallText daegu">대구</a>
                <p class="common smallText busan">부산</p>
                <a href="javascript:clickSido('6','부산광역시')" class="common smallText busan">부산</a>
                <p class="common smallText ulsan">울산</p>
                <a href="javascript:clickSido('7','울산광역시')" class="common smallText ulsan">울산</a>
                <p class="common chungbuk">충북</p>
                <a href="javascript:clickSido('33','충청북도')" class="common chungbuk">충북</a>
                <p class="common chungnam">충남</p>
                <a href="javascript:clickSido('34','충청남도')" class="common chungnam">충남</a>
                <p class="common smallText daejeon">대전</p>
                <a href="javascript:clickSido('3','대전광역시')" class="common smallText daejeon">대전</a>
                <p class="common jeonbuk">전북</p>
                <a href="javascript:clickSido('37','전라북도')" class="common jeonbuk">전북</a>
                <p class="common jeonnam">전남</p>
                <a href="javascript:clickSido('38','전라남도')" class="common jeonnam">전남</a>
                <p class="common smallText gwangju">광주</p>
                <a href="javascript:clickSido('5','광주광역시')" class="common smallText gwangju">광주</a>
                <p class="common jeju">제주</p>
                <a href="javascript:clickSido('39','제주특별자치도')" class="common jeju">제주</a>
            </div>
        </div>
        <div id="sidoInfo"></div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script>

    $(function () {
        clickSido('32', '강원특별자치도');
    });

    function clickSido(city, sidoName) {

        $.ajax({
            url: "Controller?type=sido",
            type: "post",
            data: {areaCode: city, imageChange: city, sidoName: sidoName}
        }).done(function (result) {
            $("#sidoInfo").html(result);
        });

    }

    function selectImage(selectedImg) {
        let images = document.querySelectorAll('.images img');
        images.forEach(function (img) {
            img.classList.remove('selected');
            img.classList.add('deselected');
        });

        selectedImg.classList.remove('deselected');
        selectedImg.classList.add('selected');
    }

</script>
</body>
</html>
