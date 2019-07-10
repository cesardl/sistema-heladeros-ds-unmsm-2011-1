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

/**
 * @author Cesardl
 */
public final class UsuarioService {

    private UsuarioService() {
    }

    public static boolean validarUsuario(String nombre_usuario, String contrasenha) {
        UsuarioDAO dao = new UsuarioDAO();
        Usuario usuario = dao.getUsuario(nombre_usuario, contrasenha);
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
}
