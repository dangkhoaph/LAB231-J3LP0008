package khoaphd.discount;

import java.io.Serializable;
import java.sql.Date;

/**
 *
 * @author KhoaPHD
 */
public class DiscountDTO implements Serializable {
    
    private String discountId;
    private String discountName;
    private int percentage;
    private Date expiryDate;

    public DiscountDTO() {
    }

    public DiscountDTO(String discountId, String discountName, int percentage, Date expiryDate) {
        this.discountId = discountId;
        this.discountName = discountName;
        this.percentage = percentage;
        this.expiryDate = expiryDate;
    }

    public String getDiscountId() {
        return discountId;
    }

    public void setDiscountId(String discountId) {
        this.discountId = discountId;
    }

    public String getDiscountName() {
        return discountName;
    }

    public void setDiscountName(String discountName) {
        this.discountName = discountName;
    }

    public int getPercentage() {
        return percentage;
    }

    public void setPercentage(int percentage) {
        this.percentage = percentage;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }
}