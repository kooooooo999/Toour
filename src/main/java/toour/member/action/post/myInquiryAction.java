package toour.member.action.post;

import toour.action.Action;
import toour.member.vo.MemberVO;
import toour.post.dao.InquiryDAO;
import toour.post.dao.PostDAO;
import toour.post.vo.InquiryVO;
import toour.post.vo.PostVO;
import toour.util.Paging;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class myInquiryAction implements Action{
    //페이징을 사용하려고 새로 생성
    int numPerPage = 5;
    int pagePerBlock = 5;

    Paging p = new Paging(numPerPage, pagePerBlock);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //회원 정보 가져오기
        Object obj = request.getSession().getAttribute("member");
        MemberVO mvo = null;
        //회원정보 가져오기에 성공하면 형 변환
        if(obj !=null){
            mvo = (MemberVO) obj;
        }


        String nPage = request.getParameter("nPage");
        String totalCount = request.getParameter("totalCount");
        //혹시라도 현재 페이지가 넘어오지 않았을 경우 1로 초기화
        if(nPage ==null){
            nPage = "1";
        }
        //총 게시글 수가
        if(totalCount !=null){
            p.setTotalCount(Integer.parseInt(totalCount));
            p.setNowPage(Integer.parseInt(nPage));
            request.setAttribute("InquiryPage",p);
        }

        //회원의 식별자를 가져와서 게시물 혹은 댓글 찾기
        String member_idx = mvo.getMember_idx();

        int numPerPage = p.getNumPerPage();
        int currentPage = p.getNowPage();

        InquiryVO[] myInquiry = InquiryDAO.getMyInquiryList(mvo.getMember_idx(), currentPage, numPerPage);






        request.setAttribute("myInquiry_ar", myInquiry);

        return "member/myInquiry.jsp";

    }
}
