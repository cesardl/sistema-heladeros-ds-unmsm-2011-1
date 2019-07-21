package pe.lamborgini.controller;

import org.junit.Test;
import pe.lamborgini.domain.mapping.Helado;

import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;

/**
 * Created on 21/07/2019.
 *
 * @author Cesardl
 */
public class ManagerIceCreamTest {

    private ManagerIceCream manager = new ManagerIceCream();

    @Test
    public void getIceCreamsListTest() {
        List<Helado> iceCreamsList = manager.getIceCreamsList();

        assertEquals(27, iceCreamsList.size());

        iceCreamsList.stream()
                .filter(iceCream -> iceCream.getStockHelado() != null)
                .forEach(iceCream -> assertFalse(iceCream.getStockHelado().getCantidad() == 0));
    }

}