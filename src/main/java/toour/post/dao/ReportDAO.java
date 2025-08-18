package toour.post.dao;

import java.util.HashMap;
import java.util.Map;

import mybatis.service.FactoryService;
import org.apache.ibatis.session.SqlSession;

public class ReportDAO {
    // 신고 등록 (DB 저장)
    public static int insertReport(String reporter_idx, String reported_idx, String post_idx,
                                   String report_content, String target_type) {

        // 파라미터를 맵에 담아서 전달
        Map<String, String> map = new HashMap<>();
        map.put("reporter_idx", reporter_idx);   // 신고한 사람
        map.put("reported_idx", reported_idx);   // 신고당한 사람
        map.put("post_idx", post_idx);           // 신고 대상 게시글 ID
        map.put("report_content", report_content); // 신고 내용
        map.put("target_type", target_type);     // 대상 종류(게시글/댓글 등)

        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.insert("report.insertReport", map); // report.xml에 있는 insertReport 실행

        if (cnt > 0)
            ss.commit();
        else
            ss.rollback();

        ss.close();
        return cnt;
    }
}
