package toour.tripsuggestion.action;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.input.SAXBuilder;
import toour.action.Action;
import toour.tripsuggestion.vo.DataVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

public class tripDetailsAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String title = request.getParameter("title");
        String addr1 = request.getParameter("addr1");
        String overview = request.getParameter("overview");
        String firstimage = request.getParameter("firstimage");
        String mapx = request.getParameter("mapx");
        String mapy = request.getParameter("mapy");
        String contentTypeId = request.getParameter("contentTypeId");
        String contentId = request.getParameter("contentId");
        String cPage = request.getParameter("cPage");
        String homepageUrl = request.getParameter("homepageUrl");
        String homepageText = request.getParameter("homepageText");
        DataVO datavo = new DataVO(title, addr1, overview, firstimage, mapx, mapy, contentTypeId, contentId, cPage, homepageText, homepageUrl);
        request.setAttribute("detailsAr", datavo);
        //http://apis.data.go.kr/B551011/KorService2/detailIntro2?serviceKey=인증키
        //&MobileApp=AppTest&MobileOS=ETC&pageNo=1&numOfRows=10&_type=json&contentTypeId=12&contentId=
        //126128
        StringBuilder sb = new StringBuilder("http://apis.data.go.kr/B551011/KorService2/detailIntro2?");
        String key = "serviceKey=UW9L4iVc%2FhRefJdmBeANqq0YpvU1yhx3LHbUSNmSHeZznF70k04tfNjZbpFnasBOtEr1hGTHpkqS9i8zEYUUsQ%3D%3D";

        sb.append(key);
        sb.append("&MobileApp=AppTest&MobileOS=ETC&pageNo=1");
//        sb.append(cPage);
//        System.out.println("cPage"+cPage);
        sb.append("&numOfRows=5&_type=xml&contentTypeId=");
        sb.append(contentTypeId);
        sb.append("&contentId=");
        sb.append(contentId);

        try{
            URL url =  new URL(sb.toString());
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestProperty("Content-Type", "application/xml");
            conn.connect();
            SAXBuilder builder = new SAXBuilder();
            Document doc = builder.build(conn.getInputStream());
            Element root = doc.getRootElement();
            Element body = root.getChild("body");
            Element items = body.getChild("items");
            List<Element> itemList = items.getChildren("item");
            DataVO[] dvo =  new DataVO[itemList.size()];
            int i = 0;
            for (Element item : itemList) {
                String infocenter =  item.getChildText("infocenter"); //문의안내
                String parking =   item.getChildText("parking"); //주차시설
                String restdate =  item.getChildText("restdate"); //쉬는날
                String usetime =   item.getChildText("usetime"); //이용시간
                DataVO vo = new DataVO(infocenter, parking, restdate, usetime);
                dvo[i++] = vo;
            }
            request.setAttribute("detailsAr_2", dvo);
        }catch(Exception e){
            e.printStackTrace();
        }
        return "tripDetails.jsp";
    }
}
