package khoaphd.utils;

import java.io.Serializable;
import java.sql.Connection;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

/**
 *
 * @author KhoaPHD
 */
public class DBUtilities implements Serializable {
    
    public static Connection makeConnection() throws Exception {
        Context context = new InitialContext();
        Context tomcat = (Context) context.lookup("java:comp/env");
        DataSource ds = (DataSource) tomcat.lookup("SE140609DS");
        Connection conn = ds.getConnection();
        return conn;
    }
}