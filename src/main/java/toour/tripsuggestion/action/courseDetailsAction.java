package toour.tripsuggestion.action;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.input.SAXBuilder;
import toour.action.Action;
import toour.tripsuggestion.vo.DataVO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import static toour.util.GetAPIData.getContenttyIdlist;

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
        String totalCount = request.getParameter("totalCount");
        DataVO dvo = new DataVO(title, addr1, overview, firstimage, mapx1, mapy1, homepageUrl, homepageText, totalCount);
        request.setAttribute("getAr", dvo);
//      추천코스정보
        StringBuilder sb1 = new StringBuilder("http://apis.data.go.kr/B551011/KorService2/detailInfo2?");
        String key = "serviceKey=hPrdpbOAuU8ouxUCNFQ%2B3GhU1eshPcqvNhYV2QamRDzm3Vg32RGIpuEj5jaAGt8AQxVjdhdN5vgymQb6fh6y1w%3D%3D";
        sb1.append(key);
        sb1.append("&MobileApp=AppTest&MobileOS=ETC&pageNo=1&numOfRows=");
        sb1.append(totalCount);
        sb1.append("&_type=xml&contentTypeId=");
        sb1.append(contentTypeId);
        sb1.append("&contentId=");
        sb1.append(contentId);
//      추천코스에 대한 정보
        StringBuilder sb3 = new StringBuilder("http://apis.data.go.kr/B551011/KorService2/detailIntro2?");
        sb3.append(key);
        sb3.append("&MobileApp=AppTest&MobileOS=ETC&pageNo=1&numOfRows=");
        sb3.append(totalCount);
        sb3.append("&_type=xml&contentTypeId=");
        sb3.append(contentTypeId);
        sb3.append("&contentId=");
        sb3.append(contentId);

        try {
            URL url1 = new URL(sb1.toString());
            HttpURLConnection conn1 = (HttpURLConnection) url1.openConnection();
            conn1.setRequestProperty("Content-Type", "application/xml");
            conn1.connect();
            SAXBuilder builder1 = new SAXBuilder();
            Document doc1 = builder1.build(conn1.getInputStream());
            Element root1 = doc1.getRootElement();
            Element body1 = root1.getChild("body");
            Element totalCount2 = body1.getChild("totalCount");
            String totalCountStr = totalCount2.getText();
            Element items1 = body1.getChild("items");
            List<Element> itemList1 = items1.getChildren("item");
            List<DataVO> arList = new ArrayList<>();
//          Hashset 중복데이터 저장 X
            Set<DataVO> restaurantSet = new HashSet<>();
            Set<DataVO> accommodationSet = new HashSet<>();

            URL url3 = new URL(sb3.toString());
            HttpURLConnection conn3 = (HttpURLConnection) url3.openConnection();
            conn3.setRequestProperty("Content-Type", "application/xml");
            conn3.connect();
            SAXBuilder builder3 = new SAXBuilder();
            Document doc3 = builder3.build(conn3.getInputStream());
            Element root3 = doc3.getRootElement();
            Element body3 = root3.getChild("body");
            Element items3 = body3.getChild("items");
            List<Element> itemList3 = items3.getChildren("item");
            DataVO[] ddv = new DataVO[itemList3.size()];
            int i = 0;
            for (Element item3 : itemList3) {
                String distance = item3.getChildText("distance");
                String schedule = item3.getChildText("schedule");
                String theme = item3.getChildText("theme");
                DataVO ddvo = new DataVO(distance, schedule, theme);
                ddv[i++] = ddvo;
            }
            request.setAttribute("courseInfo", ddv);

            for (Element item1 : itemList1) {
                String subcontentid = item1.getChildText("subcontentid");
                String subdetailalt = item1.getChildText("subdetailalt");
                String subdetailimg = item1.getChildText("subdetailimg");
                String subdetailoverview = item1.getChildText("subdetailoverview");
                String subname = item1.getChildText("subname");
                //좌표 얻기
                StringBuilder sb2 = new StringBuilder("https://apis.data.go.kr/B551011/KorService2/detailCommon2?serviceKey=hPrdpbOAuU8ouxUCNFQ%2B3GhU1eshPcqvNhYV2QamRDzm3Vg32RGIpuEj5jaAGt8AQxVjdhdN5vgymQb6fh6y1w%3D%3D&MobileApp=AppTest&MobileOS=ETC&_type=xml&contentId=");
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
                for (Element item2 : itemList2) {
                    String mapx2 = item2.getChildText("mapx");
                    String mapy2 = item2.getChildText("mapy");
                    DataVO vo = new DataVO(subcontentid, subdetailalt, subdetailimg, subdetailoverview, subname, mapx2, mapy2, totalCountStr);
                    arList.add(vo);
                }
            }
            List<DataVO> rList = getContenttyIdlist("39", arList.get(arList.size() - 1).getMapx(), arList.get(arList.size() - 1).getMapy(), key, "30000");
            restaurantSet.addAll(rList);
            List<DataVO> aList = getContenttyIdlist("32", arList.get(arList.size() - 1).getMapx(), arList.get(arList.size() - 1).getMapy(), key, "30000");
            accommodationSet.addAll(aList);

            request.setAttribute("couserAr", arList);
            request.setAttribute("restaurantSet", restaurantSet);
            request.setAttribute("accommodationSet", accommodationSet);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "courseDetails.jsp";
    }
}
