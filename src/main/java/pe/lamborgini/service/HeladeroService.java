/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import pe.lamborgini.dao.HeladeroDAO;
import pe.lamborgini.domain.mapping.Heladero;
import pe.lamborgini.domain.mapping.Usuario;

import javax.faces.context.FacesContext;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * @author Cesardl
 */
public class HeladeroService {

    private static final Logger LOG = LoggerFactory.getLogger(HeladeroService.class);

    public static Collection<Heladero> obtenerHeladeros(String nombre, String apellido) {
        HttpSession session = (HttpSession) FacesContext.getCurrentInstance().
                getExternalContext().getSession(false);
        int id_concesionario = ((Usuario) session.getAttribute("usuario")).getConcesionario().
                getIdConcesionario();
        LOG.debug("Concesionario: {}", id_concesionario);
        HeladeroDAO dao = new HeladeroDAO();
        List<Heladero> c = dao.getListaHeladeros(nombre, apellido, id_concesionario);
        if (c == null) {
            return new ArrayList<>(0);
        } else {
            return c;
        }
    }
}
