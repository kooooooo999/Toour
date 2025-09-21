package toour.search.util;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.input.SAXBuilder;
import toour.search.vo.SearchDataVO;
import toour.tripsuggestion.vo.LoCatVO;

import javax.servlet.http.HttpServletRequest;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

public class GetAPISearchData {
    public static SearchDataVO[] getSearch(HttpServletRequest request, String keyword){
        SearchDataVO[] ar = null;
        // 전달 받은 SearchDataVO안에 키워드가 있다면
        if(keyword != null && keyword.length()>0){
            //https://apis.data.go.kr/B551011/KorService2/searchKeyword2?serviceKey=서비스인증키&MobileApp=AppTest&MobileOS=ETC
            // &pageNo=1&numOfRows=10&keyword=시장&cat1=A04&cat2=A0401&cat3=A04010100&arrange=C
            // &areaCode=39&sigunguCode=3&_type=json
            // &lDongRegnCd=50&lDongSignguCd=130&lclsSystm1=SH&lclsSystm2=SH06&lclsSystm3=SH060100
            //주소 만들기
            StringBuffer sb = new StringBuffer("https://apis.data.go.kr/B551011/KorService2/searchKeyword2?serviceKey=hPrdpbOAuU8ouxUCNFQ%2B3GhU1eshPcqvNhYV2QamRDzm3Vg32RGIpuEj5jaAGt8AQxVjdhdN5vgymQb6fh6y1w%3D%3D&MobileApp=AppTest&MobileOS=ETC");
            sb.append("&pageNo=1&numOfRows=5");
            sb.append("&");
            sb.append("keyword=");
            sb.append(keyword);


            /*sb.append("areaCode=");
            sb.append(areaCode);*/
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

    public static LoCatVO[] getCat1(HttpServletRequest request, String contentTypeId){
        LoCatVO[] ar = null;
        //주소 만들기
        StringBuffer sb = new StringBuffer("https://apis.data.go.kr/B551011/KorService2/searchKeyword2?serviceKey=hPrdpbOAuU8ouxUCNFQ%2B3GhU1eshPcqvNhYV2QamRDzm3Vg32RGIpuEj5jaAGt8AQxVjdhdN5vgymQb6fh6y1w%3D%3D&MobileApp=AppTest&MobileOS=ETC");
        sb.append("&numOfRows=5");
        sb.append("&contentTypeId=");
        sb.append(contentTypeId);
        //확인용 주소 출력
        System.out.println(sb.toString());
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
            ar = new LoCatVO[item_list.size()];
            int i = 0;
            for (Element item : item_list) {
                String cat1code = item.getChildText("code"); //자식 태그 안의 문자열
                String cat1name = item.getChildText("name");

                //vo 안에 시군구 코드와 이름만 저장됨
                LoCatVO vo = new LoCatVO();
                vo.setCode(cat1code);
                vo.setName(cat1name);
                ar[i++] = vo;
            }
            request.setAttribute("cat1Ar", ar);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ar;
    }

    public static LoCatVO[] getCat2(HttpServletRequest request, String cat1){
        LoCatVO[] ar = null;
        if(cat1!=null&&cat1.length()>0){
            //주소 만들기
            StringBuffer sb = new StringBuffer("https://apis.data.go.kr/B551011/KorService2/searchKeyword2?serviceKey=hPrdpbOAuU8ouxUCNFQ%2B3GhU1eshPcqvNhYV2QamRDzm3Vg32RGIpuEj5jaAGt8AQxVjdhdN5vgymQb6fh6y1w%3D%3D&MobileApp=AppTest&MobileOS=ETC");
            sb.append("&numOfRows=5");
            sb.append("&");
            sb.append("cat1=");
            sb.append(cat1);
            //확인용 주소 출력
            System.out.println(sb.toString());
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
                ar = new LoCatVO[item_list.size()];
                int i = 0;
                for (Element item : item_list) {
                    String cat2code = item.getChildText("code"); //자식 태그 안의 문자열
                    String cat2name = item.getChildText("name");

                    //vo 안에 시군구 코드와 이름만 저장됨
                    LoCatVO vo = new LoCatVO();
                    vo.setCode(cat2code);
                    vo.setName(cat2name);
                    ar[i++] = vo;
                }
                request.setAttribute("cat2Ar", ar);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return ar;
    }

    public static LoCatVO[] getCat3(HttpServletRequest request, String cat1, String cat2){
        LoCatVO[] ar = null;
        if(cat1!=null&& cat1.length()>0&&cat2!=null&&cat2.length()>0){
            //주소 만들기
            StringBuffer sb = new StringBuffer("https://apis.data.go.kr/B551011/KorService2/searchKeyword2?serviceKey=hPrdpbOAuU8ouxUCNFQ%2B3GhU1eshPcqvNhYV2QamRDzm3Vg32RGIpuEj5jaAGt8AQxVjdhdN5vgymQb6fh6y1w%3D%3D&MobileApp=AppTest&MobileOS=ETC");
            sb.append("&numOfRows=5");
            sb.append("&");
            sb.append("cat1=");
            sb.append(cat1);
            sb.append("&");
            sb.append("cat2=");
            sb.append(cat2);
            //확인용 주소 출력
            System.out.println(sb.toString());
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
                ar = new LoCatVO[item_list.size()];
                int i = 0;
                for (Element item : item_list) {
                    String cat3code = item.getChildText("code"); //자식 태그 안의 문자열
                    String cat3name = item.getChildText("name");

                    //vo 안에 시군구 코드와 이름만 저장됨
                    LoCatVO vo = new LoCatVO();
                    vo.setCode(cat3code);
                    vo.setName(cat3name);
                    ar[i++] = vo;
                }
                request.setAttribute("cat3Ar", ar);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return ar;
    }
}
