package toour.action;

import toour.dao.PostDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;

public class WriteAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        //세션에서 user 받고 그걸 MemberVO로 형변환한뒤 member_idx 받아오기!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

        String viewPath = null;
        // list.jsp에 있는 [글쓰기]버튼을 클릭하면 get방식으로
        //현재 객체를 수행한다. 이때 요청시 contentType을 얻어낸다. 분명
        // get방식 null값을 받게된다.
        String enc_type = request.getContentType();
        //System.out.println(enc_type);

        if(enc_type == null)
            viewPath = "write.jsp";
        else if(enc_type.startsWith("multipart")){
            // 여기는 write.jsp에서 내용을 입력한 후 [보내기] 버튼을
            // 클릭했을 때 수행하는 곳
            // 첨부파일을 받아서 bbs_upload라는 폴더에 저장해야 합니다.
            try{
                ServletContext application = request.getServletContext();
                String realPath = application.getRealPath("/bbs_upload");

                //첨부파일과 다른 파라미터들을 받기위해 MultipartRequest생성
                MultipartRequest mr = new MultipartRequest(request,realPath,
                        1024*1024*5, "utf-8",
                        new DefaultFileRenamePolicy());
                //이때 첨부파일이 있다면 realPath경로에 저장된 상태다.

                //나머지 파라미터들 얻기(post_title, member_idx, post_content)
                String post_title = mr.getParameter("post_title");
                //박준형 시작
//                String member_idx= mr.getParameter("member_idx");
                String member_idx= "3";
                //박준형 끝
                String post_content = mr.getParameter("post_content");
                String category_idx = mr.getParameter("category_idx");
                String post_likes = mr.getParameter("post_likes");
                String post_comments_count = mr.getParameter("post_comments_count");
                String post_status = mr.getParameter("post_status");
                String post_created_at = mr.getParameter("post_created_at");
                String post_star = mr.getParameter("post_star");
                String post_views = mr.getParameter("post_views");

                //첨부파일이 있다면 file_name_stored과 file_name_original을 얻어내야 한다.
                File f = mr.getFile("file");
                String file_name_stored = null;
                String file_name_original = null;
                if( f != null ){
                    file_name_stored = f.getName();// 현재 저장된 파일명
                    file_name_original = mr.getOriginalFileName("file");// 원래 파일명
                }
                String ip = request.getRemoteAddr();// 요청자의 IP

                //DB에 저장 ++
                PostDAO.add(post_title, post_content, member_idx,
                        category_idx, post_views, post_likes, post_comments_count,
                        post_status, post_created_at, post_star);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return "write.jsp";
    }
}
