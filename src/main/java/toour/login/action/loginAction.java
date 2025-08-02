package toour.login.action;


import toour.action.Action;
import toour.member.vo.MemberVO;
import toour.login.dao.MemberDAO;
import toour.util.Hash;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class loginAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String viewPath=null;
        String u_id =request.getParameter("u_id");
        if(request.getSession().getAttribute("user")==null){
            //로그인이 안 되어 있을 때
            if(u_id!=null){
                //요청으로부터 id를 잘받아옴
                MemberVO mvo = MemberDAO.getMem(u_id);
                if(mvo!=null){
                    //입력한 id가 db에 있을때
                    String u_pw = request.getParameter("u_pw");
                    String salt = mvo.getMember_salt();
                    String hash_pw =Hash.getHash(salt+u_pw);
                    if(mvo.getMember_password().equals(hash_pw)){
                        //입력한 비밀번호와 db에 저장된 비밀번호가 같을 때
                        viewPath = "index.jsp";
                        request.getSession().setAttribute("user",mvo);
                    }else
                        //입력한 비밀번호와 db에 저장된 비밀번호가 다를 때
                        viewPath ="login.jsp";
                }else
                    //입력한 id가 db에 없을 때
                    viewPath ="login.jsp";
            }else {
                viewPath="login.jsp";
            }
        }else {
            //로그아웃 눌렀을 때
            request.getSession().removeAttribute("user");
        }

        return viewPath;
    }
}
