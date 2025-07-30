package mybatis.action;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.input.SAXBuilder;
import sist.vo.DataVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

public class IndexAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response){

        //공공데이터 openAPI 호출하는 경로
        //http://apis.data.go.kr/B551011/KorService2/areaBasedList2?serviceKey=서비스인증키

        StringBuilder sb = new StringBuilder("http://apis.data.go.kr/B551011/KorService2/areaBasedList2?");
        String key = "serviceKey=QZqnwRRbk91dk1rSfVmLByXYHxG5LXUX03kbhu31XCqODQh1%2BJAgNigVraqO%2F1sEZtE3mOCC6FV4JZjPXy73xw%3D%3D";
        String areaCode = null;
        String code = request.getParameter("areaCode");
        if (code == null) {
            areaCode = "6";
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
        String typeId = request.getParameter("typeId");
        if (typeId == null) {
            typeId = "12";
        }

        String cat_1 = request.getParameter("cat1");
        String cat_2 = request.getParameter("cat2");
        String cat_3 = request.getParameter("cat3");
        if(cat_1 == null){
            cat_1 = "A01";
        }
        if(cat_2 == null){
            cat_2 = "A0101";
        }
        if(cat_3 == null){
            cat_3 = "A01010500";
        }

        //&MobileApp=AppTest&MobileOS=ETC&arrange=C&contentTypeId=12&areaCode=6&cat1=A01
        //&cat2=A0101&cat3=A01010500&_type=xml&numOfRows=10&pageNo=1

        //관광타입(12: 관광지, 14: 문화시설, 15: 축제공연 행사, 25: 여행코스, 28: 레포츠, 32: 숙박, 38: 쇼핑, 39: 음식점) ID
        sb.append(key);
        sb.append("&MobileApp=AppTest&MobileOS=ETC&arrange=C&contentTypeId=");
        sb.append(typeId);
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
            //브라우저창에서 경로(url)를 입력하고 요청하듯이 프로그램 상에서 요청할 때는 url객체를 만들어야한다
            URL url = new URL(sb.toString());
            //경로를 연결하는 객체
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            //응답 받을 데이터의 형식을 지정
            conn.setRequestProperty("Content-Type", "application/xml");
            //연결 -> 이제 요청
            conn.connect();
            //JDOM 라이브러리에 있는 SAXBuilder 를 통해 응답메세지를 XML 문서화 시키기 위해 준비
            SAXBuilder builder = new SAXBuilder();
            //응답되는 내용을 하나의 XML 의 문서(Document)로 인식해야한다
            Document doc = builder.build(conn.getInputStream());
            Element root = doc.getRootElement();
            System.out.println(root.getName());
            //루트안에 있는 body만 얻어낸다
            Element body = root.getChild("body");
            //body 안에 있는 items
            Element items = body.getChild("items");
            //items 안에 존재하는 모든 item만 가져온다
            List<Element> item_list = items.getChildren("item");
            //item 들을 JSP 에서 표현하기 위해 배열로 변환하여 request에 저장
            DataVO[] ar =  new DataVO[item_list.size()];
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
                String contentTypeId = item.getChildText("contentTypeId");

                DataVO vo = new DataVO(title, mapx, mapy, addr1, addr2, firstimage, firstimage2, tel, eventstartdate, eventenddate, cat1, cat2, cat3, contentTypeId);
                ar[i++] = vo;
            }
            request.setAttribute("ar", ar);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "index.jsp";
    }
}
