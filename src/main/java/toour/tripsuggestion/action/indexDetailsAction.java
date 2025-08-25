package toour.tripsuggestion.action;

import toour.action.Action;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class indexDetailsAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String contentTypeid = request.getParameter("contentTypeId");

        StringBuilder sb = new StringBuilder("http://apis.data.go.kr/B551011/KorService2/areaBasedList2?");
        String key = "serviceKey=QZqnwRRbk91dk1rSfVmLByXYHxG5LXUX03kbhu31XCqODQh1%2BJAgNigVraqO%2F1sEZtE3mOCC6FV4JZjPXy73xw%3D%3D";

        sb.append(key);
        sb.append("&MobileApp=AppTest&MobileOS=ETC&arrange=6");
        sb.append("&contentTypeId=");
        sb.append(contentTypeid);
        sb.append("&_type=xml&numOfRows=1&pageNo=1");

        return "tripDetails.jsp";
    }
}
