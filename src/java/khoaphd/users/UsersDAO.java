package khoaphd.users;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import khoaphd.utils.DBUtilities;

/**
 *
 * @author KhoaPHD
 */
public class UsersDAO implements Serializable {
    
    private static final int STATUS_ACTIVE = 1;
    private static final int ROLE_USER = 2;
    
    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;
    
    private void closeConnection() throws Exception {
        if (rs != null)
            rs.close();
        if (preStm != null)
            preStm.close();
        if (conn != null)
            conn.close();
    }
    
    public UsersDTO checkLogin(String username, String password) throws Exception {
        UsersDTO dto = null;
        try {
            conn = DBUtilities.makeConnection();
            if (conn != null) {
                String sql = "SELECT [FullName], [RoleName] "
                        + "FROM Users, Role "
                        + "WHERE Users.[RoleId] = Role.[RoleId] "
                        + "AND [UserId] = ? AND [Password] = ? "
                        + "AND [StatusId] = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, username);
                preStm.setString(2, password);
                preStm.setInt(3, STATUS_ACTIVE);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    String fullName = rs.getString("FullName");
                    String roleName = rs.getString("RoleName");
                    
                    dto = new UsersDTO(username, fullName, roleName);
                }
            }
        } finally {
            closeConnection();
        }
        return dto;
    }
    
    public UsersDTO checkLogin(String facebookId) throws Exception {
        UsersDTO dto = null;
        try {
            conn = DBUtilities.makeConnection();
            if (conn != null) {
                String sql = "SELECT [UserId], [FullName], [RoleName] "
                        + "FROM Users, Role "
                        + "WHERE Users.[RoleId] = Role.[RoleId] "
                        + "AND [FacebookId] = ? AND [StatusId] = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, facebookId);
                preStm.setInt(2, STATUS_ACTIVE);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    String userId = rs.getString("UserId");
                    String fullName = rs.getString("FullName");
                    String roleName = rs.getString("RoleName");
                    
                    dto = new UsersDTO(userId, fullName, roleName);
                }
            }
        } finally {
            closeConnection();
        }
        return dto;
    }
    
    public UsersDTO register(String userId, String fullName, String facebookId, String facebookLink) throws Exception {
        UsersDTO dto = null;
        try {
            conn = DBUtilities.makeConnection();
            if (conn != null) {
                String sql = "INSERT INTO Users([UserId], [FullName], [FacebookId], [FacebookLink], [RoleId], [StatusId]) "
                        + "VALUES(?, ?, ?, ?, ?, ?)";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, userId);
                preStm.setString(2, fullName);
                preStm.setString(3, facebookId);
                preStm.setString(4, facebookLink);
                preStm.setInt(5, ROLE_USER);
                preStm.setInt(6, STATUS_ACTIVE);
                if (preStm.executeUpdate() > 0) {
                    dto = new UsersDTO(userId, fullName, "User");
                }
            }
        } finally {
            closeConnection();
        }
        return dto;
    }
}