package toour.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FindWayGoAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        //get이냐 post냐
        //viewpath로 바꿔서
        //get이면 searchResultAction
        //post면 이대로
        //request.setAttribute("F5",0);
        //String viewPath = "Controller?type=searchResult";
       // System.out.println("viewPath:"+viewPath);
        return "findWay.jsp";
    }
}
