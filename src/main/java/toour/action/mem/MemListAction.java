package toour.action.mem;

import toour.action.Action;
import toour.dao.MemberDAO;
import toour.dao.memDAO;
import toour.util.Paging;
import mybatis.vo.MemberVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemListAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        //파라미터 받기
        String member_idx = request.getParameter("member_idx");


        //총 게시물의 수를 얻어냄
        int totalCount = memDAO.getTotalMemCount();

        //페이징 처리를 위한 객체 생성
        Paging page = new Paging(10, 5);

        page.setTotalCount(totalCount);//총 페이지 수까지 구했다

        //현재 페이지 값을 파라미터로 받는다.
        String cPage = request.getParameter("cPage");
        if(cPage == null){
            page.setNowPage(1);
        }else{
            int nowPage = Integer.parseInt(cPage); //"2" -> 2
            page.setNowPage(nowPage);
            //게시물을 추출할 때 사용되는 begin과 end가 구해지고,
            //startPage와 endPage도 같이 구해졌다.
        }

        //DAO를 호출하여 원하는 게시글 목록을 받아야 한다.
        MemberVO[] ar = memDAO.getmemList(page.getBegin(), page.getEnd());

        // JSP에서 표현하기 위해서 request에 저장!
        System.out.println(ar.length);
        System.out.println(ar[1].getMember_password());
        request.setAttribute("ar", ar);
        request.setAttribute("page", page);
        request.setAttribute("nowPage", page.getNowPage());

        return "admin_mem.jsp";
    }
}
