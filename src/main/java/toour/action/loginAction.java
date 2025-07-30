package toour.action;


import mybatis.vo.MemberVO;
import toour.dao.MemberDAO;
import toour.util.Hash;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class loginAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String viewPath=null;
        String u_id =request.getParameter("u_id");

        if(u_id!=null){
            MemberVO mvo = MemberDAO.getMem(u_id);
            if(mvo!=null){

                String u_pw = request.getParameter("u_pw");
                String salt = mvo.getMember_salt();
                String hash_pw =Hash.getHash(salt+u_pw);
                if(mvo.getMember_password().equals(hash_pw)){
                    viewPath = "index.jsp";
                    request.getSession().setAttribute("user",mvo);
                }else
                    viewPath ="login.jsp";
            }else
                viewPath ="login.jsp";
        }else {
            viewPath="login.jsp";
        }

        return viewPath;
    }
}
