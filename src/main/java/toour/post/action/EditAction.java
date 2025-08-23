package toour.post.action;

import toour.action.Action;
import toour.post.dao.PostDAO;
import toour.member.vo.MemberVO;
import toour.post.vo.PostVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class EditAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String enc_type = request.getContentType();
        String viewpath = null;

        HttpSession session = request.getSession();
        MemberVO loginMember = (MemberVO) session.getAttribute("member");

        if (loginMember == null) {
            return "Controller?type=login";
        }

        // GET 요청 (수정 페이지로 이동)
        if (request.getMethod().equalsIgnoreCase("GET")) {
            String post_idx = request.getParameter("post_idx");
            PostVO vo = PostDAO.getPost(post_idx);
            request.setAttribute("vo", vo);
            viewpath = "post/edit.jsp";
        }

        // POST 요청 (수정 내용 DB에 반영)
        else if (request.getMethod().equalsIgnoreCase("POST")) {
            try {
                String post_title = request.getParameter("post_title");
                String post_content = request.getParameter("post_content");
                String post_idx = request.getParameter("post_idx");
                String cPage = request.getParameter("cPage");
                String ip = request.getRemoteAddr();

                // post_content에 이미지가 포함된 HTML이 있으므로 그대로 저장
                PostDAO.edit(post_idx, post_title, post_content, ip);

                viewpath = "Controller?type=view&post_idx=" + post_idx + "&cPage=" + cPage;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return viewpath;
    }
}