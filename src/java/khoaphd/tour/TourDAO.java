package khoaphd.tour;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import khoaphd.utils.DBUtilities;

/**
 *
 * @author KhoaPHD
 */
public class TourDAO implements Serializable {
    
    public static final int ROWS_PER_PAGE = 20;
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
    
    public List<TourDTO> searchTours(String searchPlace, Date searchDateFrom, Date searchDateTo,
            Double searchPriceFrom, Double searchPriceTo, int page) throws Exception {
        List<TourDTO> list = new ArrayList<>();
        try {
            conn = DBUtilities.makeConnection();
            if (conn != null) {
                String sql = "SELECT [TourId], [TourName], [Place], [FromDate], [ToDate], [Price], [ImageLink] "
                        + "FROM Tour "
                        + "WHERE [StatusId] = ? ";
                if (searchPlace != null)
                    sql += "AND [Place] LIKE ? ";
                if (searchDateFrom != null)
                    sql += "AND [FromDate] >= ? ";
                if (searchDateTo != null)
                    sql += "AND [ToDate] <= ? ";
                if (searchPriceFrom != null)
                    sql += "AND [Price] >= ? ";
                if (searchPriceTo != null)
                    sql += "AND [Price] <= ? ";
                sql += "ORDER BY [FromDate], [ToDate] "
                        + "OFFSET ? ROWS "
                        + "FETCH NEXT ? ROWS ONLY";
                
                preStm = conn.prepareStatement(sql);
                int i = 1;
                preStm.setInt(i++, STATUS_ACTIVE);
                if (searchPlace != null)
                    preStm.setString(i++, "%" + searchPlace + "%");
                if (searchDateFrom != null)
                    preStm.setDate(i++, searchDateFrom);
                if (searchDateTo != null)
                    preStm.setDate(i++, searchDateTo);
                if (searchPriceFrom != null)
                    preStm.setDouble(i++, searchPriceFrom);
                if (searchPriceTo != null)
                    preStm.setDouble(i++, searchPriceTo);
                preStm.setInt(i++, (page - 1) * ROWS_PER_PAGE);
                preStm.setInt(i++, ROWS_PER_PAGE);
                
                rs = preStm.executeQuery();
                while (rs.next()) {                    
                    int tourId = rs.getInt("TourId");
                    String tourName = rs.getString("TourName");
                    String place = rs.getString("Place");
                    Date fromDate = rs.getDate("FromDate");
                    Date toDate = rs.getDate("ToDate");
                    double price = rs.getDouble("Price");
                    String imageLink = rs.getString("ImageLink");
                    
                    TourDTO dto = new TourDTO(tourId, tourName, place, fromDate, toDate, price, imageLink);
                    list.add(dto);
                }
            }
        } finally {
            closeConnection();
        }
        return list;
    }
    
    public int getSearchToursCount(String searchPlace, Date searchDateFrom, Date searchDateTo,
            Double searchPriceFrom, Double searchPriceTo) throws Exception {
        int result = 0;
        try {
            conn = DBUtilities.makeConnection();
            if (conn != null) {
                String sql = "SELECT COUNT([TourId]) AS Result "
                        + "FROM Tour "
                        + "WHERE [StatusId] = ? ";
                if (searchPlace != null)
                    sql += "AND [Place] LIKE ? ";
                if (searchDateFrom != null)
                    sql += "AND [FromDate] >= ? ";
                if (searchDateTo != null)
                    sql += "AND [ToDate] <= ? ";
                if (searchPriceFrom != null)
                    sql += "AND [Price] >= ? ";
                if (searchPriceTo != null)
                    sql += "AND [Price] <= ? ";
                
                preStm = conn.prepareStatement(sql);
                int i = 1;
                preStm.setInt(i++, STATUS_ACTIVE);
                if (searchPlace != null)
                    preStm.setString(i++, "%" + searchPlace + "%");
                if (searchDateFrom != null)
                    preStm.setDate(i++, searchDateFrom);
                if (searchDateTo != null)
                    preStm.setDate(i++, searchDateTo);
                if (searchPriceFrom != null)
                    preStm.setDouble(i++, searchPriceFrom);
                if (searchPriceTo != null)
                    preStm.setDouble(i++, searchPriceTo);
                
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
    
    public boolean insertNewTour(TourDTO dto) throws Exception {
        boolean result = false;
        try {
            conn = DBUtilities.makeConnection();
            if (conn != null) {
                String sql = "INSERT INTO Tour([TourName], [Place], [FromDate], [ToDate], [Price], [Quota], [ImageLink], [ImportDate], [StatusId]) "
                        + "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, dto.getTourName());
                preStm.setString(2, dto.getPlace());
                preStm.setDate(3, dto.getFromDate());
                preStm.setDate(4, dto.getToDate());
                preStm.setDouble(5, dto.getPrice());
                preStm.setInt(6, dto.getQuota());
                preStm.setString(7, dto.getImageLink());
                preStm.setDate(8, dto.getImportDate());
                preStm.setInt(9, STATUS_ACTIVE);
                result = preStm.executeUpdate() > 0;
            }
        } finally {
            closeConnection();
        }
        return result;
    }
    
    public TourDTO getTourById(int tourId) throws Exception {
        TourDTO dto = null;
        try {
            conn = DBUtilities.makeConnection();
            if (conn != null) {
                String sql = "SELECT [TourName], [Place], [FromDate], [ToDate], [Price], [ImageLink] "
                        + "FROM Tour "
                        + "WHERE [TourId] = ? AND [StatusId] = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, tourId);
                preStm.setInt(2, STATUS_ACTIVE);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    String tourName = rs.getString("TourName");
                    String place = rs.getString("Place");
                    Date fromDate = rs.getDate("FromDate");
                    Date toDate = rs.getDate("ToDate");
                    double price = rs.getDouble("Price");
                    String imageLink = rs.getString("ImageLink");
                    
                    dto = new TourDTO(tourId, tourName, place, fromDate, toDate, price, imageLink);
                }
            }
        } finally {
            closeConnection();
        }
        return dto;
    }
    
    public int getQuotaById(int tourId) throws Exception {
        int quota = 0;
        try {
            conn = DBUtilities.makeConnection();
            if (conn != null) {
                String sql = "SELECT [Quota] "
                        + "FROM Tour "
                        + "WHERE [TourId] = ? AND [StatusId] = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, tourId);
                preStm.setInt(2, STATUS_ACTIVE);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    quota = rs.getInt("Quota");
                }
            }
        } finally {
            closeConnection();
        }
        return quota;
    }
}