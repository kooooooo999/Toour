<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 페이지</title>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="../css/summernote-lite.css"/>
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

        .sidebar a {
            text-decoration: none;
            color: white;
            padding: 12px 10px;
            border-bottom: 1px solid #34495e;
            transition: background-color 0.3s;
        }

        .sidebar a:hover {
            background-color: #34495e;
        }

        .main-content {
            flex: 1;
            padding: 40px;
        }

        table {
            width: 100%;
            table-layout: fixed;
            border-collapse: collapse;
            background: #fff;
            border-radius: 6px;
            overflow: hidden;
        }

        thead {
            background-color: #fafafa;
            border-bottom: 2px solid #e1e4e8;
        }

        th {
            padding: 6px 20px;
            text-align: left;
            font-weight: 600;
            color: #2c3e50;
            font-size: 14px;
        }

        td {
            padding: 12px 20px;
            font-size: 13px;
            color: #4a4a4a;
        }

        td a {
            display: block;
            width: 100%;
            height: 100%;
            color: #34495e;
            text-decoration: none;
        }

        td a:hover {
            color: #1a73e8;
        }

        tbody tr:nth-child(even) {
            background-color: #f9fbfc;
        }

        tbody tr:hover {
            background-color: #e6f0ff;
        }

        td.no, th.no {
            width: 50px;
            text-align: center;
        }

        .pagination {
            margin: 20px auto;
            text-align: center;
            width: 100%;
        }

        .pagination a, .pagination span {
            display: inline-block;
            margin: 0 6px;
            padding: 6px 12px;
            font-size: 13px;
            color: #3498db;
            text-decoration: none;
            border-radius: 4px;
            border: 1px solid transparent;
        }

        .pagination a:hover {
            background-color: #e7f0ff;
            border-color: #3498db;
        }

        .pagination .current {
            font-weight: 700;
            background-color: #3498db;
            color: white;
            border-color: #3498db;
        }

        .search-area {
            background: #fff;
            padding: 20px;
            margin-bottom: 30px;
            border: 1px solid #e1e4e8;
            border-radius: 6px;
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .search-area form {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .search-area select,
        .search-area input[type="text"],
        .search-area button,
        #delbutton {
            padding: 8px 12px;
            font-size: 14px;
            border-radius: 4px;
            background: white;
            color: #2c3e50;
            border: 1px solid #ccc;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .search-area button,
        #delbutton {
            background-color: #3498db;
            color: white;
            border: none;
        }

        .search-area button:hover,
        #delbutton:hover {
            background-color: #2980b9;
        }


        #table thead th:nth-child(1) {
            width: 80px;
        }

        /* 전체선택 */
        #table thead th:nth-child(2) {
            width: 100px;
        }

        /* 회원번호 */
        #table thead th:nth-child(3) {
            width: 120px;
        }

        /* 이름 */
        #table thead th:nth-child(4) {
            width: 150px;
        }

        /* 아이디 */
        #table thead th:nth-child(5) {
            width: 150px;
        }

        /* 별명 */
        #table thead th:nth-child(6) {
            width: 100px;
        }

        /* 경고횟수 */
        #table thead th:nth-child(7) {
            width: 100px;
        }

    </style>
</head>
<body>

<div class="sidebar">
    <a href="AdminController">🏠 HOME</a>
    <a href="AdminController?type=adminnotice">📢 공지사항 관리</a>
    <a href="AdminController?type=adminpost">📝 게시물 관리</a>
    <a href="AdminController?type=adminmemlist">👥 회원정보 관리</a>
    <a href="AdminController?type=adminInquiry">📬문의사항 관리</a>
</div>

<div class="main-content" id="post">
    <h1>문의사항 관리</h1>
    <c:set var="requestsearchType" value="${param.searchType}"/>
    <div class="search-area">
        <form method="post" action="AdminController?type=adminInquiry">
            <select id="searchType" name="searchType">
                <option value="">
                    --문의 유형을 선택해주세요--
                </option>
                <option value="계정관리" <c:if test="${requestsearchType == '계정관리'}">selected</c:if>>계정 관리</option>
                <option value="서비스이용" <c:if test="${requestsearchType == '서비스이용'}">selected</c:if>>서비스 이용</option>
                <option value="기술지원" <c:if test="${requestsearchType == '기술지원'}">selected</c:if>>기술 지원</option>
                <option value="버그신고" <c:if test="${requestsearchType == '버그신고'}">selected</c:if>>버그 신고</option>
                <option value="기타" <c:if test="${requestsearchType == '기타'}">selected</c:if>>기타</option>
            </select>
        </form>
    </div>

    <div>
        <div>
            <table>
                <caption style="display: none">문의사항 테이블</caption>
                <thead>
                <th>번호</th>
                <th>카테고리</th>
                <th>제목</th>
                <th>작성자</th>
                <th>읽음/안읽음</th>
                <th>답변상태</th>
                <th>작성일</th>
                </thead>
                <tbody>
                <%--                inquiry_idx, member_idx, category, title, content, file_path, status, created_at, updated_at--%>
                <c:set var="p" value="${requestScope.page}" scope="page"/>
                <c:set var="category" value="${requestScope.cateAr}"/>
                <c:if test="${empty category}">
                    <c:forEach var="Ivo" items="${requestScope.IvoArr}" varStatus="count">
                        <%--                        <c:if test="${count.index < 10}">--%>
                        <tr class="data-inquiry" data-idx="${Ivo.inquiry_idx}" data-category="${Ivo.category}"
                            data-title="${Ivo.title}"
                            data-nickname="${Ivo.member_nickname}" data-read="${Ivo.is_read}"
                            data-status="${Ivo.status}" data-created="${Ivo.created_at}">
                            <td>${Ivo.inquiry_idx}</td>
                            <td>${Ivo.category}</td>
                            <td>${Ivo.title}</td>
                            <td>${Ivo.member_nickname}</td>
                            <td>${Ivo.is_read}</td>
                            <td>${Ivo.status}</td>
                            <td>${Ivo.created_at}</td>
                        </tr>
                        <%--                        </c:if>--%>
                    </c:forEach>
                </c:if>
                <c:if test="${not empty category}">
                    <c:forEach var="cat" items="${category}" varStatus="count">
                        <%--                        <c:if test="${count.index < 10}">--%>
                        <tr class="data-inquiry" data-idx="${cat.inquiry_idx}" data-category="${cat.category}"
                            data-title="${cat.title}"
                            data-nickname="${cat.member_nickname}" data-read="${cat.is_read}"
                            data-status="${cat.status}" data-created="${cat.created_at}">
                            <td>${cat.inquiry_idx}</td>
                            <td>${cat.category}</td>
                            <td>${cat.title}</td>
                            <td>${cat.member_nickname}</td>
                            <td>${cat.is_read}</td>
                            <td>${cat.status}</td>
                            <td>${cat.created_at}</td>
                        </tr>
                        <%--                        </c:if>--%>
                    </c:forEach>
                </c:if>
                </tbody>
            </table>
            <div class="pagination">
                <c:if test="${p.startPage > 1}">
                    <a href="AdminController?type=adminInquiry&cPage=${p.startPage - 1}">&lt;</a>
                </c:if>

                <c:forEach begin="${p.startPage}" end="${p.endPage}" varStatus="vs">
                    <c:choose>
                        <c:when test="${p.nowPage == vs.index}">
                            <span class="current">${vs.index}</span>
                        </c:when>

                        <c:otherwise>
                            <a href="AdminController?type=adminInquiry&cPage=${vs.index}">${vs.index}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:if test="${p.endPage < p.totalPage}">
                    <a href="AdminController?type=adminInquiry&cPage=${p.endPage + 1}">&gt;</a>
                </c:if>
            </div>


        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <script>
        $(function () {
            let option = {
                modal: true,
                autoOpen: false,
                resizable: false,
            };
            $(
                "#del_dialog").dialog(option);
        })

        function openDel() {
            $("#del_dialog").dialog("open");
        }

        $("#member_del_cancel").click(function () {
            $("#del_dialog").dialog("close");
        })

        function goDel() {
            document.getElementById("delform").submit();
        }

        function validateForm() {
            let searchValue = document.getElementById('searchValue').value;
            if (searchValue.trim() === '') {
                alert('검색내용을 입력하세요.');
                return false;
            }
            return true;
        }

        $(function () {
            // 전체 선택, 전체 해제
            $("#table thead input:checkbox").click(function () {
                //console.log("TT");
                // 클릭한 checkbox의 가장 가까운 태그(상위태그)를 알아낸다.
                //let p = $(this).parent(); //th
                let p = $(this).closest("th");// 현재 클릭한 체크박스의 가장 가까운 태그(th)

                // 앞서 구한 부모태그(th)가 해당 행(tr)에서 몇번째 요소인지
                // 인덱스를 알아내자
                let idx = $("#table thead tr th").index(p);
                // console.log(idx);

                // 구한 index값을 가지고 tbody에 있는 각 행에서
                // 해당 idx+1번째에 있는 td안의 체크박스들을 얻어낸다.
                let ar = $("#table tbody td:nth-child(" + (idx + 1) + ") input:checkbox");
                ar.prop("checked", this.checked);
            });

            //전체선택을 클릭한 뒤, tbody에 있는 클릭 한 개가 해제되면 전체선택 체크박스도 해제
            $("#table tbody input:checkbox").click(function () {

                //tbody에서 체크박스의 개수와 tbody에서 체크된 체크박스의 개수 비교
                let AllChecked = $("#table tbody input:checkbox").length == $("#table tbody input:checkbox:checked").length;
                $("#table thead input:checkbox").prop("checked", AllChecked);


            });
        });

        $("#searchType").change(function () {
            document.forms[0].submit();
        });

        $(document).ready(function () { //보안을 위해 거쳐서 이동
            $(document).on('click', '.data-inquiry', function (e) {
                e.preventDefault(); // a태그 href 링크 이동 방지
                let title = $(this).data('title');
                let addr1 = $(this).data('addr1');
                let overview = $(this).data('overview');
                let firstimage = $(this).data('firstimage');
                let mapx = $(this).data('mapx');
                let mapy = $(this).data('mapy');
                let contentTypeId = $(this).data('contenttypeid');
                let contentId = $(this).data('contentid');
                let homepageUrl = $(this).data('homepageurl');
                let homepageText = $(this).data('homepagetext');
                submitData(title, addr1, overview, firstimage, mapx, mapy, contentTypeId, contentId, homepageUrl, homepageText);
            });
        });

        function inquiryDetails(value) {

            $.ajax({
                url: "AdminController?type=adminInquiry&pageType=inquiryDetails",
                method: "POST"
            }).done(function (res) {
                console.log(value);
                $(".main-content").html(res);
            });

        }

    </script>
</body>
</html>
