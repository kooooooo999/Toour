package toour.member.action.post;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import toour.action.Action;
import toour.member.dao.AdminPostDAO;
import toour.member.vo.MemberVO;
import toour.post.dao.PostDAO;
import toour.post.vo.PostVO;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;

public class AdminPostEditAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // 먼저 요청시 contentType을 얻어낸다.
        String enc_type = request.getContentType();
        String cPage = request.getParameter("cPage");
        String viewpath = null;

        if(enc_type != null && enc_type.startsWith("application")){
            // view.jsp에서 [수정]버튼을 클릭한 경우 수정화면으로 이동해야 함.
            // 그럼 먼저 수정하고자 하는 게시물을 얻어내야 한다.
            String post_idx = request.getParameter("post_idx");
            MemberVO vo = AdminPostDAO.getPostMemberIdx(post_idx);

            request.setAttribute("vo", vo);
            viewpath = "admin/admin_post_edit.jsp"; // 여기서 forward되므로 여기로 넘어오는 파라미터들은 그대로 유지되어 edit.jsp로 간다.

        }else if(enc_type != null && enc_type.startsWith("multipart")){
            //edit.jsp에서 값을 수정한 후 DB에 UPDATE를 수행하길 원하는 경우
            //첨부파일을 처리하기 위해 bbs_upload폴더의 절대경로가 필요하다.
            ServletContext application = request.getServletContext();
            try{
                String realPath = application.getRealPath("/bbs_upload");

                // 첨부파일과 다른 파라미터들을 받기위해 MultipartRequest생성
                MultipartRequest mr = new MultipartRequest(request,realPath,1024*1024*5,"utf-8",new DefaultFileRenamePolicy());
                // 이때 첨부파일이 있다면 realPath경로에 저장된 상태다.

                // 나머지 파라미터들 얻기
                String post_idx = mr.getParameter("post_idx");
                String category_idx = mr.getParameter("category_idx");
                String post_title = mr.getParameter("post_title");
                String post_content = mr.getParameter("post_content");

                // DB에 수정 ++
                AdminPostDAO.edit(post_idx, category_idx, post_title, post_content);


                // 첨부파일이 있다면 file_name_stored와 file_name_original을 얻어내야 한다.
                File f = mr.getFile("file");
                String file_name_stored = null;
                String file_name_original = null;
                String file_size = null;
                String file_type = null;

                if(f != null){
                    file_name_stored = f.getName(); // 현재 저장된 파일명
                    file_name_original = mr.getOriginalFileName("file"); // 원래 파일명
                    file_size = String.valueOf(f.length());
                    file_type = mr.getContentType("file");
                }

//                System.out.println("Stored: " + file_name_stored);
//                System.out.println("Original: " + file_name_original);

                if(f != null)
                    AdminPostDAO.fileedit(post_idx,file_name_original, file_name_stored, file_size, file_type);

                viewpath = "AdminController?type=adminpostview&post_idx="+post_idx+"&cPage="+cPage;

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return viewpath;
    }
}
