package toour.member.action;

import toour.action.Action;
import toour.member.dao.AdminMemberDAO;
import toour.member.dao.AdminPostDAO;
import toour.member.vo.MemberVO;
import toour.post.dao.PostDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;

public class AdminNoticeWriteAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        //세션에서 user 받고 그걸 MemberVO로 형변환한뒤 member_idx 받아오기!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

        String viewPath = null;
        // list.jsp에 있는 [글쓰기]버튼을 클릭하면 get방식으로
        //현재 객체를 수행한다. 이때 요청시 contentType을 얻어낸다. 분명
        // get방식 null값을 받게된다.
        String enc_type  = request.getContentType();
        //System.out.println(enc_type);

        if(enc_type == null)
            viewPath = "admin/admin_post_write.jsp";
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
                String member_idx= mr.getParameter("member_idx");
                //박준형 끝

                String post_content = mr.getParameter("post_content");
                String category_idx = mr.getParameter("category_idx");
                String post_status = mr.getParameter("post_status");
                String post_views = mr.getParameter("post_views");


                //첨부파일이 있다면 file_name_stored과 file_name_original을 얻어내야 한다.
                File f = mr.getFile("file");
                String file_name_stored = null;
                String file_s3_url = "";
                String file_name_original = null;
                String post_idx = null;
                String file_size = null;
                String file_type = null;

                if( f != null && f.length() > 0 ){
                    file_name_stored = f.getName();// 현재 저장된 파일명
                    file_name_original = mr.getOriginalFileName("file");// 원래 파일명
                    post_idx = mr.getParameter("post_idx");
                    file_size = String.valueOf(f.length());
                    file_type = mr.getContentType("file");
                }

                //DB에 저장 ++
                post_idx = AdminPostDAO.postadd(post_title, post_content, member_idx, category_idx, post_views, post_status);
                AdminPostDAO.fileadd(post_idx, file_name_original, file_name_stored, file_s3_url, file_size, file_type);
//                System.out.println("post_idx:"+post_idx);
//                System.out.println("file_name_original"+file_name_original);

                viewPath = "AdminController?type=adminnotice";
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return viewPath;
    }
}
