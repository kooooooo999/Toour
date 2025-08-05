package toour.member.action;

import toour.login.dao.MemberDAO;
import toour.member.dao.AdminMemberDAO;
import toour.member.vo.MemberVO;
import toour.post.vo.PostVO;
import toour.action.Action;
import toour.post.dao.PostDAO;
import toour.util.Paging;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminMemSearchAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String searchType = request.getParameter("searchType");
        String searchValue = request.getParameter("searchValue");
        String member_idx = request.getParameter("member_idx");

//        System.out.println(searchType);
//        System.out.println(searchValue);


        Paging page = new Paging(10,5);


        String cPage = request.getParameter("cPage");

        if (cPage == null)
            page.setNowPage(1);
        else{
            int nowPage= Integer.parseInt(cPage);
            page.setNowPage(nowPage);
        }

        MemberVO[] ar = AdminMemberDAO.search(searchType,searchValue, page.getBegin(),page.getEnd());

        if(ar!=null &&ar.length>0) {
            System.out.println("1st: " + ar[0].getMember_id());
            request.setAttribute("ar", ar);

        }
        else
            System.out.println("검색결과가 없습니다.");

        request.setAttribute("page",page);
        request.setAttribute("member_idx",member_idx);
        request.setAttribute("searchType",searchType);
        request.setAttribute("searchValue",searchValue);
        request.setAttribute("nowPage",page.getNowPage());
        return "admin/admin_mem.jsp";
    }
}
