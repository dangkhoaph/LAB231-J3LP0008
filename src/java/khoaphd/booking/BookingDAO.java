package khoaphd.booking;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import khoaphd.utils.DBUtilities;

/**
 *
 * @author KhoaPHD
 */
public class BookingDAO implements Serializable {
    
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
    
    public int insertNewBooking(BookingDTO dto) throws Exception {
        int bookingId = 0;
        try {
            conn = DBUtilities.makeConnection();
            if (conn != null) {
                String sql = "INSERT INTO Booking([UserId], [BookingDate], [DiscountId], [StatusId]) "
                        + "OUTPUT inserted.[BookingId] "
                        + "VALUES(?, ?, ? , ?)";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, dto.getUserId());
                preStm.setDate(2, new Date(System.currentTimeMillis()));
                preStm.setString(3, dto.getDiscountId());
                preStm.setInt(4, STATUS_ACTIVE);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    bookingId = rs.getInt("BookingId");
                }
            }
        } finally {
            closeConnection();
        }
        return bookingId;
    }
}