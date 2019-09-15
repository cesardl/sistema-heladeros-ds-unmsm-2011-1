package pe.lamborgini.controller;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.powermock.modules.junit4.PowerMockRunner;
import pe.lamborgini.DomainStubs;
import pe.lamborgini.domain.mapping.Helado;

import javax.faces.event.ActionEvent;
import java.util.List;

import static org.junit.Assert.*;

/**
 * Created on 21/07/2019.
 *
 * @author Cesardl
 */
@RunWith(PowerMockRunner.class)
public class ManagerIceCreamTest {

    private ManagerIceCream manager = new ManagerIceCream();
    @Mock
    private ActionEvent actionEvent;

    @Test
    public void getIceCreamsListTest() {
        List<Helado> iceCreamsList = manager.getIceCreamsList();

        assertEquals(27, iceCreamsList.size());

        iceCreamsList.stream()
                .filter(iceCream -> iceCream.getStockHelado() != null)
                .forEach(iceCream -> assertFalse(iceCream.getStockHelado().getCantidad() == 0));
    }

    @Test
    public void saveNewIceCreamTest() {
        List<Helado> iceCreamsList = manager.getIceCreamsList();

        assertEquals(27, iceCreamsList.size());

        manager.newIceCream(actionEvent);
        Helado iceCreamToPersist = manager.getEditedIceCream();

        // Simulation manual insertion of fields
        DomainStubs.mapIceCream(iceCreamToPersist);

        assertNull(iceCreamToPersist.getIdHelado());

        manager.setEditedIceCream(iceCreamToPersist);

        manager.saveOrUpdate(actionEvent);

        Helado result = manager.getEditedIceCream();

        assertNotNull(result.getIdHelado());
        assertNotNull(result.getNombreHelado());
        assertNotNull(result.getStockHelado());
        assertNotNull(result.getStockHelado().getCantidad());
        assertNotNull(result.getStockHelado().getFechaCaducidad());
        assertNotNull(result.getStockHelado().getCreatedAt());

        iceCreamsList = manager.getIceCreamsList();

        assertEquals(28, iceCreamsList.size());

        manager.delete(actionEvent);

        iceCreamsList = manager.getIceCreamsList();

        assertEquals(27, iceCreamsList.size());
    }

    @Test
    public void updateIceCreamTest() {
        List<Helado> iceCreamsList = manager.getIceCreamsList();

        assertEquals(27, iceCreamsList.size());

        manager.setEditedIceCream(iceCreamsList.get(0));
        Helado iceCreamToUpdate = manager.getEditedIceCream();

        // Simulation manual update of fields
        DomainStubs.mapIceCream(iceCreamToUpdate);

        assertNotNull(iceCreamToUpdate.getIdHelado());

        manager.setEditedIceCream(iceCreamToUpdate);

        manager.saveOrUpdate(actionEvent);

        Helado result = manager.getEditedIceCream();

        assertNotNull(result.getIdHelado());
        assertNotNull(result.getNombreHelado());
        assertNotNull(result.getStockHelado());
        assertNotNull(result.getStockHelado().getCantidad());
        assertNotNull(result.getStockHelado().getFechaCaducidad());
        assertNotNull(result.getStockHelado().getCreatedAt());

        iceCreamsList = manager.getIceCreamsList();

        assertEquals(27, iceCreamsList.size());
    }
}
