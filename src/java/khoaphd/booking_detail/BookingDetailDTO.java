package khoaphd.booking_detail;

import java.io.Serializable;

/**
 *
 * @author KhoaPHD
 */
public class BookingDetailDTO implements Serializable {
    
    private int bookingId;
    private int tourId;
    private int amount;

    public BookingDetailDTO() {
    }

    public BookingDetailDTO(int bookingId, int tourId, int amount) {
        this.bookingId = bookingId;
        this.tourId = tourId;
        this.amount = amount;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getTourId() {
        return tourId;
    }

    public void setTourId(int tourId) {
        this.tourId = tourId;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }
}