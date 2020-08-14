package khoaphd.users;

import java.io.Serializable;

/**
 *
 * @author KhoaPHD
 */
public class UsersDTO implements Serializable {
    
    private String userId;
    private String fullName;
    private String roleName;
    private String facebookId;
    private String facebookLink;

    public UsersDTO() {
    }

    public UsersDTO(String userId, String fullName, String roleName) {
        this.userId = userId;
        this.fullName = fullName;
        this.roleName = roleName;
    }

    public UsersDTO(String userId, String fullName, String facebookId, String facebookLink) {
        this.userId = userId;
        this.fullName = fullName;
        this.facebookId = facebookId;
        this.facebookLink = facebookLink;
    }
    
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getFacebookId() {
        return facebookId;
    }

    public void setFacebookId(String facebookId) {
        this.facebookId = facebookId;
    }

    public String getFacebookLink() {
        return facebookLink;
    }

    public void setFacebookLink(String facebookLink) {
        this.facebookLink = facebookLink;
    }
}