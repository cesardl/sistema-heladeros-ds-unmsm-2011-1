/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import javax.faces.context.FacesContext;
import javax.servlet.http.HttpSession;
import pe.lamborgini.dao.HeladeroDAO;
import pe.lamborgini.domain.mapping.Heladero;
import pe.lamborgini.domain.mapping.Usuario;

/**
 *
 * @author Cesardl
 */
public class HeladeroService {

    public static Collection<Heladero> obtenerHeladeros(String nombre, String apellido) {
        HttpSession session = (HttpSession) FacesContext.getCurrentInstance().
                getExternalContext().getSession(false);
        int id_concesionario = ((Usuario) session.getAttribute("usuario")).getConcesionario().
                getIdConcesionario();
        System.out.println(id_concesionario);
        HeladeroDAO dao = new HeladeroDAO();
        List<Heladero> c = dao.getListaHeladeros(nombre, apellido, id_concesionario);
        if (c == null) {
            return new ArrayList<Heladero>(0);
        } else {
            return c;
        }
    }
}
