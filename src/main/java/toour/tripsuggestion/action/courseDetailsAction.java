package toour.tripsuggestion.action;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.input.SAXBuilder;
import toour.action.Action;
import toour.tripsuggestion.vo.DataVO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

public class courseDetailsAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //https://apis.data.go.kr/B551011/KorService2/detailInfo2?serviceKey=QZqnwRRbk91dk1rSfVmLByXYHxG5LXUX03kbhu31XCqODQh1%2BJAgNigVraqO%2F1sEZtE3mOCC6FV4JZjPXy73xw%3D%3D
        //&MobileApp=AppTest&MobileOS=ETC&pageNo=1&numOfRows=20&_type=xml&contentTypeId=25&contentId=3517031
        String contentTypeId = request.getParameter("contentTypeId");
        String contentId = request.getParameter("contentId");
        String title = request.getParameter("title");
        String addr1 = request.getParameter("addr1");
        String overview = request.getParameter("overview");
        String firstimage = request.getParameter("firstimage");
        String mapx1 = request.getParameter("mapx");
        String mapy1 = request.getParameter("mapy");
        String homepageUrl = request.getParameter("homepageUrl");
        String homepageText = request.getParameter("homepageText");

        StringBuilder sb1 = new StringBuilder("http://apis.data.go.kr/B551011/KorService2/detailInfo2?");
        String key = "serviceKey=QZqnwRRbk91dk1rSfVmLByXYHxG5LXUX03kbhu31XCqODQh1%2BJAgNigVraqO%2F1sEZtE3mOCC6FV4JZjPXy73xw%3D%3D";

        sb1.append(key);
        sb1.append("&MobileApp=AppTest&MobileOS=ETC&numOfRows=1&_type=xml&contentTypeId=");
        sb1.append(contentTypeId);
        sb1.append("&contentId=");
        sb1.append(contentId);
        sb1.append("&pageNo=1");
//        sb.append(cPage);
        System.out.println("courseAction: "+sb1.toString());
        try {
            URL url1 = new URL(sb1.toString());
            HttpURLConnection conn1 = (HttpURLConnection) url1.openConnection();
            conn1.setRequestProperty("Content-Type", "application/xml");
            conn1.connect();
            SAXBuilder builder1 = new SAXBuilder();
            Document doc1 = builder1.build(conn1.getInputStream());
            Element root1 = doc1.getRootElement();
            Element body1 = root1.getChild("body");
            Element items1 = body1.getChild("items");
            List<Element> itemList1 = items1.getChildren("item");
            DataVO[] ar =  new DataVO[itemList1.size()];
            int i = 0;
            for (Element item : itemList1) {
                String subcontentid =  item.getChildText("subcontentid");
                String subdetailalt =   item.getChildText("subdetailalt");
                String subdetailimg =   item.getChildText("subdetailimg");
                String subdetailoverview =   item.getChildText("subdetailoverview");
                String subname =   item.getChildText("subname");
                StringBuilder sb2 = new StringBuilder("https://apis.data.go.kr/B551011/KorService2/detailCommon2?serviceKey=QZqnwRRbk91dk1rSfVmLByXYHxG5LXUX03kbhu31XCqODQh1%2BJAgNigVraqO%2F1sEZtE3mOCC6FV4JZjPXy73xw%3D%3D&MobileApp=AppTest&MobileOS=ETC&_type=xml&contentId=");
                DataVO vo = new DataVO(subcontentid, subdetailalt, subdetailimg, subdetailoverview, subname);
                sb2.append(subcontentid);
                URL url2 = new URL(sb2.toString());
                HttpURLConnection conn2 = (HttpURLConnection) url2.openConnection();
                conn2.setRequestProperty("Content-Type", "application/xml");
                conn2.connect();
                SAXBuilder builder2 = new SAXBuilder();
                Document doc2 = builder2.build(conn2.getInputStream());
                Element root2 = doc2.getRootElement();
                Element body2 = root2.getChild("body");
                Element items2 = body2.getChild("items");
                List<Element> itemList2 = items2.getChildren("item");
                for(Element item2 : itemList2) {
                    String mapx2 = item2.getChildText("mapx");
                    String mapy2 = item2.getChildText("mapy");
                    System.out.println("mapx1:"+mapx1);
                    System.out.println("mapy1:"+mapy1);
                    System.out.println("mapx2:"+mapx2);
                    System.out.println("mapy2:"+mapy2);
                }
                ar[i++] = vo;
            }
            request.setAttribute("couserAr", ar);
        }catch (Exception e){
            e.printStackTrace();
        }

        RequestDispatcher rd = request.getRequestDispatcher("Controller?type=tripSuggestion&pageType=courseDetails");
        rd.forward(request,response);

        return null;
    }
}
