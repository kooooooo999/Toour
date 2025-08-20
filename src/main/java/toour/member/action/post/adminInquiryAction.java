package toour.member.action.post;

import toour.action.Action;
import toour.post.dao.InquiryDAO;
import toour.post.vo.InquiryVO;
import toour.util.Paging;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;

public class adminInquiryAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pageType = request.getParameter("pageType");
        String viewPath = "admin/admin_Inquiry.jsp";
        if ("inquiryDetails".equals(pageType)) {
            //문의글 상세보기
            viewPath = "admin/inquiryDetails.jsp";
            String idx = request.getParameter("idx");
            String category = request.getParameter("category");
            String title = request.getParameter("title");
            String nickname = request.getParameter("nickname");
            String status = request.getParameter("status");
            String file = request.getParameter("file");
            String created = request.getParameter("created");
            String content = request.getParameter("content");
            InquiryVO inquiryVO = new InquiryVO();
            inquiryVO.setInquiry_idx(idx);
            inquiryVO.setCategory(category);
            inquiryVO.setTitle(title);
            inquiryVO.setMember_nickname(nickname);
            inquiryVO.setStatus(status);
            inquiryVO.setCreated_at(created);
            inquiryVO.setContent(content);
            inquiryVO.setFile_path(file);
            request.setAttribute("reqInquiry", inquiryVO);

            String answer = request.getParameter("answer");
            if ("1".equals(answer)) {
                //답변 등록 버튼을 클릭했을 시
                viewPath = "admin/admin_Inquiry.jsp";
                String answer_content = request.getParameter("answer_content");
                String answer_inquiry_idx = request.getParameter("inquiry_idx");
                String answer_status = request.getParameter("status");
                if (answer_status.equals("대기")) {
                    InquiryDAO.updateInquirydata(answer_inquiry_idx, "답변완료", answer_content);
                }
            }
            try {
                // 파일 업로드를 위한 설정
                ServletContext application = request.getServletContext();
                String realPath = application.getRealPath("/inquiry_upload/");

                // 디렉토리가 없으면 생성
                File dir = new File(realPath);
                if (!dir.exists()) {
                    dir.mkdirs();
                }

                String fileName = "/inquiry_upload/" + file;
                request.setAttribute("fileName", fileName);

            } catch (Exception e) {
                e.printStackTrace();
            }

        }
        //문의 테이블 총 수 가져옴
        int cnt = InquiryDAO.getInquiryTotalCount();
        //Page 생성
        Paging page = new Paging(10, 5);
        page.setTotalCount(cnt);
        String cPage = request.getParameter("cPage");
        if (cPage == null || cPage.isEmpty() || cPage.equals("null")) {
            page.setNowPage(1);
        } else {
            int nowPage = Integer.parseInt(cPage); //"2" -> 2
            page.setNowPage(nowPage);
            //게시물을 추출할 때 사용되는 begin과 end가 구해지고,
            //startPage와 endPage도 같이 구해졌다.
        }

        //table에 표현될 DB 데이터 값 가져옴, Paging의 begin은 1부터 시작, DB는 0부터 계산하기에 -1 해줘야함
        InquiryVO[] IvoArr = InquiryDAO.getInquiryTotaldata(page.getBegin() - 1, page.getNumPerPage());
        //searchType을 받아 DB 데이터 값 가져옴
        String searchType = request.getParameter("searchType");
        InquiryVO[] cateAr = InquiryDAO.searchCategorydata(searchType);
        request.setAttribute("page", page);
        request.setAttribute("IvoArr", IvoArr);
        request.setAttribute("cateAr", cateAr);

        return viewPath;
    }
}
