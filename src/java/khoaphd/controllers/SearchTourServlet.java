package khoaphd.controllers;

import java.io.IOException;
import java.sql.Date;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import khoaphd.tour.TourDAO;
import khoaphd.tour.TourDTO;
import org.apache.log4j.Logger;

/**
 *
 * @author KhoaPHD
 */
@WebServlet(name = "SearchTourServlet", urlPatterns = {"/SearchTourServlet"})
public class SearchTourServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(SearchTourServlet.class);
    private static final String SEARCH_PAGE = "search.jsp";
    
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
        
        String url = SEARCH_PAGE;
        String searchPlace = request.getParameter("txtSearchPlace");
        String searchDateFromString = request.getParameter("txtSearchDateFrom");
        String searchDateToString = request.getParameter("txtSearchDateTo");
        String searchPriceFromString = request.getParameter("txtSearchPriceFrom");
        String searchPriceToString = request.getParameter("txtSearchPriceTo");
        String searchPageNo = request.getParameter("searchPageNo");
        
        try {
            searchPlace = searchPlace.trim();
            
            Date searchDateFrom = null;
            if (!searchDateFromString.trim().isEmpty()) {
                searchDateFrom = Date.valueOf(searchDateFromString.trim());
            }
            Date searchDateTo = null;
            if (!searchDateToString.trim().isEmpty()) {
                searchDateTo = Date.valueOf(searchDateToString.trim());
            }
            
            Double searchPriceFrom = null;
            if (!searchPriceFromString.trim().isEmpty()) {
                searchPriceFrom = Double.parseDouble(searchPriceFromString.trim());
            }
            Double searchPriceTo = null;
            if (!searchPriceToString.trim().isEmpty()) {
                searchPriceTo = Double.parseDouble(searchPriceToString.trim());
            }
            
            int pageNo = 1;
            if (searchPageNo != null) {
                pageNo = Integer.parseInt(searchPageNo);
            }
            
            TourDAO tourDAO = new TourDAO();
            List<TourDTO> tourList = tourDAO.searchTours(searchPlace, searchDateFrom, searchDateTo, searchPriceFrom, searchPriceTo, pageNo);
            if (!tourList.isEmpty()) {
                request.setAttribute("SEARCH_TOUR_LIST", tourList);
                
                int tourCount = tourDAO.getSearchToursCount(searchPlace, searchDateFrom, searchDateTo, searchPriceFrom, searchPriceTo);
                int totalPages = (int) Math.ceil((double) tourCount / TourDAO.ROWS_PER_PAGE);
                request.setAttribute("TOTAL_PAGES", totalPages);
                request.setAttribute("ROWS_PER_PAGE", TourDAO.ROWS_PER_PAGE);
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