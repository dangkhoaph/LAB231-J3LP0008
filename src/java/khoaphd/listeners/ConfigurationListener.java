package khoaphd.listeners;

import java.io.File;
import java.util.ResourceBundle;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import org.apache.log4j.PropertyConfigurator;

/**
 * Web application lifecycle listener.
 *
 * @author KhoaPHD
 */
@WebListener()
public class ConfigurationListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        
        String configFile = context.getInitParameter("log4j-config-location");
        String fullPath = context.getRealPath("") + File.separator + configFile;
        PropertyConfigurator.configure(fullPath);
        
        String labelFile = context.getInitParameter("label-config-location");
        ResourceBundle labels = ResourceBundle.getBundle(labelFile);
        context.setAttribute("LABELS", labels);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}