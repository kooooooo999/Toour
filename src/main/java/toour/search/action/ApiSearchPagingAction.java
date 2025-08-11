package toour.search.action;

import toour.action.Action;
import toour.util.Paging;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ApiSearchPagingAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String cPage =request.getParameter("cPage");
        String totalCount =request.getParameter("totalCount");

        Paging page = new Paging(5, 5);
        page.setTotalCount(Integer.parseInt(totalCount));
        page.setNowPage(Integer.parseInt(cPage));
        request.setAttribute("page", page);

        return "apiSearchPaging.jsp";
    }
}
