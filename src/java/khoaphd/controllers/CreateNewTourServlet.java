package khoaphd.controllers;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import khoaphd.tour.TourDAO;
import khoaphd.tour.TourDTO;
import org.apache.log4j.Logger;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileItemFactory;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;

/**
 *
 * @author KhoaPHD
 */
@WebServlet(name = "CreateNewTourServlet", urlPatterns = {"/CreateNewTourServlet"})
public class CreateNewTourServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CreateNewTourServlet.class);
    private static final String ERROR_PAGE = "error";
    private static final String CREATE_NEW_TOUR_PAGE = "createNewTourPage";
    
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
            boolean isMultiPart = ServletFileUpload.isMultipartContent(request);
            if (isMultiPart) {
                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                List<FileItem> items = upload.parseRequest(new ServletRequestContext(request));
                
                String fileName = null;
                Iterator<FileItem> iter = items.iterator();
                Hashtable params = new Hashtable();
                while (iter.hasNext()) {        
                    
                    FileItem item = iter.next();
                    if (item.isFormField()) {
                        params.put(item.getFieldName(), item.getString());
                    } else {
                        String itemName = item.getName();
                        fileName = itemName.substring(itemName.lastIndexOf("\\") + 1);
                        String realPath = getServletContext().getRealPath("/") + "images\\" + fileName;
                        File savedFile = new File(realPath);
                        item.write(savedFile);
                    }
                }
                
                String tourName = (String) params.get("txtCreateTourName");
                String place = (String) params.get("txtCreatePlace");
                
                String dateFromString = (String) params.get("txtCreateDateFrom");
                Date dateFrom = Date.valueOf(dateFromString);
                
                String dateToString = (String) params.get("txtCreateDateTo");
                Date dateTo = Date.valueOf(dateToString);
                
                String priceString = (String) params.get("txtCreatePrice");
                double price = Double.parseDouble(priceString);
                
                String quotaString = (String) params.get("txtCreateQuota");
                int quota = Integer.parseInt(quotaString);
                
                Date dateImport = new Date(System.currentTimeMillis());
                
                String imageLink = "./images/" + fileName;
                
                TourDTO tourDTO = new TourDTO(tourName.trim(), place.trim(), dateFrom, dateTo, price, quota, imageLink, dateImport);
                TourDAO tourDAO = new TourDAO();
                boolean result = tourDAO.insertNewTour(tourDTO);
                
                String message;
                if (result) {
                    message = "Inserting tour was successful";
                } else {
                    message = "Inserting tour was failed";
                }
                url = CREATE_NEW_TOUR_PAGE + "?message=" + message;
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