package khoaphd.tour;

import java.io.Serializable;
import java.sql.Date;

/**
 *
 * @author KhoaPHD
 */
public class TourDTO implements Serializable {
    
    private int tourId;
    private String tourName;
    private String place;
    private Date fromDate;
    private Date toDate;
    private double price;
    private int quota;
    private String imageLink;
    private Date importDate;
    private int amount;

    public TourDTO() {
    }

    public TourDTO(int tourId, String tourName, String place, Date fromDate, Date toDate, double price, String imageLink) {
        this.tourId = tourId;
        this.tourName = tourName;
        this.place = place;
        this.fromDate = fromDate;
        this.toDate = toDate;
        this.price = price;
        this.imageLink = imageLink;
    }

    public TourDTO(String tourName, String place, Date fromDate, Date toDate, double price, int quota, String imageLink, Date importDate) {
        this.tourName = tourName;
        this.place = place;
        this.fromDate = fromDate;
        this.toDate = toDate;
        this.price = price;
        this.quota = quota;
        this.imageLink = imageLink;
        this.importDate = importDate;
    }

    public int getTourId() {
        return tourId;
    }

    public void setTourId(int tourId) {
        this.tourId = tourId;
    }

    public String getTourName() {
        return tourName;
    }

    public void setTourName(String tourName) {
        this.tourName = tourName;
    }

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }

    public Date getFromDate() {
        return fromDate;
    }

    public void setFromDate(Date fromDate) {
        this.fromDate = fromDate;
    }

    public Date getToDate() {
        return toDate;
    }

    public void setToDate(Date toDate) {
        this.toDate = toDate;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuota() {
        return quota;
    }

    public void setQuota(int quota) {
        this.quota = quota;
    }

    public String getImageLink() {
        return imageLink;
    }

    public void setImageLink(String imageLink) {
        this.imageLink = imageLink;
    }

    public Date getImportDate() {
        return importDate;
    }

    public void setImportDate(Date importDate) {
        this.importDate = importDate;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }
}