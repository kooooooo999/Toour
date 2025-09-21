package toour.post.action;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import toour.action.Action;
import toour.member.vo.MemberVO;
import toour.post.dao.PostDAO;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class CommentAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String viewPath=null;
        String enc_type =request.getContentType();

        HttpSession session=request.getSession();
        if(session.getAttribute("member")==null){
            System.out.println("comment session nothing");
            return "Controller?type=moveLogin";
        }
        MemberVO loginMember=(MemberVO)session.getAttribute("member");
        System.out.println("CommentLoginMember:"+loginMember);
        if(loginMember==null){
            return "Controller?type=moveLogin";
        }
        if (enc_type==null) {
            //get방식?
            viewPath="post/view.jsp";

        }else if(enc_type.startsWith("multipart")){
            //댓글에 파일첨부를 허용할 것인가 그리고 썸머노트도?
            System.out.println("comment enc_type:"+enc_type);
            ServletContext application=request.getServletContext();
            String realPath = application.getRealPath("/bbs_upload");

            MultipartRequest mr = null;
            //첨부파일을 넣기로 했다면 필요한 곳
            try {
                mr= new MultipartRequest(request, realPath, 1024*1024*10, "utf-8",new DefaultFileRenamePolicy());

            } catch (IOException e) {
                throw new RuntimeException(e);
            }

            //세션에 저장 된것 가져오기
            String member_idx = loginMember.getMember_idx();
            String member_nickname=loginMember.getMember_nickname();

            //파라미터 받아오기
            String comment_content = mr.getParameter("comment_content");
            String formatted_content = comment_content.replace("\n", "<br/>");



            String post_idx = mr.getParameter("post_idx");

            //comment insert
            PostDAO.insertComment(post_idx, member_idx, formatted_content);

            viewPath="Controller?type=view&post_idx="+post_idx;
        }
        return viewPath;
    }
}
