package toour.member.action.post;

import toour.action.Action;
import toour.member.dao.AdminNoticeDAO;
import toour.post.dao.ReportDAO;
import toour.post.vo.PostVO;
import toour.post.vo.ReportVO;
import toour.util.Paging;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminReportSearchAction implements Action{
        @Override
        public String execute(HttpServletRequest request, HttpServletResponse response) {
            String searchType = request.getParameter("searchType");

            int TotalCount = ReportDAO.getSearchTotalCount(searchType);

            Paging page = new Paging(10,5);

            page.setTotalCount(TotalCount);

            String cPage = request.getParameter("cPage");

            if (cPage == null)
                page.setNowPage(1);
            else{
                int nowPage= Integer.parseInt(cPage);
                page.setNowPage(nowPage);
            }

            ReportVO[] rvo = ReportDAO.search(searchType, page.getBegin(),page.getEnd());

            if(rvo!=null &&rvo.length>0)
                System.out.println("검색 결과 첫 번째 항목: " + rvo[0]);
            else
                System.out.println("검색결과가 없습니다.");
//        System.out.println(ar[0]);

            request.setAttribute("page",page);
            request.setAttribute("rvo",rvo);
            request.setAttribute("TotalCount",TotalCount);
            request.setAttribute("searchType",searchType);
            request.setAttribute("nowPage",page.getNowPage());

            return "admin/admin_report.jsp";
        }
    }


