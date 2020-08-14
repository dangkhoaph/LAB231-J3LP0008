package khoaphd.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import khoaphd.booking.BookingDAO;
import khoaphd.booking.BookingDTO;
import khoaphd.booking_detail.BookingDetailDAO;
import khoaphd.booking_detail.BookingDetailDTO;
import khoaphd.cart.CartObject;
import khoaphd.discount.DiscountDAO;
import khoaphd.discount.DiscountDTO;
import khoaphd.tour.TourDAO;
import khoaphd.tour.TourDTO;
import khoaphd.users.UsersDTO;
import org.apache.log4j.Logger;

/**
 *
 * @author KhoaPHD
 */
@WebServlet(name = "SubmitBookingServlet", urlPatterns = {"/SubmitBookingServlet"})
public class SubmitBookingServlet extends HttpServlet {
    
    private static final Logger LOGGER = Logger.getLogger(SubmitBookingServlet.class);
    private static final String ERROR_PAGE = "error.html";
    private static final String VIEW_CART_PAGE = "viewCart.jsp";
    private static final String HOME_PAGE = "LoadFirstTimeServlet";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String url = ERROR_PAGE;
        
        try {
            HttpSession session = request.getSession(false);
            if (session != null) {
                UsersDTO usersDTO = (UsersDTO) session.getAttribute("USER");
                if (usersDTO != null) {
                    String role = usersDTO.getRoleName();
                    if (role.equals("User")) {
                        CartObject cart = (CartObject) session.getAttribute("CART");
                        if (cart != null) {
                            List<TourDTO> tourList = cart.getTourList();
                            if (tourList != null && !tourList.isEmpty()) {
                                
                                //Validate discount
                                boolean isDiscountValid = false;
                                String userId = usersDTO.getUserId();
                                DiscountDTO discountDTO = (DiscountDTO) session.getAttribute("DISCOUNT");
                                if (discountDTO != null) {
                                    DiscountDAO discountDAO = new DiscountDAO();
                                    boolean isUsed = discountDAO.isDiscountCodeUsed(userId, discountDTO.getDiscountId());
                                    if (!isUsed) {
                                        DiscountDTO checkDiscountDTO = discountDAO.findDiscountCode(discountDTO.getDiscountId());
                                        if (checkDiscountDTO != null) {
                                            isDiscountValid = true;
                                        }
                                    }
                                } else {
                                    isDiscountValid = true;
                                }
                                
                                //Validate booking cart
                                boolean isBookingValid = false;
                                List<Vector> invalidTourList = null;
                                
                                for (TourDTO tour : tourList) {
                                    BookingDetailDAO bookingDetailDAO = new BookingDetailDAO();
                                    int currentAmount = bookingDetailDAO.getCurrentTotalAmountOfTour(tour.getTourId());
                                    
                                    TourDAO tourDAO = new TourDAO();
                                    int quota = tourDAO.getQuotaById(tour.getTourId());
                                    
                                    int availableSlots = quota - currentAmount;
                                    if (availableSlots < 0) {
                                        availableSlots = 0;
                                    }
                                    if (tour.getAmount() > availableSlots) {
                                        if (invalidTourList == null) {
                                            invalidTourList = new ArrayList<>();
                                        }
                                        
                                        Vector v = new Vector();
                                        v.add(tour.getTourName());
                                        v.add(availableSlots);
                                        
                                        invalidTourList.add(v);
                                    }
                                }
                                
                                if (invalidTourList == null) {
                                    isBookingValid = true;
                                }
                                
                                //After validate
                                if (isDiscountValid && isBookingValid) {
                                    
                                    BookingDTO bookingDTO = null;
                                    if (discountDTO != null) {
                                        bookingDTO = new BookingDTO(userId, discountDTO.getDiscountId());
                                    } else {
                                        bookingDTO = new BookingDTO(userId);
                                    }
                                    
                                    BookingDAO bookingDAO = new BookingDAO();
                                    int bookingId = bookingDAO.insertNewBooking(bookingDTO);
                                    
                                    if (bookingId > 0) {
                                        for (TourDTO tourDTO : tourList) {
                                            BookingDetailDTO bookingDetailDTO = new BookingDetailDTO(bookingId, tourDTO.getTourId(), tourDTO.getAmount());
                                            
                                            BookingDetailDAO bookingDetailDAO = new BookingDetailDAO();
                                            bookingDetailDAO.insertNewBookingDetail(bookingDetailDTO);
                                        }
                                    }
                                    
                                    url = HOME_PAGE;
                                    session.removeAttribute("CART");
                                    session.removeAttribute("DISCOUNT");
                                } else {
                                    if (!isDiscountValid) {
                                        request.setAttribute("INVALID_DISCOUNT", "Error occurred while using discount code. Please check again.");
                                    }
                                    if (!isBookingValid) {
                                        request.setAttribute("INVALID_TOUR_LIST", invalidTourList);
                                    }
                                    url = VIEW_CART_PAGE;
                                }
                            }
                        }
                    }
                }
            }
        } catch (Exception ex) {
            LOGGER.fatal(ex.getMessage());
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}