package toour.action.mem;

import mybatis.vo.MemberVO;
import toour.action.Action;
import toour.dao.memDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;

public class MemViewAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        String member_idx = request.getParameter("member_idx");//기본키
        String cPage = request.getParameter("cPage");//목록보기에 사용할 페이지 값

        //한번이라도 읽은 게시물들은 list에 담아서 HttpSession에 저장
        //그럼 우선 HttpSession으로 부터 list를 얻어내자
        HttpSession session = request.getSession();

        //session에 "read_list"라는 이름으로 저장된 객체를 얻어내자
        ArrayList<MemberVO> list = null;
        Object obj = session.getAttribute("read_list");
        if(obj == null){
            list = new ArrayList<>();
            session.setAttribute("read_list", list);
        }else
            list = (ArrayList<MemberVO>) obj;

        MemberVO vo = memDAO.view(member_idx); //사용자가 선택한 게시물 검색

        request.setAttribute("vo", vo);
        return "admin_view.jsp";
    }
}
