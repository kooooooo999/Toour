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
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class sidoDetailsAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        //title, addr1, firstimage, mapx, mapy, contentId
        String title = request.getParameter("title");
        String mapx = request.getParameter("mapx");
        String mapy = request.getParameter("mapy");
        String addr1 = request.getParameter("addr1");
        String firstimage = request.getParameter("firstimage");
        String contentId = request.getParameter("contentId");
        String contentTypeId = request.getParameter("contentTypeId");
        DataVO dataVO = new DataVO();
        dataVO.setTitle(title);
        dataVO.setMapx(mapx);
        dataVO.setMapy(mapy);
        dataVO.setAddr1(addr1);
        dataVO.setFirstimage(firstimage);
        dataVO.setContentId(contentId);
        dataVO.setContentTypeId(contentTypeId);
        try {
            StringBuffer sb2 = new StringBuffer("https://apis.data.go.kr/B551011/KorService2/detailCommon2?serviceKey=UW9L4iVc%2FhRefJdmBeANqq0YpvU1yhx3LHbUSNmSHeZznF70k04tfNjZbpFnasBOtEr1hGTHpkqS9i8zEYUUsQ%3D%3D&MobileApp=AppTest&MobileOS=ETC&_type=xml&contentId=");
            sb2.append(contentId);
            URL url2 = new URL(sb2.toString());
            System.out.println("sidoDetailsAction_sb2:"+sb2.toString());
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
            String homepage = null;
            String homepageUrl = null;
            String homepageText = null;
            String addr2 = null;
            for (Element item2 : item_list2) {
                overview = item2.getChildText("overview");
                addr2 = item2.getChildText("addr2");
                homepage = item2.getChildText("homepage");
                if (homepage != null && homepage.contains("<a href")) {
                    // URL 추출
                    Pattern urlPattern = Pattern.compile("href=['\"]([^'\"]+)['\"]");
                    Matcher urlMatcher = urlPattern.matcher(homepage);
                    if (urlMatcher.find()) {
                        homepageUrl = urlMatcher.group(1);
                    }

                    // 텍스트 추출
                    Pattern textPattern = Pattern.compile(">(.+?)</a>");
                    Matcher textMatcher = textPattern.matcher(homepage);
                    if (textMatcher.find()) {
                        homepageText = textMatcher.group(1);
                    }
                } else {
                    // HTML 태그가 없는 경우 그대로 사용
                    homepageUrl = homepage;
                    homepageText = homepage;
                }
                dataVO.setOverview(overview);
                dataVO.setAddr2(addr2);
                dataVO.setHomepageText(homepageText);
                dataVO.setHomepageUrl(homepageUrl);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        StringBuilder sb = new StringBuilder("http://apis.data.go.kr/B551011/KorService2/detailIntro2?");
        String key = "serviceKey=%2FBstLSrHchiOl50E4qyAJirb9PM6IhUV1UmaAlefvEfRvM4YLQplX1A0UGtet0vi44M21gibI4l3ldPUz9lQMA%3D%3D";

        sb.append(key);
        sb.append("&MobileApp=AppTest&MobileOS=ETC&pageNo=1");
//        sb.append(cPage);
//        System.out.println("cPage"+cPage);
        sb.append("&numOfRows=5&_type=xml&contentTypeId=12&contentId=");
        sb.append(contentId);
        System.out.println("sb = " + sb.toString());

        try {
            URL url = new URL(sb.toString());
            System.out.println("sidoDetailsAction_sb:"+sb.toString());
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestProperty("Content-Type", "application/xml");
            conn.connect();
            SAXBuilder builder = new SAXBuilder();
            Document doc = builder.build(conn.getInputStream());
            Element root = doc.getRootElement();
            Element body = root.getChild("body");
            Element items = body.getChild("items");
            List<Element> itemList = items.getChildren("item");
            DataVO[] dvo_ar = new DataVO[itemList.size()];
            int i =0;
            for (Element item : itemList) {
                String infocenter = item.getChildText("infocenter"); //문의안내
                String parking = item.getChildText("parking"); //주차시설
                String restdate = item.getChildText("restdate"); //쉬는날
                String usetime = item.getChildText("usetime"); //이용시간
                DataVO dvo = new DataVO(infocenter, parking, restdate, usetime);
                dvo_ar[i++] =dvo;
            }
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

            request.setAttribute("detailsAr", dataVO);
            request.setAttribute("detailsAr_2", dvo_ar);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "tripDetails.jsp";
    }
}
