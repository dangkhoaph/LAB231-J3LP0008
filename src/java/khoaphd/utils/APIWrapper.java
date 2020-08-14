package khoaphd.utils;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import khoaphd.users.UsersDTO;
import org.json.JSONObject;
import org.json.JSONTokener;

/**
 *
 * @author KhoaPHD
 */
public class APIWrapper {
    
    private static String appID = "781995735904833";
    private static String appSecret = "fa15e4ba265d247b8d70c1756e5274db";
    private static String redirectUrl = "http://localhost:8080/J3LP0008_SE140609/loginFB";
    private String accessToken;

    public String getAccessToken() {
        return accessToken;
    }

    public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
    }
    
    public static String getDialogLink() {
        String testUrl = "https://www.facebook.com/dialog/oauth?client_id=" + appID
                + "&redirect_uri=" + redirectUrl
                + "&scope=user_link%2Cemail%2Cpublic_profile";
        return testUrl;
    }
    
    public String getAccessToken(String code) {
        String accessTokenLink = "https://graph.facebook.com/oauth/access_token"
                + "?client_id=%s"
                + "&client_secret=%s"
                + "&redirect_uri=%s"
                + "&code=%s";
        accessTokenLink = String.format(accessTokenLink, appID, appSecret, redirectUrl, code);
        
        String result = NetUtils.getResult(accessTokenLink);
        String token = result.substring(result.indexOf(":") + 2, result.indexOf(",") - 1);
        return token;
    }
    
    public UsersDTO getUserInfo() throws MalformedURLException, IOException {
        String infoUrl = "https://graph.facebook.com/v7.0/me?fields=id%2Cname%2Clink%2Cemail&access_token=";
        infoUrl = infoUrl + this.accessToken;
        
        URL url = new URL(infoUrl);
        JSONTokener tokener = new JSONTokener(url.openStream());
        JSONObject obj = new JSONObject(tokener);
        
        String userId = obj.getString("email");
        String fullName = obj.getString("name");
        String facebookId = obj.getString("id");
        String facebookLink = obj.getString("link");
        
        UsersDTO dto = new UsersDTO(userId, fullName, facebookId, facebookLink);
        return dto;
    }
}