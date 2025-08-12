package toour.notice.dao;

import mybatis.service.FactoryService;
import toour.post.vo.FileVO;
import org.apache.ibatis.session.SqlSession;

import javax.swing.*;
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
    public static List<FileVO> getFilesByPost(String post_idx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<FileVO> list = ss.selectList("file.selectByPost", post_idx);
        FileVO[] ar = null;
        if (list != null && list.size() > 0) {

        }
        ss.close();
        return list;
    }
    public static List<FileVO> getFileList(String post_idx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<FileVO> list = ss.selectList("file.selectByPost", post_idx);
        ss.close();
        return list;
    }

    public static FileVO getFile(String post_idx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        FileVO vo = ss.selectOne("file.selectByPost", post_idx);
        ss.close();
        return vo;
    }
    public static int fileadd(String post_idx, String file_name_original, String file_name_stored, String file_s3_url, String file_size, String file_type) {
        int cnt = 0;
        Map<String, String> map = new HashMap<>();
        map.put("post_idx", post_idx);
        map.put("file_name_original", file_name_original);
        map.put("file_name_stored", file_name_stored);
        map.put("file_s3_url", file_s3_url);
        map.put("file_size", file_size);
        map.put("file_type", file_type);

        SqlSession ss = FactoryService.getFactory().openSession();
        cnt = ss.insert("file.add_file", map);

        if (cnt > 0)
            ss.commit();
        else
            ss.rollback();
        ss.close();

        return cnt;
    }

    public static void fileDelete(String post_idx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.delete("file.deleteFile", post_idx);
        if (cnt > 0)
            ss.commit();
        else
            ss.rollback();

        ss.close();
    }
}

