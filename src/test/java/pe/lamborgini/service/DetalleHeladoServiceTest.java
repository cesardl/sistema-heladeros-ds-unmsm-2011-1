package pe.lamborgini.service;

import org.junit.Test;

import static org.junit.Assert.assertEquals;

/**
 * Created on 14/07/2019.
 *
 * @author Cesardl
 */
public class DetalleHeladoServiceTest {

    @Test
    public void getDetalleHeladoAnteriorNoAsignadoTest() {
        int result = DetalleHeladoService.calcularHeladosPendientes("1", 1);

        assertEquals(0, result);
    }
}