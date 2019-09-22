package pe.lamborgini.dao;

import org.junit.Test;
import pe.lamborgini.domain.mapping.RoleType;
import pe.lamborgini.domain.mapping.Usuario;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

/**
 * Created on 14/07/2019.
 *
 * @author Cesardl
 */
public class UsuarioDAOTest {

    private UsuarioDAO dao = new UsuarioDAO();

    @Test
    public void getUsuarioTest() {
        String userName = "admin";
        String password = "4dm1n";
        Usuario result = dao.getUsuario(userName, password);

        assertNotNull(result.getIdUsuario());
        assertNotNull(result.getConcesionario().getIdConcesionario());
        assertNotNull(result.getNombreUsuario());
        assertNotNull(result.getContrasenha());
        assertNotNull(result.getCargo());
        assertNotNull(result.getRoleType());

        assertEquals(userName, result.getNombreUsuario());
        assertEquals(password, result.getContrasenha());
        assertEquals(RoleType.ADMIN, result.getRoleType());
    }

}
