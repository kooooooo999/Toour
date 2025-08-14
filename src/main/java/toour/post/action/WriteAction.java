package toour.post.action;

import toour.action.Action;
import toour.login.dao.MemberDAO;
import toour.member.vo.MemberVO;
import toour.post.dao.FileDAO;
import toour.post.dao.PostDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;

public class WriteAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        //세션에서 user 받고 그걸 MemberVO로 형변환한뒤 member_idx 받아오기!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

        String viewPath = null;
        // list.jsp에 있는 [글쓰기]버튼을 클릭하면 get방식으로
        //현재 객체를 수행한다. 이때 요청시 contentType을 얻어낸다. 분명
        // get방식 null값을 받게된다.
        String enc_type = request.getContentType();
        //System.out.println(enc_type);
        //세션에 저장된 사용자정보를 가져오기
        HttpSession session = request.getSession();
        if(session.getAttribute("member") == null){
            //로그인 안된 상태면
            System.out.println("session nothing - no member in session");
            return "Controller?type=moveLogin";
        }
        //1. 로그인 상태 확인!
        MemberVO loginMember = (MemberVO)session.getAttribute("member");

        MemberVO mvo=MemberDAO.getKakaoMember(loginMember.getLogin_type(),loginMember.getMember_email());
        System.out.println("loginMember:"+loginMember.getMember_idx());

        if(loginMember == null){
            System.out.println("loginMember nothing");
            return "Controller?type=moveLogin";
        }

        //2. 요청타입에 따른 로직 분기
        if(enc_type == null) {
            //get방식
            System.out.println("GET request: Showing write form.");
            viewPath = "post/write.jsp";
            //post 방식(form submit)
        }else if(enc_type.startsWith("multipart")){
            // GET 방식 (form)
            // 여기는 write.jsp에서 내용을 입력한 후 [보내기] 버튼을
            // 클릭했을 때 수행하는 곳
            // 첨부파일을 받아서 bbs_upload라는 폴더에 저장해야 합니다.
            try{
                // POST 방식
                System.out.println("WriteAction: enc_type multipart");
                ServletContext application = request.getServletContext();
                String realPath = application.getRealPath("/bbs_upload");


                //첨부파일과 다른 파라미터들을 받기위해 MultipartRequest생성
                MultipartRequest mr = null;
                try {
                    mr = new MultipartRequest(request,realPath,
                            1024*1024*10, "utf-8",
                            new DefaultFileRenamePolicy());
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
                //이때 첨부파일이 있다면 realPath경로에 저장된 상태다.

                //세션으로부터 가져온 것
                String member_idx = mvo.getMember_idx();
                String member_nickname = mvo.getMember_nickname();


                //나머지 파라미터들 얻기(post_title, member_idx, post_content)
                String post_title = mr.getParameter("post_title");
                String post_content = mr.getParameter("post_content");
                String category_idx = mr.getParameter("category_idx");

                String post_views = "0";
                String post_likes = "0";
                String post_comments_count = "0";
                String post_status = "0";
                String post_created_at = null;// DB에서 NOW() 처리
                String post_star = "0";


                int generatedPostIdx = 0;

                try {
                    generatedPostIdx = PostDAO.add(post_title, post_content, member_idx, category_idx);
                    System.out.println("write to success post_idx: " + generatedPostIdx);
                } catch (Exception e) {
                    System.out.println("DB insert failure: " + e.getMessage());
                    e.printStackTrace();
                    try {
                        // insert 실패 시 write form으로 redirect
                        response.sendRedirect("Controller?type=write");
                    } catch (IOException ioException) {
                        ioException.printStackTrace();
                    }
                    return null;
                }

                File f = mr.getFile("file");

                if( f != null && f.length() > 0 ){
                    String file_name_stored = f.getName();
                    String file_name_original = mr.getOriginalFileName("file");
                    String file_size = String.valueOf(f.length());
                    String file_type = mr.getContentType("file");
                    String file_s3_url = "";
                    try {
                        FileDAO.fileadd(String.valueOf(generatedPostIdx), file_name_original,
                                file_name_stored, file_s3_url, file_size, file_type);
                        System.out.println("file DB save");
                    } catch (Exception e) {
                        System.out.println("file DB can't save: " + e.getMessage());
                        e.printStackTrace();
                    }
                }


                //DB에 저장 ++
                response.sendRedirect("Controller?type=view&post_idx=" + generatedPostIdx);
                System.out.println("write success");
                return null;
            }  catch (Exception e) {
                System.out.println("writeAction error");
                e.printStackTrace();
                return "post/write.jsp";
            }
        }
        return viewPath;
    }
}
