package toour.search.util;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.input.SAXBuilder;
import toour.search.vo.SearchDataVO;

import javax.servlet.http.HttpServletRequest;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

public class GetAPISearchData {
    public static SearchDataVO[] getSearch(HttpServletRequest request, String areaCode){
        SearchDataVO[] ar = null;
        // 전달 받은 SearchDataVO안에 Areacode가 있다면
        if(areaCode != null && areaCode.length()>0){
            //주소 만들기
            StringBuffer sb = new StringBuffer("https://apis.data.go.kr/B551011/KorService2/searchKeyword2?serviceKey=hPrdpbOAuU8ouxUCNFQ%2B3GhU1eshPcqvNhYV2QamRDzm3Vg32RGIpuEj5jaAGt8AQxVjdhdN5vgymQb6fh6y1w%3D%3D&MobileApp=AppTest&MobileOS=ETC");
            sb.append("numOfRows=5");
            sb.append("&");
            sb.append("areaCode=");
            sb.append(areaCode);
            //확인용 주소 출력
            System.out.println(sb.toString());
            try{
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
                ar = new SearchDataVO[item_list.size()];
                int i = 0;
                for (Element item : item_list){
                    String sigungucode = item.getChildText("code"); //자식 태그 안의 문자열
                    String sigunguname = item.getChildText("name");

                    //vo 안에 시군구 코드와 이름만 저장됨
                    SearchDataVO vo = new SearchDataVO();
                    vo.setSigunguCode(sigungucode);
                    vo.setSigunguname(sigunguname);
                    ar[i++] = vo;
                }
                request.setAttribute("ar", ar);
                
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return ar;
    }














}
