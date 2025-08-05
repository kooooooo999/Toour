package toour.tripsuggestion.action;

import toour.action.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class tripDetailsAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        request.getAttribute("dataAr");
        return "tripDetails.jsp";
    }
}
