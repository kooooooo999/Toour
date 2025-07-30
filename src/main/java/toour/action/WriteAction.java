package toour.action;

import dao.PostDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;

public class WriteAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

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
                String member_idx = mr.getParameter("member_idx");
                String post_content = mr.getParameter("post_content");
                String category_idx = mr.getParameter("category_idx");

                //첨부파일이 있다면 fname과 oname을 얻어내야 한다.
                File f = mr.getFile("file");
                String fname = null;
                String oname = null;
                if( f != null ){
                    fname = f.getName();// 현재 저장된 파일명
                    oname = mr.getOriginalFileName("file");// 원래 파일명
                }
                String ip = request.getRemoteAddr();// 요청자의 IP

                //DB에 저장
                PostDAO.add(post_title, member_idx, post_content, category_idx);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return viewPath;
    }
}
