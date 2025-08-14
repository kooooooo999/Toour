package toour.post.action;

import toour.action.Action;
import toour.post.dao.InquiryDAO;
import toour.member.vo.MemberVO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;

public class QnAAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 세션 체크 및 로그인 상태 확인
        HttpSession session = request.getSession();
        if (session.getAttribute("member") == null) {
            request.setAttribute("error", "로그인이 필요한 서비스입니다.");
            return "Controller?type=moveLogin";
        }
        
        MemberVO loginMember = (MemberVO) session.getAttribute("member");
        if (loginMember == null || loginMember.getMember_idx() == null) {
            request.setAttribute("error", "유효하지 않은 사용자 정보입니다.");
            return "Controller?type=moveLogin";
        }
        
        String member_idx = loginMember.getMember_idx();
        
        // POST 요청인 경우 문의 등록 처리
        if ("POST".equals(request.getMethod())) {
            try {
                // 파일 업로드를 위한 설정
                ServletContext application = request.getServletContext();
                String realPath = application.getRealPath("/inquiry_upload");
                
                // 디렉토리가 없으면 생성
                File dir = new File(realPath);
                if (!dir.exists()) {
                    dir.mkdirs();
                }
                
                // MultipartRequest 객체 생성 (최대 10MB)
                MultipartRequest mr = new MultipartRequest(request, realPath, 10 * 1024 * 1024, "UTF-8", new DefaultFileRenamePolicy());
                
                // 폼 데이터 받기
                String category = mr.getParameter("category");
                String title = mr.getParameter("title");
                String content = mr.getParameter("content");
                String status = "대기중"; // 기본 상태
                
                // 파일 처리
                String file_path = null;
                File file = mr.getFile("file_path");
                if (file != null) {
                    file_path = file.getName();
                }
                
                // 유효성 검사
                if (category == null || category.trim().isEmpty()) {
                    request.setAttribute("error", "문의 유형을 선택해주세요.");
                    return "/post/QandA.jsp";
                }
                
                if (title == null || title.trim().isEmpty()) {
                    request.setAttribute("error", "제목을 입력해주세요.");
                    return "/post/QandA.jsp";
                }
                
                if (content == null || content.trim().isEmpty()) {
                    request.setAttribute("error", "문의 내용을 입력해주세요.");
                    return "/post/QandA.jsp";
                }
                
                if (content.trim().length() < 10) {
                    request.setAttribute("error", "문의 내용은 최소 10자 이상 입력해주세요.");
                    return "/post/QandA.jsp";
                }
                
                // 문의 등록
                int result = InquiryDAO.insertInquiry(member_idx, category, title, content, file_path, status);
                
                if (result > 0) {
                    // 성공 시 문의 목록으로 이동
                    request.setAttribute("success", "문의가 성공적으로 등록되었습니다.");
                    return "Controller?type=inquiryList";
                } else {
                    request.setAttribute("error", "문의 등록에 실패했습니다. 다시 시도해주세요.");
                    return "/post/QandA.jsp";
                }
                
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "문의 등록 중 오류가 발생했습니다.");
                return "/post/QandA.jsp";
            }
        }
        
        // GET 요청인 경우 문의 작성 페이지로 이동
        return "/post/QandA.jsp";
    }
}
