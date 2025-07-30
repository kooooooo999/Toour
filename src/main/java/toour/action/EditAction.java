package toour.action;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import mybatis.vo.PostVO;
import toour.dao.PostDAO;

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
            PostVO vo = PostDAO.getpost(post_idx);

        }else if(enc_type.startsWith("multpart")){

        }

        return "index.jsp";
    }
}
