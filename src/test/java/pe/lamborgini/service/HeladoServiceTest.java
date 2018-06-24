package pe.lamborgini.service;

import org.junit.Test;
import pe.lamborgini.domain.mapping.Helado;

import java.util.List;

import static org.junit.Assert.*;

/**
 * Created on 24/06/2018.
 *
 * @author Cesardl
 */
public class HeladoServiceTest {

    @Test
    public void obtenerHeladoPorNombreTest() {
        List<Helado> helados = HeladoService.obtenerHeladoPorNombre("a");
        assertFalse(helados.isEmpty());
    }
}