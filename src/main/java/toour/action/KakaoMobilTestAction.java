package toour.action;

import toour.search.vo.MarkerTestVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class KakaoMobilTestAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        String mapx = "126.9718732";
        String mapy = "37.556074";

        MarkerTestVO vo = new MarkerTestVO();
        vo.setMapx(mapx);
        vo.setMapy(mapy);

        request.setAttribute("testvo", vo);

        return "findWay.jsp";
    }
}
