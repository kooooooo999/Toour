package toour.login.action;


import toour.action.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class chkPwAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String u_pw = request.getParameter("u_pw");
        
        boolean usable = false;
        String alertText = null;

        if(u_pw != null && !u_pw.trim().isEmpty()){
            char[] ar = u_pw.toCharArray();
            boolean hasSpecialChar = false; // 특수문자 포함 여부
            boolean hasNumber = false; // 숫자 포함 여부
            int pw_len = 8; // 8자 이상으로 변경
            
            // 비밀번호 입력 규정 검사 (8자 이상, 숫자 + 특수문자 포함, 대소문자 구분 없음)
            for(char c : ar){
                if(c >= 48 && c <= 57){
                    //비밀번호 내에 숫자가 하나라도 있을 때
                    hasNumber = true;
                } else if((c >= 33 && c <= 47) || (c >= 58 && c <= 64) || (c >= 91 && c <= 96) || (c >= 123 && c <= 126)){
                    //비밀번호 내에 특수기호가 하나라도 있을 때
                    hasSpecialChar = true;
                }
            }

            if(hasSpecialChar && hasNumber){
                if(u_pw.length() >= pw_len) {
                    alertText = "비밀번호 사용이 가능합니다.";
                    usable = true;
                } else {
                    alertText = pw_len + "자 이상 기입해주세요";
                }
            } else {
                alertText = "숫자와 특수문자를 모두 포함하여 구성해주세요";
            }
        } else {
            alertText = "비밀번호를 입력해주세요.";
        }

        request.setAttribute("usable", usable);
        request.setAttribute("alertText", alertText);
        return "inspection.jsp";
    }
}
