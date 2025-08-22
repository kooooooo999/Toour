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
        String enc_type = request.getContentType();
        String viewpath = null;

        HttpSession session = request.getSession();
        MemberVO loginMember = (MemberVO) session.getAttribute("member");

        if (loginMember == null) {
            return "Controller?type=login";
        }

        // GET 요청 (수정 페이지로 이동)
        if (enc_type == null) {
            String post_idx = request.getParameter("post_idx");
            PostVO vo = PostDAO.getPost(post_idx);
            List<FileVO> fileList = FileDAO.getFileList(post_idx);
            request.setAttribute("vo", vo);
            request.setAttribute("file", fileList);
            viewpath = "post/edit.jsp";
        }

        // POST 요청 (수정 내용 DB에 반영)
        else if (enc_type.startsWith("multipart/form-data")) {
            ServletContext application = request.getServletContext();
            try {
                String realPath = application.getRealPath("/bbs_upload");
                MultipartRequest mr = new MultipartRequest(request, realPath, 1024 * 1024 * 10, "utf-8", new DefaultFileRenamePolicy());

                String post_title = mr.getParameter("post_title");
                String post_content = mr.getParameter("post_content");
                String post_idx = mr.getParameter("post_idx");
                String cPage = mr.getParameter("cPage");

                // --- 파일 삭제 로직 (가장 먼저 처리) ---
                /*String[] deleteFileCheckboxes = mr.getParameterValues("deleteFile");
                if (deleteFileCheckboxes != null && deleteFileCheckboxes.length > 0) {
                    for (String file_idx_str : deleteFileCheckboxes) {
                        FileVO fileToDelete = FileDAO.getFile(post_idx); // 파일 고유번호로 파일 정보 조회
                        if (fileToDelete != null) {
                            File oldFile = new File(realPath, fileToDelete.getFile_name_stored());
                            if (oldFile.exists()) {
                                oldFile.delete(); // 서버에서 파일 삭제
                            }
                            FileDAO.fileDelete(post_idx); // DB에서 해당 파일 정보 삭제
                        }
                    }
                }
                String file_name_stored = null;
                String file_name_original = null;
                File f = mr.getFile("file");
                if (f != null && f.length() > 0) {
                    // 새 파일이 업로드 되면 DB에 추가 (이것은 Summernote와 별개인 첨부파일일 경우)
                    file_name_stored = f.getName();
                    file_name_original = mr.getOriginalFileName("file");
                    String file_size = String.valueOf(f.length());
                    String file_type = mr.getContentType("file");
                    String file_s3_url = "";
                    FileDAO.fileadd(post_idx, file_name_original, file_name_stored, file_s3_url, file_size, file_type);
                }
*/
                String ip = request.getRemoteAddr();
                // **post_content에 이미지가 포함된 HTML이 들어 있으므로 그대로 저장**
                PostDAO.edit(post_idx, post_title, post_content,ip);

                viewpath = "Controller?type=view&post_idx=" + post_idx + "&cPage=" + cPage;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return viewpath;
    }
}