package khoaphd.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import khoaphd.cart.CartObject;
import khoaphd.users.UsersDTO;
import org.apache.log4j.Logger;

/**
 *
 * @author KhoaPHD
 */
@WebServlet(name = "RemoveTourFromCartServlet", urlPatterns = {"/RemoveTourFromCartServlet"})
public class RemoveTourFromCartServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(RemoveTourFromCartServlet.class);
    private static final String ERROR_PAGE = "error";
    private static final String VIEW_CART_PAGE = "viewCartPage";
    
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
                            String tourIdString = request.getParameter("tourIdToRemove");
                            int tourId = Integer.parseInt(tourIdString);
                            
                            boolean result = cart.removeFromCart(tourId);
                            if (result) {
                                session.setAttribute("CART", cart);
                                url = VIEW_CART_PAGE;
                            }
                        }
                    }
                }
            }
        } catch (Exception ex) {
            LOGGER.fatal(ex.getMessage());
        } finally {
            response.sendRedirect(url);
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