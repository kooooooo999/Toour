<%--
  Created by IntelliJ IDEA.
  User: 쌍용교육센터
  Date: 25. 7. 31.
  Time: 오전 9:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div id="app"></div>
<script type="module" src="/src/main.js"></script>
</body>

<script>
    import axios from 'axios'
    export default {

        data() {
            return {
                options: {
                    center: new kakao.maps.LatLng(37.39843974939604, 127.10972941510465),
                    level: 13
                },
                map: null
            }
        },
        computed: {

        },
        watch: {

        },
        mounted() {
            const container = this.$refs.map;
            let _map = new kakao.maps.Map(container, this.options);
            this.map = _map;
        },
    }
</script>

<template>
    <div id="map" ref="map"></div>
</template>
<style>
    #map {
        width: 100%;
        height: 750px;
        border: 1px solid gray;
    }
</style>
</html>
