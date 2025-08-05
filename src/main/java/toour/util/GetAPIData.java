package toour.util;

import toour.tripsuggestion.vo.DataVO;
import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.input.SAXBuilder;

import javax.servlet.http.HttpServletRequest;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

public class GetAPIData {
    public static DataVO[] getSigungu(HttpServletRequest request, String areaCode) {
        DataVO[] ar = null;
        // 전달 받은 DataVO안에 Areacode가 있다면
        if(areaCode!=null &&areaCode.length()>0) {
            //주소 만들기
            StringBuffer sb = new StringBuffer("http://apis.data.go.kr/B551011/KorService2/areaCode2?serviceKey=%2FBstLSrHchiOl50E4qyAJirb9PM6IhUV1UmaAlefvEfRvM4YLQplX1A0UGtet0vi44M21gibI4l3ldPUz9lQMA%3D%3D&MobileApp=AppTest&MobileOS=ETC");
            sb.append("&numOfRows=1000");
            sb.append("&");
            sb.append("areaCode=");
            sb.append(areaCode);
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
                ar = new DataVO[item_list.size()];
                int i = 0;
                for (Element item : item_list) {
                    String sigungucode = item.getChildText("code"); //자식 태그 안의 문자열
                    String sigunguname = item.getChildText("name");

                    //vo 안에 시군구 코드와 이름만 저장됨
                    DataVO vo = new DataVO();
                    vo.setSigungucode(sigungucode);
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

    public static DataVO[] getCat1(HttpServletRequest request,String contentTypeId){
        DataVO[] ar = null;
        //주소 만들기
        StringBuffer sb = new StringBuffer("http://apis.data.go.kr/B551011/KorService2/categoryCode2?serviceKey=gxF3vfrb%2FWP6p4M7q4vJqTpmSyZQogbuDVs4U98InkzW4uD7lV0STqbC5BDflGo4im41%2FXxSd97oH1jEUkORUw%3D%3D&MobileApp=AppTest&MobileOS=ETC");
        sb.append("&numOfRows=1000");
        sb.append("&");
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
            ar = new DataVO[item_list.size()];
            int i = 0;
            for (Element item : item_list) {
                String cat1code = item.getChildText("code"); //자식 태그 안의 문자열
                String cat1name = item.getChildText("name");

                //vo 안에 시군구 코드와 이름만 저장됨
                DataVO vo = new DataVO();
                vo.setCat1(cat1code);
                vo.setCat1name(cat1name);
                ar[i++] = vo;
            }
            request.setAttribute("ar", ar);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ar;
    }

    public static DataVO[] getCat2(HttpServletRequest request, String cat1){
        DataVO[] ar = null;
        if(cat1!=null&&cat1.length()>0) {
            //주소 만들기
            StringBuffer sb = new StringBuffer("http://apis.data.go.kr/B551011/KorService2/categoryCode2?serviceKey=gxF3vfrb%2FWP6p4M7q4vJqTpmSyZQogbuDVs4U98InkzW4uD7lV0STqbC5BDflGo4im41%2FXxSd97oH1jEUkORUw%3D%3D&MobileApp=AppTest&MobileOS=ETC");
            sb.append("&numOfRows=1000");
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
                ar = new DataVO[item_list.size()];
                int i = 0;
                for (Element item : item_list) {
                    String cat2code = item.getChildText("code"); //자식 태그 안의 문자열
                    String cat2name = item.getChildText("name");

                    //vo 안에 시군구 코드와 이름만 저장됨
                    DataVO vo = new DataVO();
                    vo.setCat2(cat2code);
                    vo.setCat2name(cat2name);
                    ar[i++] = vo;
                }
                request.setAttribute("ar", ar);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return ar;
    }


    public static DataVO[] getCat3(HttpServletRequest request,String cat1, String cat2){
        DataVO[] ar = null;
        if(cat1!=null&&cat1.length()>0&&cat2!=null&&cat2.length()>0) {
            //주소 만들기
            StringBuffer sb = new StringBuffer("http://apis.data.go.kr/B551011/KorService2/categoryCode2?serviceKey=gxF3vfrb%2FWP6p4M7q4vJqTpmSyZQogbuDVs4U98InkzW4uD7lV0STqbC5BDflGo4im41%2FXxSd97oH1jEUkORUw%3D%3D&MobileApp=AppTest&MobileOS=ETC");
            sb.append("&numOfRows=1000");
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
                ar = new DataVO[item_list.size()];
                int i = 0;
                for (Element item : item_list) {
                    String cat3code = item.getChildText("code"); //자식 태그 안의 문자열
                    String cat3name = item.getChildText("name");

                    //vo 안에 시군구 코드와 이름만 저장됨
                    DataVO vo = new DataVO();
                    vo.setCat3(cat3code);
                    vo.setCat3name(cat3name);
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
