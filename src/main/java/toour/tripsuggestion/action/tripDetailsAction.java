package toour.tripsuggestion.action;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.input.SAXBuilder;
import toour.action.Action;
import toour.member.dao.ZzimDAO;
import toour.member.vo.MemberVO;
import toour.member.vo.ZzimVO;
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

        //찜 목록에 해당 관광지가 속해 있는지 확인하고 있다면 하트를 채워 놓기 위해 신호를 보내는 곳
        boolean zzim_state = false;
        ZzimVO[] zzim_ar = null;
        if (contentId != null) {
            Object obj = request.getSession().getAttribute("member");
            MemberVO mvo = null;
            if (obj != null) {
                mvo = (MemberVO) obj;
                zzim_ar = ZzimDAO.getZzimAr(mvo.getMember_idx());
                if (zzim_ar != null) {
                    for (ZzimVO zvo : zzim_ar) {
                        if (contentId.equals(zvo.getZzim_content_id())) {
                            zzim_state = true;
                            break;
                        }
                    }
                }
            }
        }
        request.setAttribute("zzim_state", zzim_state);

        //http://apis.data.go.kr/B551011/KorService2/detailIntro2?serviceKey=인증키
        //&MobileApp=AppTest&MobileOS=ETC&pageNo=1&numOfRows=10&_type=json&contentTypeId=12&contentId=
        //126128
        StringBuilder sb = new StringBuilder("http://apis.data.go.kr/B551011/KorService2/detailIntro2?");
        String key = "serviceKey=QZqnwRRbk91dk1rSfVmLByXYHxG5LXUX03kbhu31XCqODQh1%2BJAgNigVraqO%2F1sEZtE3mOCC6FV4JZjPXy73xw%3D%3D";

        sb.append(key);
        sb.append("&MobileApp=AppTest&MobileOS=ETC&pageNo=1");
//        sb.append(cPage);
//        System.out.println("cPage"+cPage);
        sb.append("&numOfRows=5&_type=xml&contentTypeId=");
        sb.append(contentTypeId);
        sb.append("&contentId=");
        sb.append(contentId);

        try {
            System.out.println("sb?:"+sb.toString());
            URL url = new URL(sb.toString());
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestProperty("Content-Type", "application/xml");
            conn.connect();
            SAXBuilder builder = new SAXBuilder();
            Document doc = builder.build(conn.getInputStream());
            Element root = doc.getRootElement();
            Element body = root.getChild("body");
            Element items = body.getChild("items");
            List<Element> itemList = items.getChildren("item");
            DataVO[] dvo = new DataVO[itemList.size()];
            int i = 0;
            for (Element item : itemList) {
                String infocenter = item.getChildText("infocenter"); //문의안내
                String parking = item.getChildText("parking"); //주차시설
                String restdate = item.getChildText("restdate"); //쉬는날
                String usetime = item.getChildText("usetime"); //이용시간
                DataVO vo = new DataVO(infocenter, parking, restdate, usetime);
                dvo[i++] = vo;
            }
            System.out.println("dvo[0]:"+dvo[0]);
            request.setAttribute("detailsAr_2", dvo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "tripDetails.jsp";
    }
}
