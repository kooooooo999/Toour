<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 페이지</title>
    <style>
        body {
            margin: 0;
            font-family: 'Noto Sans KR', sans-serif;
            display: flex;
            background-color: #f4f6f8;
        }

        .sidebar {
            width: 220px;
            background-color: #2c3e50;
            display: flex;
            flex-direction: column;
            padding: 20px;
            color: white;
            height: 100vh;
        }




        h1.page-title {
            font-size: 32px;
            font-weight: bold;
            color: #000000;
            margin-bottom: 30px;
        }

        .main-content {
            flex: 1;
            padding: 40px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            border-radius: 6px;
            overflow: hidden;
        }

        .dashboard {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .card-group {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .card {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            background-color: #ffffff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            min-height: 250px;
        }

        .card2 {
            background-color: #ffffff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            min-height: 300px;
        }

        .card-title {
            font-size: 18px;
            font-weight: bold;
            color: #2c3e50;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .card-title small {
            font-size: 13px;
            color: #7f8c8d;
        }

        .today_visit {
            display: flex;
            flex-direction: column;
            align-items: center; /* 가운데 정렬 */
            justify-content: center;
            height: 100%; /* 카드 높이 기준으로 가운데 정렬 */
        }



        .today_visit h3 {
            font-size: 18px;
            margin: 0 0 10px;
            color: #333;
        }

        .today_visit p {
            font-size: 24px;
            font-weight: bold;
            color: #1a73e8;
            margin: 10px 0 0;
        }


        .visit-icon {
            font-size: 20px;
            margin-right: 8px;
            color: #4caf50;
        }

        .today_board {
            font-size: 18px;
            font-weight: bold;
            color: #2c3e50;
        }

        .today_warning {
            font-size: 18px;
            font-weight: bold;
            color: #2c3e50;
        }

        #myChart {
            width: 500px !important;
            height: 500px !important;
            margin-top: 10px;
            margin-bottom: 10px;
        }


        .chart-container {
            margin-top: 10px;
            display: flex;
            justify-content: center; /* 가운데 정렬 */
        }


        table caption {
            text-indent: -9999px;
        }


        .today_warning h3 {
            margin-top: 0;
            font-size: 18px;
            color: #333;
        }

        .report-summary {
            margin: 10px 0;
            line-height: 1.6;
            font-size: 15px;
            color: #555;
        }

        .report-summary strong {
            color: #1a73e8;
        }

        .report-alert {
            color: red;
            font-weight: bold;
        }

        body {
            font-family: sans-serif;
            display: flex;
            justify-content: center;
            /*align-items: center;*/
            height: 100vh;
            margin: 0;
            background-color: #f0f2f5;
        }
        #chart-container {
            width: 80%; /* 컨테이너 너비 조절 */
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

    </style>
</head>
<body>

<c:import url="/common/adminSidebar.jsp"/>

<div class="main-content">
    <h1 class="page-title">관리자 페이지</h1>


    <div class="dashboard">
        <div class="card">
            <div class="card-title">
                전체 회원 수<br>
                <small>(전체회원수 / 회원수 / 휴면회원수 / 탈퇴회원수 / 강퇴회원수)</small>
                <p>${requestScope.totalCount}/
                    ${requestScope.MemCount}/
                    ${requestScope.DormantMemCount}/
                    ${requestScope.DeactivatedMemCount}/
                    ${requestScope.BannedMemCount}</p>
            </div>

            <div class="chart-container">
                <canvas id="myChart" width="180" height="180"></canvas>
                <script>
                    var ctx = document.getElementById('myChart');
                    var myChart = new Chart(ctx, {
                        type: 'doughnut',
                        data: {
                            labels: ['전체회원수', '회원수', '휴면회원수', '탈퇴회원수', '강퇴회원수'],
                            datasets: [{
                                label: '# of Votes',
                                data: [${requestScope.totalCount},
                                    ${requestScope.MemCount},
                                    ${requestScope.DormantMemCount},
                                    ${requestScope.DeactivatedMemCount},
                                    ${requestScope.BannedMemCount}],

                                backgroundColor: [
                                    'rgba(255, 99, 132, 0.2)',
                                    'rgba(54, 162, 235, 0.2)',
                                    'rgba(255, 206, 86, 0.2)',
                                    'rgba(75, 192, 192, 0.2)',
                                    'rgba(153, 102, 255, 0.2)',
                                    'rgba(255, 159, 64, 0.2)'
                                ],
                                borderColor: [
                                    'rgba(255, 99, 132, 1)',
                                    'rgba(54, 162, 235, 1)',
                                    'rgba(255, 206, 86, 1)',
                                    'rgba(75, 192, 192, 1)',
                                    'rgba(153, 102, 255, 1)',
                                    'rgba(255, 159, 64, 1)'
                                ],
                                borderWidth: 1
                            }]
                        },
                        options: {
                            responsive: false,
                            maintainAspectRatio: false,
                            cutoutPercentage: 10,
                            legend: {
                                display: false,
                                position: 'right',     // 오른쪽에 표시
                                align: 'end',          // 아래쪽 정렬
                                labels: {
                                    fontSize: 10,
                                    boxWidth: 10
                                }
                            },
                            layout: {
                                padding: {
                                    right: 20,         // 오른쪽 여백
                                    bottom: 20         // 아래쪽 여백
                                }
                            }
                        }
                    });
                </script>
            </div>
        </div>


        <div class="card-group">
        <div class="card">
            <div class="today_visit">
                <h3><span class="visit-icon">👥</span>최근 7일간 방문자 통계</h3>
                <p>방문자 수: ${requestScope.RecentVisitMem}명</p>
            </div>
        </div>
            <div class="card">
                <div class="today_warning">
                    <h3>📊 최근 30일간 신고 통계</h3>

                    <div class="report-summary">
                        총 신고 수: <strong>${requestScope.ReportCount}</strong><br/>
                        게시글 신고 수: <strong>${requestScope.PostreportCount}</strong><br/>
                        댓글 신고 수: <strong>${requestScope.CommentreportCount}</strong>
                    </div>

                    <div class="report-summary">
                        미처리된 신고 수:
                        <c:choose>
                            <c:when test="${requestScope.UnprocessedreportCount > 0}">
                                <span class="report-alert">${requestScope.UnprocessedreportCount}건 ⚠️</span>
                            </c:when>
                            <c:otherwise>
                                <strong>${requestScope.UnprocessedreportCount}건</strong>
                            </c:otherwise>
                        </c:choose><br/>

                        처리된 신고 수: <strong>${requestScope.processedreportCount}건</strong>
                    </div>
                </div>
        <div class="card2">
            <div class="today_board">
                최근 게시글 수(일주일)
                <p>${requestScope.getRecentPost}</p>
                <div class="chart-container">
                    <canvas id="weeklyPostChart" width="600" height="400"></canvas>
                </div>
            </div>

            <script>
                // 오늘 날짜
                var today = new Date();

                // 최근 7일 날짜 라벨 & DB 매칭용 키 배열
                var labels = [];
                var dateKeys = [];
                for (var i = 6; i >= 0; i--) {
                    var d = new Date();
                    d.setDate(today.getDate() - i);
                    var month = d.getMonth() + 1;
                    var day = d.getDate();
                    labels.push(month + '/' + day); // 차트에 표시될 라벨
                    dateKeys.push(d.getFullYear() + '-' + String(month).padStart(2,'0') + '-' + String(day).padStart(2,'0')); // DB 날짜 키
                }

                // DB 데이터 객체로 변환 (키-값 매핑)
                var dbDataMap = {
                    <c:forEach var="map" items="${requestScope.weeklyPostList}" varStatus="loop">
                    '${map.post_day}': ${map.cnt}<c:if test="${!loop.last}">,</c:if>
                    </c:forEach>
                };

                // 최근 7일 데이터 매핑, 없는 날짜는 0
                var postData = [];
                for(var i=0; i<dateKeys.length; i++){
                    postData.push(dbDataMap[dateKeys[i]] || 0);
                }

                var postColors = [
                    'rgba(255, 99, 132, 0.6)',
                    'rgba(54, 162, 235, 0.6)',
                    'rgba(255, 206, 86, 0.6)',
                    'rgba(75, 192, 192, 0.6)',
                    'rgba(153, 102, 255, 0.6)',
                    'rgba(255, 159, 64, 0.6)',
                    'rgba(99, 255, 132, 0.6)'
                ];

                // 차트 그리기
                var ctx = document.getElementById('weeklyPostChart').getContext('2d');
                new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: '게시글 수',
                            data: postData,
                            backgroundColor: postColors, // 각 막대 색 지정
                            borderColor: postColors.map(c => c.replace('0.6','1')), // 테두리 색
                            borderWidth: 1
                        }]
                    },
                    options: {
                        responsive: false,
                        maintainAspectRatio: false,
                        scales: {
                            xAxes: [{
                                gridLines: { display: false }
                            }],
                            yAxes: [{
                                ticks: {
                                    beginAtZero: true, // 0부터 시작
                                    min: 0,            // 최소값 0
                                    max: 100,          // 최대값 100
                                    stepSize: 10        // 눈금 간격
                                },
                                gridLines: { color: "rgba(0,0,0,0.05)" }
                            }]
                        },
                        legend: { display: false }
                    }
                });
            </script>

        </div>

        <div class="card2">
            <div class="today_warning">
                최근 신고 수 (한달)
            </div>
        </div>
    </div>
</div>
    </div>
</div>
</body>

</html>
