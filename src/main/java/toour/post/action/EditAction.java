package toour.post.action;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import toour.action.Action;
import toour.member.vo.MemberVO;
import toour.post.dao.FileDAO;
import toour.post.dao.PostDAO;
import toour.post.vo.FileVO;
import toour.post.vo.PostVO;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.List;

public class EditAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
       // 먼저 요청시 contentType을 얻어낸다.
        String enc_type = request.getContentType();
        String viewpath = null;

        HttpSession session = request.getSession();
        if(session.getAttribute("user") == null){
            //로그인 안된 상태면
            System.out.println("session nothing");
            return "Controller?type=login";
        }
        //1. 로그인 상태 확인!
        MemberVO loginMember = (MemberVO)session.getAttribute("user");

        System.out.println("loginMember:"+loginMember.getMember_idx());
        if(loginMember == null){
            System.out.println("loginMember nothing");
            return "Controller?type=login";
        }
        System.out.println("this is EditAction");
        // GET 요청 (수정 페이지로 이동)
        if (enc_type == null) {
            System.out.println("GET 요청 (수정 페이지 진입)");
            String post_idx = request.getParameter("post_idx");
            PostVO vo = PostDAO.getPost(post_idx);

            // 기존 파일 목록을 가져와서 JSP로 전달
            List<FileVO> fileList = FileDAO.getFileList(post_idx);
            request.setAttribute("vo", vo);
            request.setAttribute("file", fileList);

            viewpath = "post/edit.jsp";

            // POST 요청 (수정 내용 DB에 반영)
        } else if (enc_type.startsWith("multipart/form-data")) {
            System.out.println("POST 요청 (게시글 수정)");
            ServletContext application = request.getServletContext();
            try {
                String realPath = application.getRealPath("/bbs_upload");
                MultipartRequest mr = new MultipartRequest(request, realPath, 1024 * 1024 * 5, "utf-8", new DefaultFileRenamePolicy());

                String post_title = mr.getParameter("post_title");
                String post_content = mr.getParameter("post_content");
                String post_idx = mr.getParameter("post_idx");
                String cPage = mr.getParameter("cPage");

                // 기존 파일 정보 조회
                List<FileVO> oldFileList = FileDAO.getFileList(post_idx);

                // 첨부파일이 있다면 file_name_stored와 file_name_original을 얻어내야 한다.
                File f = mr.getFile("file");

                String file_name_stored = null;
                String file_name_original = null;
                if (f != null && f.length() > 0) {
                    //일단 새파일이 업로드 된 경우
                    // 1. 기존 파일이 있다면 삭제
                    if (oldFileList != null && !oldFileList.isEmpty()) {
                        for (FileVO oldFileVO : oldFileList) {
                            File oldFile = new File(realPath, oldFileVO.getFile_name_stored());
                            if (oldFile.exists()) {
                                oldFile.delete(); // 서버에서 파일 삭제
                            }
                        }
                        FileDAO.fileDelete(post_idx); // DB에서 파일 정보 모두 삭제
                    }

                    // 2. 새 파일 정보 추가
                    file_name_stored = f.getName();
                    file_name_original = mr.getOriginalFileName("file");
                    String file_size = String.valueOf(f.length());
                    String file_type = mr.getContentType("file");
                    String file_s3_url = "";
                    FileDAO.fileadd(post_idx, file_name_original, file_name_stored, file_s3_url, file_size, file_type);

                } else {
                    // 새 파일이 없고 기존 파일 삭제를 요청한 경우
                    String[] deleteFileCheckboxes = mr.getParameterValues("deleteFile");
                    if (deleteFileCheckboxes != null && deleteFileCheckboxes.length > 0) {
                        for (String file_idx_str : deleteFileCheckboxes) {
                            // FileDAO.fileDelete(file_idx_str); // 파일 하나만 삭제하는 메서드 호출
                            // 실제 파일도 서버에서 삭제하는 로직 추가 필요
                        }
                        // 여기서는 post_idx로 모든 파일을 삭제하도록 유지
                        if (oldFileList != null && !oldFileList.isEmpty()) {
                            for (FileVO oldFileVO : oldFileList) {
                                File oldFile = new File(realPath, oldFileVO.getFile_name_stored());
                                if (oldFile.exists()) {
                                    oldFile.delete(); // 서버에서 파일 삭제
                                }
                            }
                            FileDAO.fileDelete(post_idx); // DB에서 파일 정보 모두 삭제
                        }
                    }
                }
                String ip = request.getRemoteAddr(); // 요청자의 IP

                // DB에 수정 ++
                PostDAO.edit(post_idx, post_title, post_content, file_name_stored, file_name_original, ip);
                List<FileVO> fileList = FileDAO.getFilesByPost(post_idx);
                request.setAttribute("fileList", fileList);

                viewpath = "Controller?type=view&b_idx=" + post_idx + "&cPage=" + cPage;
                request.setAttribute("vo",  PostDAO.getPost(post_idx));
                request.setAttribute("cPage", cPage);
                request.setAttribute("file", oldFileList);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return viewpath;
    }
}
