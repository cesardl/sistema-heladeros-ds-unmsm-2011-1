package pe.lamborgini.util;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.faces.context.FacesContext;
import javax.faces.el.ValueBinding;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Hibernate Utility class with a convenient method to get Session Factory object.
 *
 * @author Cesardl
 */
public class AppUtil {

    public static final int ERROR = -1;
    private static final Logger LOG = LoggerFactory.getLogger(AppUtil.class);
    private static final SessionFactory sessionFactory;

    static {
        try {
            // Create the SessionFactory from standard (hibernate.cfg.xml) 
            // config file.
            sessionFactory = new Configuration().configure().buildSessionFactory();
        } catch (Throwable ex) {
            // Log the exception. 
            LOG.error("Initial SessionFactory creation failed.", ex);
            throw new ExceptionInInitializerError(ex);
        }
    }

    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public static int aInteger(String s) {
        try {
            return Integer.parseInt(s.trim());
        } catch (NumberFormatException nfe) {
            LOG.error("AppUtil.aInteger", nfe);
            return ERROR;
        }
    }

    public static Object callManageBean(String name) {
        FacesContext ctx = FacesContext.getCurrentInstance();
        ValueBinding vb = ctx.getApplication().createValueBinding("#{" + name + "}");
        return vb.getValue(ctx);
    }

    public static String dateWithFormat(Date date) {
        return new SimpleDateFormat("dd-MM-yyyy").format(date);
    }

    public static int random() {
        return (int) (Math.random() * 100000);
    }

    public static Date calcularFechaAnterior() {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.DAY_OF_MONTH, calendar.get(Calendar.DAY_OF_MONTH) - 1);
        return calendar.getTime();
    }
}
