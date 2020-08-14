package khoaphd.utils;

import java.io.IOException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Request;
import org.apache.log4j.Logger;

/**
 *
 * @author KhoaPHD
 */
public class NetUtils {
    
    private static final Logger LOGGER = Logger.getLogger(NetUtils.class);
    
    public static String getResult(String url) {
        try {
            return Request.Get(url).setHeader("Accept-Charset", "utf-8").execute().returnContent().asString();
        } catch (ClientProtocolException ex) {
            LOGGER.fatal(ex.getMessage());
        } catch (IOException ex) {
            LOGGER.fatal(ex.getMessage());
        }
        return null;
    }
}