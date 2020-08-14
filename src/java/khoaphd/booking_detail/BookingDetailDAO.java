package khoaphd.booking_detail;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import khoaphd.utils.DBUtilities;

/**
 *
 * @author KhoaPHD
 */
public class BookingDetailDAO implements Serializable {
    
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
    
    public int getCurrentTotalAmountOfTour(int tourId) throws Exception {
        int result = 0;
        try {
            conn = DBUtilities.makeConnection();
            if (conn != null) {
                String sql = "SELECT SUM([Amount]) AS Result "
                        + "FROM Booking, BookingDetail, Tour "
                        + "WHERE Booking.[BookingId] = BookingDetail.[BookingId] "
                        + "AND BookingDetail.[TourId] = Tour.[TourId] "
                        + "AND Booking.[StatusId] = ? AND Tour.[StatusId] = ? "
                        + "AND BookingDetail.[TourId] = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, STATUS_ACTIVE);
                preStm.setInt(2, STATUS_ACTIVE);
                preStm.setInt(3, tourId);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    result = rs.getInt("Result");
                }
            }
        } finally {
            closeConnection();
        }
        return result;
    }
    
    public void insertNewBookingDetail(BookingDetailDTO dto) throws Exception {
        try {
            conn = DBUtilities.makeConnection();
            if (conn != null) {
                String sql = "INSERT INTO BookingDetail([BookingId], [TourId], [Amount]) "
                        + "VALUES(?, ?, ?)";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, dto.getBookingId());
                preStm.setInt(2, dto.getTourId());
                preStm.setInt(3, dto.getAmount());
                preStm.executeUpdate();
            }
        } finally {
            closeConnection();
        }
    }
}