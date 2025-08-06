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

        DataVO Dvo = new DataVO(title, addr1, overview, firstimage);
        request.setAttribute("detailsAr", Dvo);
        return "tripDetails.jsp";
    }
}
