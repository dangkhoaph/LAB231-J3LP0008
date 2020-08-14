package khoaphd.booking;

import java.io.Serializable;

/**
 *
 * @author KhoaPHD
 */
public class BookingDTO implements Serializable {
    
    private String userId;
    private String discountId;

    public BookingDTO() {
    }

    public BookingDTO(String userId) {
        this.userId = userId;
    }
    
    public BookingDTO(String userId, String discountId) {
        this.userId = userId;
        this.discountId = discountId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getDiscountId() {
        return discountId;
    }

    public void setDiscountId(String discountId) {
        this.discountId = discountId;
    }
}