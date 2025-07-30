package mybatis.service;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.Reader;

public class FactoryService {
    private static SqlSessionFactory factory;
    static {
        try {
            Reader r = Resources.getResourceAsReader("mybatis/config/config.xml");
            factory = new SqlSessionFactoryBuilder().build(r);
            r.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    public static SqlSessionFactory getFactory() {
        return factory;
    }
}
