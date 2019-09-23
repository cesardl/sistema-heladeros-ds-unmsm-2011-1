package pe.lamborgini;

import pe.lamborgini.domain.mapping.Concesionario;
import pe.lamborgini.domain.mapping.Helado;
import pe.lamborgini.domain.mapping.RoleType;
import pe.lamborgini.domain.mapping.Usuario;

import java.time.LocalDate;
import java.time.ZoneOffset;
import java.util.Date;

/**
 * Created on 13/07/2019.
 *
 * @author Cesardl
 */
public final class DomainStubs {

    private DomainStubs() {
    }

    public static Usuario userAdmin() {
        Usuario usuario = new Usuario();
        usuario.setIdUsuario(1);
        usuario.setConcesionario(new Concesionario());
        usuario.getConcesionario().setIdConcesionario(1);
        usuario.setRoleType(RoleType.ADMIN);
        return usuario;
    }

    public static Usuario userManager(final int userId, final int concessionaireId) {
        Usuario usuario = new Usuario();
        usuario.setIdUsuario(userId);
        usuario.setConcesionario(new Concesionario());
        usuario.getConcesionario().setIdConcesionario(concessionaireId);
        usuario.setRoleType(RoleType.MANAGER);
        return usuario;
    }

    public static void mapIceCream(final Helado helado) {
        helado.setNombreHelado("Bombones buenos");
        helado.setPrecio(20012.21);

        helado.getStockHelado().setCantidad(1000);
        helado.getStockHelado().setFechaCaducidad(
                Date.from(LocalDate.now().plusMonths(3).atStartOfDay().toInstant(ZoneOffset.UTC)));
    }
}
