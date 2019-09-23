package pe.lamborgini.service;

import org.junit.Test;
import pe.lamborgini.domain.mapping.Concesionario;

import java.util.Collection;

import static org.junit.Assert.assertEquals;

/**
 * Created on 14/07/2019.
 *
 * @author Cesardl
 */
public class ConcesionarioServiceTest {

    @Test
    public void getConcesionariosTest() {
        Collection<Concesionario> result = ConcesionarioService.obtenerConcesionario();

        assertEquals(5, result.size());
    }
}
