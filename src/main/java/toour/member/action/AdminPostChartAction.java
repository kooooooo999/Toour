package toour.member.action;

import toour.action.Action;
import toour.member.dao.AdminMemberDAO;
import toour.member.dao.AdminPostDAO;
import toour.member.vo.MemberVO;
import toour.util.Paging;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

public class AdminPostChartAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ── AdminMainAction에서 세팅하던 값들 복사 ──
        String category_idx = request.getParameter("category_idx"); // null 가능

        int totalCount = AdminMemberDAO.getTotalMemCount();
        int MemCount = AdminMemberDAO.MemCount();
        int DormantMemCount = AdminMemberDAO.DormantMemCount();
        int DeactivatedMemCount = AdminMemberDAO.DeactivatedMemCount();
        int BannedMemCount = AdminMemberDAO.BannedMemCount();

        int RecentVisitMem = AdminMemberDAO.RecentVisitMem();
        int getRecentPost = AdminPostDAO.getRecentPost(category_idx); // 방금 고친 메서드

        request.setAttribute("totalCount", totalCount);
        request.setAttribute("MemCount", MemCount);
        request.setAttribute("DormantMemCount", DormantMemCount);
        request.setAttribute("DeactivatedMemCount", DeactivatedMemCount);
        request.setAttribute("BannedMemCount", BannedMemCount);
        request.setAttribute("RecentVisitMem", RecentVisitMem);
        request.setAttribute("getRecentPost", getRecentPost);

        // ── 막대그래프 데이터 ──
        List<Map<String, Object>> weeklyPostList = AdminPostDAO.getWeeklyPostCount();
        request.setAttribute("weeklyPostList", weeklyPostList);

        return "admin/admin_main.jsp";
    }
}
