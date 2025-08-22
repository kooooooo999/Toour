package toour.tripsuggestion.action;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.input.SAXBuilder;
import toour.action.Action;
import toour.tripsuggestion.vo.DataVO;
import toour.tripsuggestion.vo.LoCatVO;
import toour.util.GetAPIData;
import toour.util.Paging;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class tripSuggestionAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        String pageType = request.getParameter("pageType");
        String viewPath = "tripSuggestion.jsp";
        String rows = "5";
        Paging page = new Paging(5, 5);
        String contentTypeid = request.getParameter("contentTypeId");
        String areaCode = request.getParameter("areaCode");
        System.out.println(areaCode);
        String sigunguCode = request.getParameter("sigunguCode");
        String cat1 = request.getParameter("cat1");
        String cat2 = request.getParameter("cat2");
        String cat3 = request.getParameter("cat3");
        String cPage = request.getParameter("cPage");
        String arrange = request.getParameter("arrange");

        if (cPage == null) {
            cPage = "1";
        }
        if ("trip".equals(pageType)) {
            viewPath = "tripSuggestion.jsp";
        }
        if ("tripUpdate".equals(pageType)) {
            viewPath = "tripSuggestion_update.jsp";
        }
        if ("course".equals(pageType)) {
            viewPath = "tripCourse.jsp";
            contentTypeid = "25";
            rows = "6";
            page = new Paging(6, 5);
        }
        if ("courseUpdate".equals(pageType)) {
            viewPath = "tripCourse_update.jsp";
            contentTypeid = "25";
            rows = "6";
            page = new Paging(6, 5);
        }

        if (contentTypeid == null) {
            contentTypeid = "12";
        }

        if (areaCode == null) {
            areaCode = "1";
        }

        if (arrange == null) {
            arrange = "R";
        }
        //공공데이터 openAPI 호출하는 경로
        //serviceKey=QZqnwRRbk91dk1rSfVmLByXYHxG5LXUX03kbhu31XCqODQh1%2BJAgNigVraqO%2F1sEZtE3mOCC6FV4JZjPXy73xw%3D%3D
        //완희 서비스키
        //serviceKey=UW9L4iVc%2FhRefJdmBeANqq0YpvU1yhx3LHbUSNmSHeZznF70k04tfNjZbpFnasBOtEr1hGTHpkqS9i8zEYUUsQ%3D%3D
        //보은언니 서비스키
        //serviceKey=hPrdpbOAuU8ouxUCNFQ%2B3GhU1eshPcqvNhYV2QamRDzm3Vg32RGIpuEj5jaAGt8AQxVjdhdN5vgymQb6fh6y1w%3D%3D
        //세빈 서비스키
        //serviceKey=%2FBstLSrHchiOl50E4qyAJirb9PM6IhUV1UmaAlefvEfRvM4YLQplX1A0UGtet0vi44M21gibI4l3ldPUz9lQMA%3D%3D
        //준형님 서비스키

        StringBuilder sb = new StringBuilder("http://apis.data.go.kr/B551011/KorService2/areaBasedList2?");
        String key = "serviceKey=QZqnwRRbk91dk1rSfVmLByXYHxG5LXUX03kbhu31XCqODQh1%2BJAgNigVraqO%2F1sEZtE3mOCC6FV4JZjPXy73xw%3D%3D";

//        String startDate = request.getParameter("startDate");
//        if (startDate == null) {
//            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
//            Calendar now = Calendar.getInstance();
//            startDate = sdf.format(now.getTime());
//        }

        //&MobileApp=AppTest&MobileOS=ETC&arrange=C&contentTypeId=12&areaCode=6&cat1=A01
        //&cat2=A0101&cat3=A01010500&_type=xml&numOfRows=10&pageNo=1

        //관광타입(12: 관광지, 14: 문화시설, 15: 축제공연 행사, 25: 여행코스, 28: 레포츠, 32: 숙박, 38: 쇼핑, 39: 음식점) ID
        sb.append(key);
        sb.append("&MobileApp=AppTest&MobileOS=ETC&arrange=");
        sb.append(arrange);
        sb.append("&contentTypeId=");
        sb.append(contentTypeid);
        if ("trip".equals(pageType)||"tripUpdate".equals(pageType)) {
            //cat1 list
            LoCatVO[] cat1_list = GetAPIData.getCat1(request, contentTypeid);
            request.setAttribute("cat1_list", cat1_list);
            sb.append("&areaCode=");
            sb.append(areaCode);
            //시군구코드를 areaCode로 사용해서 list를 받는다.
            LoCatVO[] sigungu_list = GetAPIData.getSigungu(request, areaCode);
            request.setAttribute("sigunguCode_list", sigungu_list);
            if (sigunguCode != null && !sigunguCode.equals("0")) {
                sb.append("&sigunguCode=");
                sb.append(sigunguCode);
            }
            if (cat1 != null && !cat1.equals("0")) {
                LoCatVO[] cat2_list = GetAPIData.getCat2(request, cat1);
                request.setAttribute("cat2_list", cat2_list);
                sb.append("&cat1=");
                sb.append(cat1);
                if (cat2 != null && !cat2.equals("0")) {
                    LoCatVO[] cat3_list = GetAPIData.getCat3(request, cat1, cat2);
                    request.setAttribute("cat3_list", cat3_list);
                    sb.append("&cat2=");
                    sb.append(cat2);
                    if (cat3 != null && !cat3.equals("0")) {
                        sb.append("&cat3=");
                        sb.append(cat3);
                    }
                }
            }
        }
        sb.append("&_type=xml&numOfRows=");
        sb.append(rows);
        sb.append("&pageNo=");
        sb.append(cPage);
        try {
            URL url1 = new URL(sb.toString());
            System.out.println("tripSuggestionAction sb:"+sb.toString());
            HttpURLConnection conn1 = (HttpURLConnection) url1.openConnection();
            conn1.setRequestProperty("Content-Type", "application/xml");
            conn1.connect();
            SAXBuilder builder = new SAXBuilder();
            Document doc = builder.build(conn1.getInputStream());
            Element root = doc.getRootElement();
            Element body = root.getChild("body");
            Element totalCount = body.getChild("totalCount");
            String totalCountStr = null;

            if (totalCount != null) {
                totalCountStr = totalCount.getText();
            }
            if (totalCountStr != null && !totalCountStr.isEmpty()) {
                page.setTotalCount(Integer.parseInt(totalCountStr));
            } else {
                page.setTotalCount(0); // totalCount 값이 비어있을 경우 0으로 설정
            }

            page.setNowPage(Integer.parseInt(cPage));
            Element items = body.getChild("items");
            List<Element> item_list = items.getChildren("item");
            DataVO[] ar = new DataVO[item_list.size()];
            int i = 0;
            for (Element item : item_list) {
                String title = item.getChildText("title"); //자식 태그 안의 문자열
                String mapx = item.getChildText("mapx").trim();
                String mapy = item.getChildText("mapy").trim();
                String addr1 = item.getChildText("addr1");
                String firstimage = item.getChildText("firstimage");
                String tel = item.getChildText("tel");
                String voCat1 = item.getChildText("cat1");
                String voCat2 = item.getChildText("cat2");
                String voCat3 = item.getChildText("cat3");
                String voContentTypeid = item.getChildText("contenttypeid");
                String voContentid = item.getChildText("contentid");
                StringBuffer sb2 = new StringBuffer("https://apis.data.go.kr/B551011/KorService2/detailCommon2?serviceKey=QZqnwRRbk91dk1rSfVmLByXYHxG5LXUX03kbhu31XCqODQh1%2BJAgNigVraqO%2F1sEZtE3mOCC6FV4JZjPXy73xw%3D%3D&MobileApp=AppTest&MobileOS=ETC");
                sb2.append("&_type=xml&contentId=");
                sb2.append(voContentid);
                URL url2 = new URL(sb2.toString());
                System.out.println("tripSuggestionAction sb2:"+sb2.toString());
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
                String homepage = null;
                String homepageUrl = null;
                String homepageText = null;
                String addr2 = null;
                for (Element item2 : item_list2) {
                    overview = item2.getChildText("overview");
                    addr2 = item2.getChildText("addr2");
                    homepage = item2.getChildText("homepage");
                    if (homepage != null && homepage.contains("<a href")) {
                        // URL 추출
                        Pattern urlPattern = Pattern.compile("href=['\"]([^'\"]+)['\"]");
                        Matcher urlMatcher = urlPattern.matcher(homepage);
                        if (urlMatcher.find()) {
                            homepageUrl = urlMatcher.group(1);
                        }

                        // 텍스트 추출
                        Pattern textPattern = Pattern.compile(">(.+?)</a>");
                        Matcher textMatcher = textPattern.matcher(homepage);
                        if (textMatcher.find()) {
                            homepageText = textMatcher.group(1);
                        }
                    } else {
                        // HTML 태그가 없는 경우 그대로 사용
                        homepageUrl = homepage;
                        homepageText = homepage;
                    }
                }
                DataVO vo = new DataVO();
                vo.setTitle(title);
                vo.setMapx(mapx);
                vo.setMapy(mapy);
                vo.setAddr1(addr1);
                vo.setAddr2(addr2);
                vo.setFirstimage(firstimage);
                vo.setTel(tel);
                vo.setContentTypeId(voContentTypeid);
                vo.setContentId(voContentid);
                vo.setOverview(overview);
                vo.setHomepageText(homepageText);
                vo.setHomepageUrl(homepageUrl);
                ar[i++] = vo;
            }
            request.setAttribute("dataAr", ar);
            request.setAttribute("page", page);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return viewPath;
    }

}

