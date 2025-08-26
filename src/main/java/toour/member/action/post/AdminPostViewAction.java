package toour.member.action.post;

import toour.member.dao.AdminPostDAO;
import toour.post.dao.ReportDAO;
import toour.post.vo.PostVO;
import toour.member.vo.MemberVO;
import toour.action.Action;
import toour.post.vo.ReportVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

public class AdminPostViewAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String post_idx = request.getParameter("post_idx");
        String report_idx = request.getParameter("report_idx");

        // 1. 게시글 정보와 작성자 닉네임 가져오기
        MemberVO vo = AdminPostDAO.getPostMemberIdx(post_idx);
        PostVO pvo = AdminPostDAO.getPost(post_idx);
//        System.out.println("report_idx:::::::::::"+report_idx);


        // 2. 해당 게시물의 모든 댓글과 신고 정보를 함께 가져오기
        // DAO에서 댓글 목록을 가져오고, 그 안에 신고 정보도 포함시킵니다.
        // DAO는 List<Map>을 반환하므로, 변수 타입을 맞춰줍니다.
        List<Map<String, Object>> commentListWithReports = ReportDAO.getCommentListWithReports(post_idx);
        int pluswarning = AdminPostDAO.pluswarning(report_idx);

        // 3. request에 데이터 설정
        request.setAttribute("vo", vo);
        request.setAttribute("pvo", pvo);
        request.setAttribute("commentList", commentListWithReports); // JSP에서 사용할 이름
        request.setAttribute("pluswarning",pluswarning);

//        System.out.println("commentListWithReports.size()"+commentListWithReports.size());
        return "admin/admin_post_view.jsp";
    }
}