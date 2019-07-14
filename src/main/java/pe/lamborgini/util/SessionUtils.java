package pe.lamborgini.util;

import javax.faces.context.FacesContext;
import javax.servlet.http.HttpSession;

/**
 * Created on 09/07/2019.
 *
 * @author Cesardl
 */
public final class SessionUtils {
    private static SessionUtils ourInstance = new SessionUtils();

    private SessionUtils() {
    }

    public static SessionUtils getInstance() {
        return ourInstance;
    }

    public HttpSession load() {
        return (HttpSession) FacesContext.getCurrentInstance().getExternalContext().getSession(false);
    }
}
