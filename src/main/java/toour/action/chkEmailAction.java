package toour.action;

import mybatis.vo.MemberVO;
import toour.dao.MemberDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class chkEmailAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String u_email =request.getParameter("u_email");
        String u_emailAddr = request.getParameter("emailAddr");
        String email_total =u_email+"@"+u_emailAddr;

        System.out.println(email_total);
        boolean usable = false;
        String alertText = null;


        if(email_total !=null){
            MemberVO mvo = MemberDAO.getMemE(email_total);
            if(mvo!=null){
                // 중복 메일이 있으으로 사용 불가능
                alertText = "이미 사용 중인 메일입니다. 한 메일 당 한 계정이 원칙입니다.";
            }else{
                alertText = "사용 가능한 메일입니다!";
                usable= true;
            }
        }
        request.setAttribute("usable",usable);
        request.setAttribute("alertText",alertText);
        return "inspection.jsp";
    }
}
