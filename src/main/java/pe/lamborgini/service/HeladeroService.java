/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import pe.lamborgini.dao.HeladeroDAO;
import pe.lamborgini.domain.mapping.Heladero;
import pe.lamborgini.domain.mapping.RoleType;
import pe.lamborgini.domain.mapping.Usuario;
import pe.lamborgini.util.SessionUtils;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @author Cesardl
 */
public final class HeladeroService {

    private static final Logger LOG = LoggerFactory.getLogger(HeladeroService.class);

    private HeladeroService() {
    }

    public static List<Heladero> obtenerHeladeros(final String name, final String lastName, final int concessionaireId) {
        HttpSession session = SessionUtils.getInstance().load();
        Usuario user = (Usuario) session.getAttribute("usuario");
        int concessionaireIdToSearch;
        RoleType roleType = user.getRoleType();

        if (RoleType.MANAGER.equals(roleType)) {
            concessionaireIdToSearch = user.getConcesionario().getIdConcesionario();
        } else {
            concessionaireIdToSearch = concessionaireId;
        }

        LOG.debug("Nombre '{}', Apellido '{}', Concesionario: '{}' | role: {}", name, lastName, concessionaireId, roleType);

        HeladeroDAO dao = new HeladeroDAO();
        return dao.getListaHeladeros(name.trim(), lastName.trim(), concessionaireIdToSearch);
    }
}
