package toour.member.action;

import toour.action.Action;
import toour.member.dao.ZzimDAO;
import toour.member.vo.MemberVO;
import toour.member.vo.ZzimVO;
import toour.tripsuggestion.vo.DataVO;
import toour.util.GetAPIData;
import toour.util.Paging;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class myZzimlistAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Object obj = request.getSession().getAttribute("member");
        MemberVO mvo = null;
        DataVO[] data_ar=null;
        int numPerPage=6;
        int pagePerBlock =5;

        String nPage_s = request.getParameter("nPage");
        int nPage = 1;
        if(nPage_s!=null)
            nPage = Integer.parseInt(nPage_s);
        Paging page = new Paging(numPerPage, pagePerBlock);
        if (obj != null) {
            mvo = (MemberVO) obj;
        }

        //찜 목록 가져오기
        ZzimVO[] zzim_ar = ZzimDAO.getZzimAr(mvo.getMember_idx());
        if (zzim_ar!=null) {
            data_ar = new DataVO[numPerPage];
            page.setTotalCount(zzim_ar.length);
            page.setNowPage(nPage);

            System.out.println("page.getTotalCount():"+page.getTotalCount());
            System.out.println("page.getTotalPage():"+page.getTotalPage());
            System.out.println("page.getBegin():"+page.getBegin());
            System.out.println("page.getEnd():"+page.getEnd());
            System.out.println("page.getNowPage():"+page.getNowPage());
            int cnt =0;
            for (int zzim_cnt = (page.getBegin()-1);zzim_cnt<zzim_ar.length&&zzim_cnt<= (page.getEnd()-1) ; zzim_cnt++) {
                data_ar[cnt++]=GetAPIData.getDataVO_detail(zzim_ar[zzim_cnt].getZzim_content_id());
                System.out.println("data_ar[cnt].getOverview():"+data_ar[cnt-1].getFirstimage());
            }
        }
        System.out.println("data_ar.length:"+data_ar.length);

        request.setAttribute("dataAr", data_ar);
        request.setAttribute("page", page);

        return "member/myZzimList.jsp";
    }
}
