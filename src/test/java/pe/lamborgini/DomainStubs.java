package pe.lamborgini;

import pe.lamborgini.domain.mapping.Concesionario;
import pe.lamborgini.domain.mapping.Usuario;

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
}
