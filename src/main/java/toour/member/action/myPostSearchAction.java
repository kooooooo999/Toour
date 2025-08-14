package toour.member.action;

import toour.action.Action;
import toour.member.vo.MemberVO;
import toour.post.dao.PostDAO;
import toour.post.vo.PostVO;
import toour.util.Paging;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class myPostSearchAction implements Action {
    String searchType = null;
    String searchValue = null;
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String searchType_request = request.getParameter("searchType");
        if(searchType_request!=null)
            searchType = searchType_request;

        String searchValue_request = request.getParameter("searchValue");
        if(searchValue_request!=null)
            searchValue = request.getParameter("searchValue");

        String category_idx = request.getParameter("category_idx");
        Object obj = request.getSession().getAttribute("member");
        String nPage = request.getParameter("cPage");
        MemberVO mvo = null;
        if(obj!=null){
             mvo = (MemberVO) obj;
        }
        String member_idx = mvo.getMember_idx();
        if (category_idx == null)
            category_idx = "2";

        int numPerPage= 5;
        int pagePerBlock = 5;
        Paging page = new Paging(numPerPage,pagePerBlock);


        int totalCount = PostDAO.getMySearchTotalCount(searchType,searchValue,member_idx);
        System.out.println("totalCount:"+totalCount);
        page.setTotalCount(totalCount);

        if (nPage == null)
            page.setNowPage(1);
        else{
            int nowPage= Integer.parseInt(nPage);
            page.setNowPage(nowPage);
        }
        System.out.println("searchType:"+searchType);
        System.out.println("searchValue:"+searchValue);
        PostVO[] ar = PostDAO.mysearch(searchType,searchValue, page.getBegin(),page.getEnd(),member_idx);
        System.out.println("page.getTotalPage():"+page.getTotalPage());





        if(ar!=null &&ar.length>0)
            System.out.println("검색 결과 첫 번째 항목: " + ar[0]);
        else
            System.out.println("검색결과가 없습니다.");
        System.out.println(ar[0]);

        request.setAttribute("page",page);
        request.setAttribute("myPost_ar",ar);
        request.setAttribute("totalCount",totalCount);
        request.setAttribute("searchType",searchType);
        request.setAttribute("searchValue",searchValue);
        request.setAttribute("nowPage",page.getNowPage());
        return "member/myPost.jsp";
    }
}
