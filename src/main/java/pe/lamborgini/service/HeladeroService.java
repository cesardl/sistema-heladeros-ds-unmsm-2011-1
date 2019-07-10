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
import pe.lamborgini.util.SessionUtils;

import javax.servlet.http.HttpSession;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

/**
 * @author Cesardl
 */
public final class HeladeroService {

    private static final Logger LOG = LoggerFactory.getLogger(HeladeroService.class);

    private HeladeroService() {
    }

    public static Collection<Heladero> obtenerHeladeros(final String nombre, final String apellido) {
        HttpSession session = SessionUtils.getInstance().load();
        int id_concesionario = ((Usuario) session.getAttribute("usuario")).getConcesionario().getIdConcesionario();

        LOG.debug("Nombre '{}', Apellido '{}', Concesionario: '{}'", nombre, apellido, id_concesionario);

        HeladeroDAO dao = new HeladeroDAO();
        List<Heladero> c = dao.getListaHeladeros(nombre.trim(), apellido.trim(), id_concesionario);
        if (c == null) {
            return Collections.emptyList();
        } else {
            return c;
        }
    }
}
