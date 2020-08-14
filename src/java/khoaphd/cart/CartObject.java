package khoaphd.cart;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import khoaphd.tour.TourDAO;
import khoaphd.tour.TourDTO;

/**
 *
 * @author KhoaPHD
 */
public class CartObject implements Serializable {
    
    private List<TourDTO> tourList;

    public CartObject() {
    }

    public List<TourDTO> getTourList() {
        return tourList;
    }
    
    public boolean addToCart(int tourId) throws Exception {
        if (tourList == null) {
            tourList = new ArrayList<>();
        }
        
        boolean result = false;
        TourDAO tourDAO = new TourDAO();
        TourDTO tourDTO = tourDAO.getTourById(tourId);
        if (tourDTO != null) {
            boolean isExisted = false;
            for (TourDTO tour : tourList) {
                if (tourId == tour.getTourId()) {
                    isExisted = true;
                    tour.setAmount(tour.getAmount() + 1);
                    result = true;
                    break;
                }
            }

            if (!isExisted) {
                tourDTO.setAmount(1);
                tourList.add(tourDTO);
                result = true;
            }
        }

        return result;
    }
    
    public boolean updateQuantity(int tourId, int amount) throws Exception {
        boolean result = false;
        if (tourList != null) {
            for (TourDTO tour : tourList) {
                if (tourId == tour.getTourId()) {
                    tour.setAmount(amount);
                    result = true;
                    break;
                }
            }
        }
        return result;
    }
    
    public boolean removeFromCart(int tourId) throws Exception {
        boolean result = false;
        if (tourList != null) {
            for (TourDTO tour : tourList) {
                if (tourId == tour.getTourId()) {
                    tourList.remove(tour);
                    if (tourList.isEmpty()) {
                        tourList = null;
                    }
                    result = true;
                    break;
                }
            }
        }
        return result;
    }
}