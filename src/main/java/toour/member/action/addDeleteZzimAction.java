package toour.member.action;

import toour.action.Action;
import toour.member.dao.ZzimDAO;
import toour.member.vo.MemberVO;
import toour.member.vo.ZzimVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class addDeleteZzimAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String state = request.getParameter("state");
        String contentId = request.getParameter("contentId");
        String contentTypeId = request.getParameter("contentTypeId");
        String zzim_type = null;
        if(contentTypeId!=null && contentTypeId.equals("12")){
            zzim_type = "tour";
        }
        Object obj = request.getSession().getAttribute("user");
        MemberVO mvo = null;
        if(obj !=null){
            mvo = (MemberVO) obj;
        }
        String member_idx = mvo.getMember_idx();

        if(state != null && contentId != null) {
            if (state.equals("add")) {
                //찜 목록에 추가할 때 여기

                ZzimDAO.addZzim(member_idx, zzim_type, contentId);
            } else {
                //찜 목록에서 삭제할 때 여기


            }

        }
        return "";
    }
}
