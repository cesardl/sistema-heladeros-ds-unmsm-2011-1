package pe.lamborgini.util;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * Created on 30/09/2019.
 *
 * @author Cesardl
 * @see <a href='https://developer.jboss.org/wiki/UsingHibernateWithTomcat'>Using Hibernate with Tomcat</a>
 */
public class HibernateListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        AppUtil.getSessionFactory(); // Just call the static initializer of that class
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        AppUtil.getSessionFactory().close(); // Free all resources
    }
}
