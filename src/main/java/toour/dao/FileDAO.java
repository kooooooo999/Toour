package toour.dao;

import mybatis.service.FactoryService;
import mybatis.vo.FileVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FileDAO {

    // 파일 저장
    public static int insertFile(String file_name_original, String file_name_stored, String post_idx) {
        Map<String, String> map = new HashMap<>();
        map.put("file_name_original", file_name_original);
        map.put("file_name_stored", file_name_stored);
        map.put("post_idx", post_idx);

        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.insert("file.insert", map);
        if (cnt > 0) ss.commit();
        else ss.rollback();
        ss.close();

        return cnt;
    }

    // 게시글 번호로 첨부파일 목록 조회
    public static FileVO[] getFilesByPost(String post_idx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<FileVO> list = ss.selectList("file.selectByPost", post_idx);
        FileVO[] ar = null;
        if (list != null && list.size() > 0) {
            ar = new FileVO[list.size()];
            list.toArray(ar);
        }
        ss.close();
        return ar;
    }
}

