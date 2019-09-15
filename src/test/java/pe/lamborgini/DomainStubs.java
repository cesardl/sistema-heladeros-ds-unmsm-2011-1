package pe.lamborgini;

import pe.lamborgini.domain.mapping.Concesionario;
import pe.lamborgini.domain.mapping.Helado;
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

    public static Usuario user(int concessionaireId) {
        Usuario usuario = new Usuario();
        usuario.setConcesionario(new Concesionario());
        usuario.getConcesionario().setIdConcesionario(concessionaireId);
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
