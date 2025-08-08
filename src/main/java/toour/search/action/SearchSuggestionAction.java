package toour.search.action;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.input.SAXBuilder;
import toour.action.Action;
import toour.search.util.GetAPISearchData;
import toour.search.vo.SearchResponseVO;
import toour.search.vo.SearchDataVO;
import toour.tripsuggestion.vo.DataVO;
import toour.util.Paging;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;
import java.util.Objects;

public class SearchSuggestionAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String viewPath = null;
        String contentTypeid = request.getParameter("contentTypeId"); //관광타입ID (12:관광지, 14:문화시설, 15:축제공연행사, 25:여행코스, 28:레포츠, 32:숙박, 38:쇼핑, 39:음식점)
        String areaCode = request.getParameter("areaCode"); //지역코드
        String sigunguCode = request.getParameter("sigunguCode"); //시군구코드
        String cat1 = request.getParameter("cat1"); //대분류
        String cat2 = request.getParameter("cat2"); //중분류
        String cat3 = request.getParameter("cat3"); //소분류
        String cPage = request.getParameter("cPage"); //지금페이지

        Paging page = new Paging(5, 5);

        String keyword = request.getParameter("keyword"); //키워드
        String encodedKeyword;
        try {
            encodedKeyword = URLEncoder.encode(keyword, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }


//        if (contentTypeid == null) {
//            //// 키워드 기반 검색 ////
//            SearchDataVO[] searchResults = GetAPISearchData.getSearch(request,keyword);
//            request.setAttribute("searchResults", searchResults);
//            //// 세빈 변경해야 될 부분 ////
//            viewPath = "APISearchData.jsp";
//        } else {
//            viewPath = "tripSuggestion_update.jsp";
//        }

        if (keyword != null && !keyword.trim().isEmpty()){
            SearchDataVO[] data = GetAPISearchData.getSearch(request,keyword);
            request.setAttribute("data", data);
            viewPath = "APISearchData.jsp";
        }else{
            viewPath = "APISearchData_update.jsp";
        }

        //공공데이터 openAPI 호출하는 경로
        //http://apis.data.go.kr/B551011/KorService2/areaBasedList2?serviceKey=서비스인증키

        String key = "serviceKey=hPrdpbOAuU8ouxUCNFQ%2B3GhU1eshPcqvNhYV2QamRDzm3Vg32RGIpuEj5jaAGt8AQxVjdhdN5vgymQb6fh6y1w%3D%3D";


        String code = request.getParameter("areaCode");
        if (code == null) {
            areaCode = "0";
            if (areaCode == null) {
                areaCode = "1";
            }

            if (cPage == null) {
                cPage = "1";
            }
//          https://apis.data.go.kr/B551011/KorService2/searchKeyword2?serviceKey=서비스인증키
//          &MobileApp=AppTest&MobileOS=ETC&pageNo=1&numOfRows=10&keyword=시장&
//          cat1=A04&cat2=A0401&cat3=A04010100&arrange=C&areaCode=39&sigunguCode=3&_type=json
//          &lDongRegnCd=50&lDongSignguCd=130&lclsSystm1=SH&lclsSystm2=SH06&lclsSystm3=SH060100

            SearchDataVO vo = new SearchDataVO();
            //String keyword = vo.getKeyword();

            //관광타입(12: 관광지, 14: 문화시설, 15: 축제공연 행사, 25: 여행코스, 28: 레포츠, 32: 숙박, 38: 쇼핑, 39: 음식점) ID

            //세빈 변경 (공공 API 요청 URL 구성 (searchKeyword2))
            StringBuilder sb = new StringBuilder("https://apis.data.go.kr/B551011/KorService2/searchKeyword2?");
            sb.append(key);
            sb.append("&MobileApp=AppTest&MobileOS=ETC&pageNo=" );
            System.out.println(cPage);
            sb.append(Integer.parseInt(cPage));
            sb.append("&numOfRows=");
            sb.append("10");
            sb.append("&keyword=");
            sb.append(encodedKeyword);
            if (cat1 != null && !cat1.equals("0")) {//0이 전부를 뜻함
                sb.append("&cat1=");//자연/인문~
                sb.append(cat1);
                if (cat2 != null && !cat2.equals("0")) {
                    sb.append("&cat2=");//자연에서는 자연관광w/관광자원
                    sb.append(cat2);//인문에서는 역사 휴양 어쩌고 많음
                    if (cat3 != null && !cat3.equals("0")) {
                        sb.append("&cat3=");
                        sb.append(cat3);
                    }
                }
            }
            sb.append("&arrange=A");
            if (sigunguCode != null && !sigunguCode.equals("0")) {
                sb.append("&sigunguCode=");
                sb.append(sigunguCode);
            }
            sb.append("&_type=xml");
            System.out.println("sb1:"+sb);
            try {
                URL url1 = new URL(sb.toString());
                HttpURLConnection conn1 = (HttpURLConnection) url1.openConnection();
                conn1.setRequestProperty("Content-Type", "application/xml");
                conn1.connect();
                SAXBuilder builder = new SAXBuilder();
                Document doc = builder.build(conn1.getInputStream());
                Element root = doc.getRootElement();
                Element body = root.getChild("body");

                Element totalCount = body.getChild("totalCount");
                String totalCountStr = totalCount.getText();

                Element items = body.getChild("items");
                List<Element> item_list = items.getChildren("item");

                SearchResponseVO[] ar = new SearchResponseVO[item_list.size()];

                int i = 0;

                //응답 메시지
                for (Element item : item_list) {
                    String addr1 = item.getChildText("addr1");
                    String addr2 = item.getChildText("addr2");
                    String zipcode = item.getChildText("zipcode");
                    String voCat1 = item.getChildText("cat1");
                    String voCat2 = item.getChildText("cat2");
                    String voCat3 = item.getChildText("cat3");
                    String contentid = item.getChildText("contentid");
                    String contenttypeid = item.getChildText("contenttypeid");
                    String createdtime = item.getChildText("createdtime");
                    String firstimage = item.getChildText("firstimage");
                    System.out.println(firstimage);

                    String firstimage2 = item.getChildText("firstimage2");
                    String cpyrhtDivCd = item.getChildText("cpyrhtDivCd");
                    String mapx = item.getChildText("mapx");
                    String mapy = item.getChildText("mapy");
                    String mlevel = item.getChildText("mlevel");
                    String modifiedtime = item.getChildText("modifiedtime");
                    String sigungucode = item.getChildText("sigungucode");
                    String tel = item.getChildText("tel");
                    String title = item.getChildText("title"); //자식 태그 안의 문자열
                    String lDongRegnCd = item.getChildText("lDongRegnCd");
                    String lDongSignguCd = item.getChildText("lDongSignguCd");
                    String lclsSystm1 = item.getChildText("lclsSystm1");
                    String lclsSystm2 = item.getChildText("lclsSystm2");
                    String lclsSystm3 = item.getChildText("lclsSystm3");

//https://apis.data.go.kr/B551011/KorService2/detailCommon2?serviceKey=인증키
// &MobileApp=AppTest&MobileOS=ETC&pageNo=1&numOfRows=10&contentId=126128&_type=json
                    StringBuffer sb2 = new StringBuffer("https://apis.data.go.kr/B551011/KorService2/detailCommon2?serviceKey=hPrdpbOAuU8ouxUCNFQ%2B3GhU1eshPcqvNhYV2QamRDzm3Vg32RGIpuEj5jaAGt8AQxVjdhdN5vgymQb6fh6y1w%3D%3D&MobileApp=AppTest&MobileOS=ETC&pageNo=1&numOfRows=10");
                    sb2.append("&_type=xml&contentId=");
                    sb2.append(contentid);
                    System.out.println("sb2:"+sb2);
                    // 상세정보용 API 호출도 수행 (중첩 API)
                    URL url2 = new URL(sb2.toString());
                    HttpURLConnection conn2 = (HttpURLConnection) url2.openConnection();
                    conn2.setRequestProperty("Content-Type", "application/xml");
                    conn2.connect();
                    SAXBuilder builder2 = new SAXBuilder();
                    Document doc2 = builder2.build(conn2.getInputStream());
                    Element root2 = doc2.getRootElement();
                    Element body2 = root2.getChild("body");
                    Element items2 = body2.getChild("items");
                    List<Element> item_list2 = items2.getChildren("item");
                    String overview = null;
                    for (Element item2 : item_list2) {
                        overview = item2.getChildText("overview");
                    }
                    //결과 객체 생성
                    SearchResponseVO srvo = new SearchResponseVO(title,addr1,overview,firstimage);

                    page.setTotalCount(Integer.parseInt(totalCountStr));
                    page.setNowPage(Integer.parseInt(cPage));
                    int totalCount2 = page.getTotalCount();
                    int nowPage2 = page.getNowPage();

                    ar[i++] = srvo;

                }
                // 최종적으로 배열을 dataAr 라는 이름으로 JSP에 전달
                request.setAttribute("searchAr", ar);
                request.setAttribute("page", page);
                request.setAttribute("totalCount", totalCountStr);
                request.setAttribute("cPage", cPage);
                request.setAttribute("keyword",keyword);
                request.setAttribute("encodeKeyword",encodedKeyword);
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
        return viewPath;
    }

}

