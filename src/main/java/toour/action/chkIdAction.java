package toour.action;

import mybatis.vo.MemberVO;
import toour.dao.MemberDAO;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class chkIdAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String u_id =request.getParameter("u_id");
        char[] ar = u_id.toCharArray();

        boolean usable = false;
        String alertText = null;
        
        //아이디 최소 길이
        int id_len = 8;

        if(u_id !=null){
            // 아이디 입력 규정 검사
            for(char c : ar){
                if((c>=33&&c<=64) || (c>=91&&c<=126)){
                    //아이디 입력 규정을 만족했을 때 이 영역

                    //for문이 끝나고 하단 if문을 실행할지 판단
                    usable =true;
                }else{
                    //아이디 입력 규정에 불만족했을때 이 영역
                    alertText = "영문 소문자, 숫자, 특수기호로만 구성하여주세요";

                    //for문이 끝나고 하단 if문을 실행할지 판단
                    usable= false;
                    break;
                }
            }

            if(usable){
                usable=false;
                MemberVO mvo = MemberDAO.getMem(u_id);
                if(mvo!=null){
                    // 중복 id가 있으으로 사용 불가능
                    alertText = "사용할 수 없는 아이디 입니다.";
                }else{
                    if(u_id.length()>=id_len) {
                        alertText = "사용 가능한 아이디입니다.";
                        usable= true;
                    }else{
                        alertText = id_len+"자 이상 기입해주세요";
                    }
                }
            }
        }
        request.setAttribute("usable",usable);
        request.setAttribute("alertText",alertText);
        return "inspection.jsp";
    }
}
