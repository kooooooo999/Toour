//함수가 잘 되는지 확인하기 위한 Action입니다 나중에 삭제하겠습니다(박준형)
package toour.action;

import mybatis.vo.DataVO;
import toour.util.GetAPIData;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class testAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        DataVO dvo = new DataVO();
        dvo.setContentTypeId("12");
        dvo.setAreacode("6");
        dvo.setCat1("A01");
        dvo.setCat2("A0101");

        System.out.println(GetAPIData.getSigungu(request,dvo.getAreacode()).length);
        System.out.println(GetAPIData.getCat1(request,dvo.getContentTypeId()).length);
        System.out.println(GetAPIData.getCat2(request,dvo.getCat1()).length);
        System.out.println(GetAPIData.getCat3(request,dvo.getCat1(),dvo.getCat2()).length);

        return "myPage.jsp";
    }
}
