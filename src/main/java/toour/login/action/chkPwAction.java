package toour.login.action;


import toour.action.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class chkPwAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String u_pw =request.getParameter("u_pw");
        char[] ar = u_pw.toCharArray();
        
        boolean usable = false;
        String alertText = null;

        boolean chk1 =false;
        boolean chk2 =false;
        boolean chk3 =false;
        int pw_len = 9;
        if(u_pw !=null){
            // 비밀번호 입력 규정 검사
            for(char c : ar){
                if((c>=33&&c<=64) || (c>=91&&c<=126)){
                    //아이디 입력 규정을 만족했을 때
                    if((c>=33&&c<=47) || (c>=58&&c<=64)||(c>=91&&c<=96)||(c>=123&&c<=126)){
                        //비밀번호 내에 특수기호가 하나라도 있을 때
                        chk1 =true;
                    } else if(c>=48&&c<=57){
                        //비밀번호 내에 숫자가 하나라도 있을 때
                        chk2 =true;
                    }else if(c>=97&&c<=122){
                        //비밀번호 내에 알파벳이 하나라도 있을 때
                        chk3 =true;
                    }

                    if(chk1&&chk2&&chk3){
                        if(u_pw.length()>=pw_len) {
                            alertText = "비밀번호 양식에 만족되었습니다";;
                            usable = true;
                        }else
                            alertText = pw_len+"자 이상 기입해주세요";
                    }else {
                        alertText = "영문 소문자, 숫자, 특수기호를 모두 사용하여 구성해주세요";
                    }

                }else{
                    //아이디 입력 규정에 불만족했을때
                    alertText = "영문 소문자, 숫자, 특수기호로만 구성하여주세요";
                    break;
                }
            }

        }
        request.setAttribute("usable",usable);
        request.setAttribute("alertText",alertText);
        return "inspection.jsp";
    }
}
