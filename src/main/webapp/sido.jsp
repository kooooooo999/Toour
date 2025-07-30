<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="sido.css">
    <style>
        #clickSido{
            display: inline-block;
            width: 500px;
            height: 600px;
            border: 1px solid #000;
            background-image: url("images/total.png");
            background-repeat: no-repeat;
            position: relative;
        }

    </style>
</head>
<body>
        <div id="clickSido">
            <p class="common gyeonggi">경기</p>
            <a href="javascript:c" onclick="clickSido('gyeonggido')" class="common gyeonggi">경기</a>
            <p class="common seoul">서울</p>
            <a href="" onclick="clickSido('seoul')" class="common seoul">서울</a>
            <p class="common smallText incheon">인천</p>
            <a href="" onclick="clickSido('incheon')" class="common smallText incheon">인천</a>
            <p class="common gangwon">강원</p>
            <a href="" onclick="clickSido('gangwondo')" class="common gangwon">강원</a>
            <p class="common gyeongbuk">경북</p>
            <a href="" onclick="clickSido('gyeongbuk')" class="common gyeongbuk">경북</a>
            <p class="common gyeongnam">경남</p>
            <a href="" onclick="clickSido('gyeongnam')" class="common gyeongnam">경남</a>
            <p class="common smallText daegu">대구</p>
            <a href="" onclick="clickSido('daegu')" class="common smallText daegu">대구</a>
            <p class="common smallText busan">부산</p>
            <a href="" onclick="clickSido('busan')" class="common smallText busan">부산</a>
            <p class="common smallText ulsan">울산</p>
            <a href="" onclick="clickSido('ulsan')" class="common smallText ulsan">울산</a>
            <p class="common chungbuk">충북</p>
            <a href="" onclick="clickSido('chungbuk')" class="common chungbuk">충북</a>
            <p class="common chungnam">충남</p>
            <a href="" onclick="clickSido('chungnam')" class="common chungnam">충남</a>
            <p class="common smallText daejeon">대전</p>
            <a href="" onclick="clickSido('daejeon')" class="common smallText daejeon">대전</a>
            <p class="common jeonbuk">전북</p>
            <a href="" onclick="clickSido('jeonbuk')" class="common jeonbuk">전북</a>
            <p class="common jeonnam">전남</p>
            <a href="" onclick="clickSido('jeonnam')" class="common jeonnam">전남</a>
            <p class="common smallText gwangju">광주</p>
            <a href="" onclick="clickSido('gwangju')" class="common smallText gwangju">광주</a>
            <p class="common jeju">제주</p>
            <a href="" onclick="clickSido('jejudo')" class="common jeju">제주</a>
        </div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script>
    function clickSido(city) {
        $("#clickSido").style.backgroundImage
    }
</script>
</body>
</html>
