package toour.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HeaderSearchAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {


        System.out.println("도착");
        return "headerSearch.jsp";
    }
}
