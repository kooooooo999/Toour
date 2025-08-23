package toour.member.action.post;

import toour.member.dao.AdminNoticeDAO;
import toour.member.dao.AdminPostDAO;
import toour.member.vo.MemberVO;
import toour.post.dao.PostDAO;
import toour.post.dao.ReportDAO;
import toour.post.vo.CommentVO;
import toour.post.vo.PostVO;
import toour.action.Action;
import toour.post.vo.ReportVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

public class AdminPostViewAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String post_idx = request.getParameter("post_idx");
//        System.out.println("post_idx: " + post_idx);
       /* HttpSession session = request.getSession();
//        System.out.println("post_idx:"+post_idx);
        Object obj = session.getAttribute("report_list");

        ArrayList<String> report_list = null;
        if(obj == null){
            report_list = new ArrayList<>();
            session.setAttribute("report_list", report_list);
        }else
            report_list = (ArrayList<String>) obj; // 형변환

        ReportVO[] rvo = ReportDAO.getReport();
        MemberVO vo = AdminPostDAO.getPostMemberIdx(post_idx); // 사용자가 선택한 게시물을 검색해 온다.
        PostVO pvo = AdminPostDAO.getPost(post_idx);
*/
//        System.out.println(vo.getPost_idx());
//       if(vo == null){
//            System.out.println("vo가 존재하지 않습니다.");
//        }

  MemberVO vo = AdminPostDAO.getPostMemberIdx(post_idx);
  PostVO pvo = AdminPostDAO.getPost(post_idx);

        /*CommentVO[] comment_list = PostDAO.getCommentList(post_idx);
        if (comment_list == null) {
            comment_list = new CommentVO[0]; // null 대신 빈 배열
        }*/
        CommentVO[] ar = AdminPostDAO.getCommentList(post_idx);
        if (ar == null) {
            ar = new CommentVO[0];
        }

        //게시물 신고내역 나타내기 위해 보내는 것
        //PostVO[] PostReportAr = Ad

        request.setAttribute("CommentAr", ar);
        System.out.println("AdminPostViewAction ar.length: "+ar.length);
        request.setAttribute("vo", vo);
        request.setAttribute("pvo", pvo);
        /*request.setAttribute("rvo", rvo);
        request.setAttribute("report_list", report_list);
        request.setAttribute("comment_list",comment_list);
*/
        System.out.println("AdminPostviewAction post_idx: : "+post_idx);
//        System.out.println("vo"+vo.getCategory_idx());

        return "admin/admin_post_view.jsp";
    }
}
