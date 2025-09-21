<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Date" %>
<%@ page import="toour.notice.dao.NoticeDAO" %>
<%@ page import="toour.post.vo.PostVO" %>
<%@ page import="java.util.List" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>👋🏻toour</title>
    <link rel="stylesheet" href="<c:url value="/css/style.css" />">
    <link rel="stylesheet" href="<c:url value="/css/footer.css" />">
    <link rel="stylesheet" href="<c:url value="/css/header.css" />">
    <link rel="stylesheet" href="<c:url value="/css/sido.css" />">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .slide-container {
            width: 70%;
            overflow: hidden; /* visible → hidden */
            margin: 0 auto;
            position: relative;
        }

        .slide-wrapper {
            display: flex;
            transition: transform 0.5s ease-in-out;
            justify-content: center;
            width: fit-content; /* 또는 충분히 크게 고정해도 됨 */
        }

        .slide-item {
            width: 400px;
            margin: 0 15px;
            flex-shrink: 0;
            opacity: 0.5;
            transition: opacity 0.5s;
            overflow: hidden; /* 둥근 모서리 유지 */
            border-radius: 8px;
            position: relative;
        }

        .slide-item img {
            width: 100%;
            height: 400px;
            object-fit: cover;
            border-radius: 8px; /* 이미지 자체에도 */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
            transition: transform 0.5s, opacity 0.5s;
        }

        .slide-item.active {
            opacity: 1;
            z-index: 2;
        }

        /* 이미지 없을 때 텍스트 스타일 */
        .slide-item .emptyText {
            width: 100%;
            height: 450px;
            background-color: #f0f0f0;
            color: #888;
            font-size: 24px;
            font-weight: bold;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* 이전/다음 버튼 */
        .prev-btn, .next-btn {
            position: absolute;
            top: 40%;
            transform: translateY(-50%);
            background-color: transparent; /* 배경색을 투명하게 만듭니다. */
            color: white;
            border: none;
            padding: 15px;
            cursor: pointer;
            font-size: 20px;
            z-index: 10;
            border-radius: 5px;
        }

        .prev-btn {
            left: 0;
        }

        .next-btn {
            right: 0;
        }

    </style>
</head>
<body>

<c:import url="/common/header.jsp"/>
<c:import url="/Controller?type=noticeMain"/>
<main>

    <section class="hero-travel-guide container">
        <div class="hero-content-left">
            <p class="tag_2">지역으로보는<strong> toour 관광지</strong></p>
            <p class="lineDetails_3">
            <p style="font-size: 20px">조회할 지역을 선택하세요</p>
            <div class="hero-pagination">

            </div>
        </div>
        <div class="hero-image-right">
            <%--            <img src="https://via.placeholder.com/600x400/d7e5f0/4e6e8e?text=Gyeongju+Travel+Image" alt="경북 영주 여행 이미지">--%>
        </div>
    </section>
    <jsp:include page="./sido.jsp"/>
    <section class="travel-cockcock">
        <form class="container">
            <div class="tabs">
                <span class="tab" style="font-weight: 900; color: #0056b3; font-size: 30px;">🔥핫플콕콕🔥</span>
            </div>
            <%--data-contentid="126674" --%>

            <div class="recommend-cards">
                <div class="card">
                    <a href="#" class="data-trip" data-contenttypeid="12" data-areacode="6" data-contentid="126674">
                        <img src="https://cdn.visitkorea.or.kr/img/call?cmd=VIEW&id=b2526e1d-56a4-42df-9c98-f8255009c851"
                             alt="해운대">
                        <div class="card-content">
                            <h4>해운대 달맞이길<br><small>부산시 해운대구</small></h4>
                        </div>
                    </a>
                </div>

                <div class="card">
                    <a href="#" class="data-trip" data-contenttypeid="12" data-areacode="35" data-contentid="2753918">
                        <img src="http://tong.visitkorea.or.kr/cms/resource/57/2754157_image2_1.jpg"
                             alt="나곡낚시공원 (바다낚시공원)">
                        <div class="card-content">
                            <h4>바다낚시공원<br><small>경상북도 울진군</small></h4>
                        </div>
                    </a>
                </div>

                <div class="card">
                    <a href="#" class="data-trip" data-contenttypeid="12" data-areacode="6" data-contentid="2748834">
                        <img src="https://cdn.visitkorea.or.kr/img/call?cmd=VIEW&id=26eacf69-77ed-4ec7-a659-fe19f39ff7d1"
                             alt="데미샘자연휴양림">
                        <div class="card-content">
                            <h4>데미샘자연휴양림<br><small>전라북도 진안군</small></h4>
                        </div>
                    </a>
                </div>

                <div class="card">
                    <a href="#" class="data-trip" data-contenttypeid="12" data-areacode="6" data-contentid="2499842">
                        <img src="https://cdn.visitkorea.or.kr/img/call?cmd=VIEW&id=8132ce55-9fbf-4b85-8a8e-b324286393db"
                             alt="내동마을 연꽃단지">
                        <div class="card-content">
                            <h4>내동마을 연꽃단지<br><small>경기도 용인시</small></h4>
                        </div>
                    </a>
                </div>
            </div>
        </form>

    </section>

    <%
        // NoticeDAO를 사용하여 공지사항 목록을 가져옵니다.
        NoticeDAO noticeDAO = new NoticeDAO();
        int c = 4;
        List<toour.notice.vo.PostVO> noticeList = NoticeDAO.selectLatestNotice(c);

        // 가져온 목록을 request 속성에 저장합니다.
        request.setAttribute("noticeMainAr", noticeList);
    %>
    <section class="news-banner-section container">
        <div class="news-area">
            <h3>
                <a href="/Controller?type=notice" class="news-link">
                    오늘의 공지사항 <i class="fas fa-plus plus-icon"></i>
                </a>
            </h3>
            <ul class="news-list">
                <c:set value="${requestScope.noticeMainAr}" var="noticeMainAr"/>
                <c:forEach items="${noticeMainAr}" var="vo">
                    <li>
                        <span class="category">공지</span>
                        <span class="news-title">
                        <a href="Controller?type=noticeview&post_idx=${vo.post_idx}">
                                ${vo.post_title}
                        </a>
                    </span>
                        <span class="news-date">
                                ${vo.post_created_at.substring(0,10)}
                        </span>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </section>

    <div class="slide-container accommodation-slide-container">
        <div class="slide-wrapper">
            <div class="slide-item">
                <a href="#" class="data-trip" data-contenttypeid="12" data-areacode="4" data-contentid="2703799">
                    <img src="http://tong.visitkorea.or.kr/cms/resource/38/3022238_image2_1.jpg"
                         alt="군위 삼국유사 테마파크"/>
                    <div class="card-content">
                        <h4>삼국유사 속 콘텐츠를 주제로 한 테마파크!</h4>
                        <p>군위 삼국유사 테마파크</p>
                    </div>
                </a>
            </div>
            <div class="slide-item">
                <a href="#" class="data-trip" data-contenttypeid="12" data-areacode="7" data-contentid="127515">
                    <img src="http://tong.visitkorea.or.kr/cms/resource/75/2712575_image2_1.jpg"
                         alt="대왕암공원"/>
                    <div class="card-content">
                        <h4>푸른바다, 우리의 꿈 대왕암!</h4>
                        <p>대왕암공원</p>
                    </div>
                </a>
            </div>

            <div class="slide-item">
                <a href="#" class="data-trip" data-contenttypeid="12" data-areacode="35" data-contentid="128526">
                    <img src="http://tong.visitkorea.or.kr/cms/resource/62/2612562_image2_1.jpg"
                         alt="경주 동궁과 월지"/>
                    <div class="card-content">
                        <h4>야경이 아름다운 낭만적인 신라 왕궁의 별궁 터</h4>
                        <p>경주 동궁과 월지</p>
                    </div>
                </a>
            </div>

            <div class="slide-item">
                <a href="#" class="data-trip" data-contenttypeid="12" data-areacode="39" data-contentid="2662743">
                    <img src="http://tong.visitkorea.or.kr/cms/resource/48/3523648_image2_1.jpg"
                         alt="엉덩물계곡"/>
                    <div class="card-content">
                        <h4>계곡 사이 피어난 유채꽃의 입체적인 풍경 명소</h4>
                        <p>엉덩물계곡</p>
                    </div>
                </a>
            </div>

            <div class="slide-item">
                <a href="#" class="data-trip" data-contenttypeid="12" data-areacode="5" data-contentid="2614852">
                    <img src="http://tong.visitkorea.or.kr/cms/resource/47/2614847_image2_1.bmp"
                         alt="입석대 (무등산권 국가지질공원)"/>
                    <div class="card-content">
                        <h4>무등산의 대표 절경</h4>
                        <p>입석대</p>
                    </div>
                </a>
            </div>


            <div class="slide-item">
                <a href="#" class="data-trip" data-contenttypeid="12" data-areacode="34" data-contentid="125926">
                    <img src="http://tong.visitkorea.or.kr/cms/resource/85/3506485_image2_1.jpg"
                         alt="천안 유관순 열사 유적"/>
                    <div class="card-content">
                        <h4>유관순 열사의 나라사랑 정신을 느낄 수 있는 곳</h4>
                        <p>천안 유관순 열사 유적</p>
                    </div>
                </a>
            </div>

            <div class="slide-item">
                <a href="#" class="data-trip" data-contenttypeid="12" data-areacode="38" data-contentid="127923">
                    <img src="http://tong.visitkorea.or.kr/cms/resource/93/3479293_image2_1.jpg"
                         alt="화엄사"/>
                    <div class="card-content">
                        <h4>화엄사상 꽃피운 천년의 화엄성지</h4>
                        <p>화엄사</p>
                    </div>
                </a>
            </div>

            <div class="slide-item">
                <a href="#" class="data-trip" data-contenttypeid="12" data-areacode="36" data-contentid="127778">
                    <img src="http://tong.visitkorea.or.kr/cms/resource/96/2703896_image2_1.jpg"
                         alt="가천 다랭이마을"/>
                    <div class="card-content">
                        <h4>남해 감성 여행지 다랭이 마을</h4>
                        <p>가천 다랭이마을</p>
                    </div>
                </a>
            </div>
            <div class="slide-item">
                <a href="#" class="data-trip" data-contenttypeid="12" data-areacode="38" data-contentid="2606207">
                    <img src="http://tong.visitkorea.or.kr/cms/resource/53/2640153_image2_1.jpg"
                         alt="목포 해상케이블카"/>
                    <div class="card-content">
                        <h4>계곡 사이 피어난 유채꽃의 입체적인 풍경 명소</h4>
                        <p>목포 해상케이블카</p>
                    </div>
                </a>
            </div>

        </div>
        <button class="prev-btn">❮</button>
        <button class="next-btn">❯</button>
    </div>

</main>

<c:import url="/common/footer.jsp"/>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script type="text/javascript">

    $(document).ready(function () { //보안을 위해 거쳐서 이동
        $(document).on('click', '.data-trip', function (e) {
            //data-contenttypeid="12" data-contentid="126674" data-areacode="6"
            e.preventDefault();
            let contentTypeId = $(this).data('contenttypeid');
            let areacode = $(this).data('areacode');
            let contentId = $(this).data('contentid');
            console.log("넘길 contentId:", contentId);
            let form = $('<form></form>');
            form.attr('action', 'Controller?type=tripSuggestion&pageType=gogo');
            form.attr('method', 'post');
            form.attr('style', 'display: none;'); // 화면에 보이지 않게 숨김

            let contentTypeInput = $('<input>').attr('type', 'hidden').attr('name', 'contentTypeId').val(contentTypeId);
            let areaCodeInput = $('<input>').attr('type', 'hidden').attr('name', 'areaCode').val(areacode);
            let contentIdInput = $('<input>').attr('type', 'hidden').attr('name', 'contentId').val(contentId);

            form.append(contentTypeInput, areaCodeInput, contentIdInput);

            $('body').append(form);
            form.submit();
        });

        var accommodationContainer = $('.accommodation-slide-container');
        initSlide(accommodationContainer);

        function initSlide(container) {
            var slideWrapper = container.find('.slide-wrapper');
            var slides = slideWrapper.find('.slide-item');
            var currentIndex = 1;
            var slideCount = slides.length;
            var slideWidth = slides.outerWidth(true); // ✅ 정확한 슬라이드 전체 폭 계산

            // 처음 슬라이드 활성화
            slides.removeClass('active');
            slides.eq(currentIndex).addClass('active');

            container.find('.prev-btn').click(function () {
                if (slideCount === 0) return;

                if (currentIndex === 0) {
                    // 첫 번째 슬라이드(0)에 있을 때 이전 버튼 클릭 시
                    currentIndex = slideCount - 1;  // 마지막 인덱스로 이동
                } else {
                    currentIndex = currentIndex - 1;
                }
                updateSlide();
            });

            container.find('.next-btn').click(function () {
                if (slideCount === 0) return;

                if (currentIndex === 0) {
                    // 0번째 인덱스일 때 다음 클릭하면 마지막으로
                    currentIndex = slideCount - 1;
                } else {
                    currentIndex = (currentIndex < slideCount - 1) ? currentIndex + 1 : 0;
                }
                updateSlide();
            });

            function updateSlide() {
                // 1. 컨테이너의 중앙을 계산합니다.
                const containerWidth = $('.slide-container').width();

                // 2. 활성화된 슬라이드 아이템의 너비를 포함한 전체 너비를 계산합니다.
                //    outerWidth(true)는 마진을 포함한 너비를 반환합니다.
                const slideItemWidth = slides.outerWidth(true);

                // 3. 슬라이더가 이동해야 할 오프셋 값을 계산합니다.
                //    중앙 정렬을 위해 컨테이너 너비의 절반과 슬라이드 아이템 너비의 절반을 고려합니다.
                const offset = (containerWidth / 2) - (slideItemWidth / 2) - (slideItemWidth * currentIndex);

                // 4. 계산된 오프셋 값을 적용합니다.
                slideWrapper.css('transform', 'translateX(' + offset + 'px)');

                // 활성화 클래스 업데이트
                slides.removeClass('active');
                slides.eq(currentIndex).addClass('active');
            }
        }

    });

</script>
</body>

</html>