package toour.member.action;

import toour.member.dao.AdminPostDAO;
import toour.post.vo.PostVO;
import toour.action.Action;
import toour.post.dao.PostDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

public class AdminNoticeViewAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String post_idx = request.getParameter("post_idx");
        HttpSession session = request.getSession();
//        System.out.println("post_idx:"+post_idx);
        Object obj = session.getAttribute("read_list");
        ArrayList<PostVO> list = null;
        if(obj == null){
            list = new ArrayList<>();
            session.setAttribute("read_list", list);
        }else
            list = (ArrayList<PostVO>) obj; // 형변환

        PostVO vo = AdminPostDAO.getPost(post_idx); // 사용자가 선택한 게시물을 검색해 온다.
//        System.out.println(vo.getPost_idx());
//       if(vo == null){
//            System.out.println("vo가 존재하지 않습니다.");
//        }
        request.setAttribute("vo", vo);
//        System.out.println("vo"+vo.getCategory_idx());

        return "admin/admin_notice_view.jsp";
    }
}
