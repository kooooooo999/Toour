package toour.action;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import toour.dao.PostDAO;
import mybatis.vo.PostVO;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class EditAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // 먼저 요청시 contentType을 얻어낸다.
        String enc_type = request.getContentType();
        String viewpath = null;

        if(enc_type.startsWith("application")){
            // view.jsp에서 [수정]버튼을 클릭한 경우 수정화면으로 이동해야 함.
            // 그럼 먼저 수정하고자 하는 게시물을 얻어내야 한다.
            String post_idx = request.getParameter("post_idx");
            PostVO vo = PostDAO.getPost(post_idx);

            request.setAttribute("vo", vo);
            viewpath = "edit.jsp"; // 여기서 forward되므로 여기로 넘어오는 파라미터들은 그대로 유지되어 edit.jsp로 간다.

        }else if(enc_type.startsWith("multpart")){
            //edit.jsp에서 값을 수정한 후 DB에 UPDATE를 수행하길 원하는 경우
            //첨부파일을 처리하기 위해 bbs_upload폴더의 절대경로가 필요하다.
            ServletContext application = request.getServletContext();
            try{

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return viewpath;
    }
}
