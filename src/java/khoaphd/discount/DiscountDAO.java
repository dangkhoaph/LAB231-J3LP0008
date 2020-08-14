package khoaphd.discount;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import khoaphd.utils.DBUtilities;

/**
 *
 * @author KhoaPHD
 */
public class DiscountDAO {
    
    private static final int STATUS_ACTIVE = 1;
    
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
    
    public boolean isDiscountCodeUsed(String userId, String discountCode) throws Exception {
        boolean isUsed = false;
        try {
            conn = DBUtilities.makeConnection();
            if (conn != null) {
                String sql = "SELECT Booking.[DiscountId] "
                        + "FROM Discount, Booking "
                        + "WHERE Discount.[DiscountId] = Booking.[DiscountId] "
                        + "AND Booking.[StatusId] = ? AND Booking.[UserId] = ? "
                        + "AND Discount.[DiscountId] = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, STATUS_ACTIVE);
                preStm.setString(2, userId);
                preStm.setString(3, discountCode);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    isUsed = true;
                }
            }
        } finally {
            closeConnection();
        }
        return isUsed;
    }
    
    public DiscountDTO findDiscountCode(String discountCode) throws Exception {
        DiscountDTO dto = null;
        try {
            conn = DBUtilities.makeConnection();
            if (conn != null) {
                String sql = "SELECT [DiscountId], [DiscountName], [Percentage], [ExpiryDate] "
                        + "FROM Discount "
                        + "WHERE [DiscountId] = ? AND [ExpiryDate] > ?";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, discountCode);
                preStm.setDate(2, new Date(System.currentTimeMillis()));
                rs = preStm.executeQuery();
                if (rs.next()) {
                    String discountId = rs.getString("DiscountId");
                    String discountName = rs.getString("DiscountName");
                    int percentage = rs.getInt("Percentage");
                    Date expiryDate = rs.getDate("ExpiryDate");
                    
                    dto = new DiscountDTO(discountId, discountName, percentage, expiryDate);
                }
            }
        } finally {
            closeConnection();
        }
        return dto;
    }
}