package pe.lamborgini.service;

import org.junit.Test;
import pe.lamborgini.domain.mapping.Helado;

import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;

/**
 * Created on 24/06/2018.
 *
 * @author Cesardl
 */
public class HeladoServiceTest {

    @Test
    public void obtenerHeladoPorNombreWithFilterTest() {
        List<Helado> result = HeladoService.obtenerHeladoPorNombre("a");

        assertFalse(result.isEmpty());
        assertEquals(26, result.size());
    }

    @Test
    public void obtenerHeladoPorNombreWithoutFilterTest() {
        List<Helado> result = HeladoService.obtenerHeladoPorNombre("");

        assertFalse(result.isEmpty());
        assertEquals(27, result.size());
    }
}