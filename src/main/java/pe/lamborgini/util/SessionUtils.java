package pe.lamborgini.util;

import javax.faces.context.FacesContext;
import javax.servlet.http.HttpSession;

/**
 * Created on 09/07/2019.
 *
 * @author Cesardl
 */
public class SessionUtils {
    private static SessionUtils ourInstance = new SessionUtils();

    public static SessionUtils getInstance() {
        return ourInstance;
    }

    private SessionUtils() {
    }

    public HttpSession load() {
        return (HttpSession) FacesContext.getCurrentInstance().getExternalContext().getSession(false);
    }
}
