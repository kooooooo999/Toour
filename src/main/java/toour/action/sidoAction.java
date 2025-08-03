package toour.action;

import mybatis.vo.CityInfoVO;
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

        //&MobileApp=AppTest&MobileOS=ETC&arrange=C&contentTypeId=12&areaCode=6&cat1=A01
        //&cat2=A0101&cat3=A01010500&_type=xml&numOfRows=10&pageNo=1

        //관광타입(12: 관광지, 14: 문화시설, 15: 축제공연 행사, 25: 여행코스, 28: 레포츠, 32: 숙박, 38: 쇼핑, 39: 음식점) ID
        sb.append(key);
        sb.append("&MobileApp=AppTest&MobileOS=ETC&arrange=O&contentTypeId=12");
        sb.append("&areaCode=");
        sb.append(areaCode);
        sb.append("&_type=xml&numOfRows=4&pageNo=");
        sb.append(cPage);
        //System.out.println(sb.toString());

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
            CityInfoVO[] ar = new CityInfoVO[item_list.size()];
            int i = 0;
            for (Element item : item_list) {
                String title = item.getChildText("title"); //자식 태그 안의 문자열
                String addr1 = item.getChildText("addr1");
                String firstimage = item.getChildText("firstimage");

                CityInfoVO vo = new CityInfoVO(title, firstimage, addr1);
                ar[i++] = vo;
            }
            request.setAttribute("ar2", ar);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "sidoInfo.jsp";
    }

}