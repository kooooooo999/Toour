package toour.member.action;

import toour.action.Action;
import toour.login.dao.MemberDAO;
import toour.member.dao.AdminMemberDAO;
import toour.member.dao.AdminPostDAO;
import toour.member.vo.MemberVO;
import toour.util.Paging;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AdminMainAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        System.out.println("AdminMainAction 실행됨");

        String category_idx = request.getParameter("category_idx");
        String member_idx = request.getParameter("member_idx");
        if (member_idx == null)
            member_idx = "1";



        int totalCount = AdminMemberDAO.getTotalMemCount();
        int MemCount = AdminMemberDAO.MemCount();
        int DormantMemCount = AdminMemberDAO.DormantMemCount();
        int DeactivatedMemCount = AdminMemberDAO.DeactivatedMemCount();
        int BannedMemCount = AdminMemberDAO.BannedMemCount();

        int RecentVisitMem = AdminMemberDAO.RecentVisitMem();
        int getRecentPost = AdminPostDAO.getRecentPost(category_idx);

//        System.out.println("totalCount"+totalCount);

        Paging page = new Paging(10, 5);

        MemberVO[] ar = AdminMemberDAO.getmemList(page.getBegin(), page.getEnd());

        request.setAttribute("ar", ar);
        request.setAttribute("totalCount", totalCount);
        request.setAttribute("MemCount", MemCount);
        request.setAttribute("DormantMemCount", DormantMemCount);
        request.setAttribute("DeactivatedMemCount", DeactivatedMemCount);
        request.setAttribute("BannedMemCount", BannedMemCount);
        request.setAttribute("RecentVisitMem", RecentVisitMem);
        request.setAttribute("getRecentPost", getRecentPost);

        return "admin/admin_main.jsp";
    }
}
