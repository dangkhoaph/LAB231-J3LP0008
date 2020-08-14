package khoaphd.controllers;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import khoaphd.users.UsersDAO;
import khoaphd.users.UsersDTO;
import khoaphd.utils.APIWrapper;
import org.apache.log4j.Logger;

/**
 *
 * @author KhoaPHD
 */
@WebServlet(name = "LoginFacebookServlet", urlPatterns = {"/LoginFacebookServlet"})
public class LoginFacebookServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(LoginFacebookServlet.class);
    private static final String LOGIN_PAGE = "login.jsp";
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
        
        String code = request.getParameter("code");
        String error = request.getParameter("error");
        String url = LOGIN_PAGE;
        
        try {
            if (error == null) {
                APIWrapper apiWrapper = new APIWrapper();
                
                String accessToken = apiWrapper.getAccessToken(code);
                apiWrapper.setAccessToken(accessToken);
                
                UsersDTO usersInfo = apiWrapper.getUserInfo();
                UsersDAO usersDAO = new UsersDAO();
                UsersDTO usersDTO = usersDAO.checkLogin(usersInfo.getFacebookId());
                
                if (usersDTO == null) {
                    String userId = usersInfo.getUserId();
                    String fullName = usersInfo.getFullName();
                    String facebookId = usersInfo.getFacebookId();
                    String facebookLink = usersInfo.getFacebookLink();
                    usersDTO = usersDAO.register(userId, fullName, facebookId, facebookLink);
                }
                HttpSession session = request.getSession();
                session.setAttribute("USER", usersDTO);
                url = HOME_PAGE;
            } else {
                request.setAttribute("FACEBOOK_LOGIN_ERROR", "Error occurred while loging in with Facebook");
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