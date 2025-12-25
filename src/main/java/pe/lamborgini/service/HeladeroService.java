/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import pe.lamborgini.dao.ContratoHeladeroDAO;
import pe.lamborgini.dao.HeladeroDAO;
import pe.lamborgini.domain.dto.ContratoHeladeroDTO;
import pe.lamborgini.domain.mapping.ContratoHeladero;
import pe.lamborgini.domain.mapping.Heladero;
import pe.lamborgini.domain.mapping.RoleType;
import pe.lamborgini.domain.mapping.Usuario;
import pe.lamborgini.util.AppUtil;
import pe.lamborgini.util.SessionUtils;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @author Cesardl
 */
public final class HeladeroService {

    private static final Logger LOG = LoggerFactory.getLogger(HeladeroService.class);

    private static final HeladeroDAO dao = new HeladeroDAO();
    private static final ContratoHeladeroDAO contratoHeladeroDAO = new ContratoHeladeroDAO();

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

        return dao.getListaHeladeros(name.trim(), lastName.trim(), concessionaireIdToSearch);
    }

    public static ContratoHeladeroDTO loadcontract(final int paramIceCreamManId) {
        ContratoHeladero ch = contratoHeladeroDAO.findByIceCreamMan(paramIceCreamManId);
        boolean active=AppUtil.isCurrentDateBetween(ch.getFechaInicio(), ch.getFechaFin());

        ContratoHeladeroDTO dto = new ContratoHeladeroDTO();
        dto.setContract(ch);
        dto.setActive(active);
        return dto;
    }
}
