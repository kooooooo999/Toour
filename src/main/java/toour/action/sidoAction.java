package toour.action;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.input.SAXBuilder;
import mybatis.vo.DataVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

public class sidoAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        //공공데이터 openAPI 호출하는 경로
        //http://apis.data.go.kr/B551011/KorService2/areaBasedList2?serviceKey=서비스인증키

        StringBuilder sb = new StringBuilder("http://apis.data.go.kr/B551011/KorService2/areaBasedList2?");
        String key = "serviceKey=gxF3vfrb%2FWP6p4M7q4vJqTpmSyZQogbuDVs4U98InkzW4uD7lV0STqbC5BDflGo4im41%2FXxSd97oH1jEUkORUw%3D%3D";
        String areaCode = null;
        String code = request.getParameter("areaCode");
        if (code == null) {
            areaCode = "6";
        } else {
            areaCode = code;
        }
        String cPage = request.getParameter("cPage");
        if (cPage == null) {
            cPage = "1";
        }
        String startDate = request.getParameter("startDate");
        if (startDate == null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
            Calendar now = Calendar.getInstance();
            startDate = sdf.format(now.getTime());
        }
        String contentType = request.getParameter("contentTypeId");
        if (contentType == null) {
            contentType = "12";
        }

        String cat_1 = request.getParameter("cat1");
        String cat_2 = request.getParameter("cat2");
        String cat_3 = request.getParameter("cat3");
        if (cat_1 == null) {
            cat_1 = "A01";
        }
        if (cat_2 == null) {
            cat_2 = "A0101";
        }
        if (cat_3 == null) {
            cat_3 = "A01010500";
        }

        //&MobileApp=AppTest&MobileOS=ETC&arrange=C&contentTypeId=12&areaCode=6&cat1=A01
        //&cat2=A0101&cat3=A01010500&_type=xml&numOfRows=10&pageNo=1

        //관광타입(12: 관광지, 14: 문화시설, 15: 축제공연 행사, 25: 여행코스, 28: 레포츠, 32: 숙박, 38: 쇼핑, 39: 음식점) ID
        sb.append(key);
        sb.append("&MobileApp=AppTest&MobileOS=ETC&arrange=C&contentTypeId=");
        sb.append(contentType);
        sb.append("&areaCode=");
        sb.append(areaCode);
        sb.append("&cat1=");
        sb.append(cat_1);
        sb.append("&cat2=");
        sb.append(cat_2);
        sb.append("&cat3=");
        sb.append(cat_3);
        sb.append("&_type=xml&numOfRows=10&pageNo=");
        sb.append(cPage);

        try {
            URL url1 = new URL(sb.toString());
            HttpURLConnection conn1 = (HttpURLConnection) url1.openConnection();
            conn1.setRequestProperty("Content-Type", "application/xml");
            conn1.connect();
            SAXBuilder builder = new SAXBuilder();
            Document doc = builder.build(conn1.getInputStream());
            Element root = doc.getRootElement();
            Element body = root.getChild("body");
            Element items = body.getChild("items");
            List<Element> item_list = items.getChildren("item");
            DataVO[] ar = new DataVO[item_list.size()];
            int i = 0;
            for (Element item : item_list) {
                String title = item.getChildText("title"); //자식 태그 안의 문자열
                String mapx = item.getChildText("mapx");
                String mapy = item.getChildText("mapy");
                String addr1 = item.getChildText("addr1");
                String addr2 = item.getChildText("addr2");
                String firstimage = item.getChildText("firstimage");
                String firstimage2 = item.getChildText("firstimage2");
                String tel = item.getChildText("tel");
                String eventstartdate = item.getChildText("eventstartdate");
                String eventenddate = item.getChildText("eventenddate");
                String cat1 = item.getChildText("cat1");
                String cat2 = item.getChildText("cat2");
                String cat3 = item.getChildText("cat3");
                String contentTypeId = item.getChildText("contenttypeid");
                String contentId = item.getChildText("contentid");

                StringBuffer sb2 = new StringBuffer("https://apis.data.go.kr/B551011/KorService2/detailCommon2?serviceKey=QZqnwRRbk91dk1rSfVmLByXYHxG5LXUX03kbhu31XCqODQh1%2BJAgNigVraqO%2F1sEZtE3mOCC6FV4JZjPXy73xw%3D%3D&MobileApp=AppTest&MobileOS=ETC&pageNo=");
                sb2.append(cPage);
                sb2.append("&numOfRows=10&_type=xml&contentId=");
                sb2.append(contentId);
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
                DataVO vo = new DataVO(title, mapx, mapy, addr1, addr2, firstimage, firstimage2, eventstartdate, eventenddate, tel, cat1, cat2, cat3, contentTypeId, contentId, overview);
                ar[i++] = vo;
            }
            request.setAttribute("ar", ar);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "sidoInfo.jsp";
    }

}