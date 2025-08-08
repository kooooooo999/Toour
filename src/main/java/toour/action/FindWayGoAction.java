package toour.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FindWayGoAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        return "findWay.jsp";
    }
}
