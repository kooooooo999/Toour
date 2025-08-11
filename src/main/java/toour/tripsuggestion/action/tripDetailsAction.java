package toour.tripsuggestion.action;

import toour.action.Action;
import toour.tripsuggestion.vo.DataVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

        DataVO Dvo = new DataVO(title, addr1, overview, firstimage, mapx, mapy, contentTypeId, contentId);
        request.setAttribute("detailsAr", Dvo);

        StringBuilder sb = new StringBuilder("http://apis.data.go.kr/B551011/KorService2/detailIntro2?");
        String key = "serviceKey=UW9L4iVc%2FhRefJdmBeANqq0YpvU1yhx3LHbUSNmSHeZznF70k04tfNjZbpFnasBOtEr1hGTHpkqS9i8zEYUUsQ%3D%3D";

        sb.append(key);
        sb.append("&MobileApp=AppTest&MobileOS=ETC&pageNo=");
//        sb.append(cPage);
        sb.append("&numOfRows=5&_type=xml&contentTypeId=");
        sb.append(contentTypeId);
        sb.append("&contentId=");
        sb.append(contentId);




        return "tripDetails.jsp";
    }
}
