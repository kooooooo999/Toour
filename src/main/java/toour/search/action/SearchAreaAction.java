package toour.search.action;

import toour.action.Action;
import toour.util.GetAPIData;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SearchAreaAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        String areaCode = request.getParameter("areaCode");
        if(areaCode!=null&& !areaCode.equals("0"))
            GetAPIData.getSigungu(request,areaCode);
        String contentTypeId = request.getParameter("contentTypeId");
        if(contentTypeId!=null)
            GetAPIData.getCat1(request,contentTypeId);
        String cat1 = request.getParameter("cat1");
        if(cat1!=null&& !cat1.equals("0"))
            GetAPIData.getCat2(request, cat1);
        String cat2 = request.getParameter("cat2");
        if(cat1!=null&& !cat1.equals("0")&&cat2!=null&& !cat2.equals("0"))
            GetAPIData.getCat3(request,cat1,cat2);
        //세빈 입력해야 될 부분
        return "APISearchData.jsp";
    }
}
