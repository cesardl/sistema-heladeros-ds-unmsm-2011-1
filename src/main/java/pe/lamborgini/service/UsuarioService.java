/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.service;

import pe.lamborgini.dao.UsuarioDAO;
import pe.lamborgini.domain.mapping.Usuario;
import pe.lamborgini.util.SessionUtils;

import javax.faces.context.FacesContext;
import javax.servlet.http.HttpSession;
import java.util.Enumeration;
import java.util.List;

/**
 * @author Cesardl
 */
public final class UsuarioService {

    private static UsuarioDAO dao = new UsuarioDAO();

    private UsuarioService() {
    }

    public static boolean validarUsuario(String userName, String password) {
        Usuario usuario = dao.getUsuario(userName, password);
        if (usuario != null) {
            HttpSession session = SessionUtils.getInstance().load();
            session.setAttribute("usuario", usuario);
            return true;
        } else {
            return false;
        }
    }

    public static void cerrarSesion() {
        HttpSession session = (HttpSession) FacesContext.getCurrentInstance().getExternalContext().getSession(true);
        Enumeration atributos = session.getAttributeNames();
        while (atributos.hasMoreElements()) {
            session.removeAttribute((String) atributos.nextElement());
        }
        session.invalidate();
    }

    public static List<Usuario> listUsersByConcessionaires(final int concessionaireId) {
        HttpSession session = SessionUtils.getInstance().load();
        Usuario user = (Usuario) session.getAttribute("usuario");

        return dao.findByConcessionaire(user.getIdUsuario(), concessionaireId);
    }
}
