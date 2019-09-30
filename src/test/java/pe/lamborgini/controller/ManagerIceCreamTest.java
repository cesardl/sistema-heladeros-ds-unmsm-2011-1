package pe.lamborgini.controller;

import org.junit.After;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.powermock.modules.junit4.PowerMockRunner;
import pe.lamborgini.DomainStubs;
import pe.lamborgini.domain.mapping.Helado;
import pe.lamborgini.domain.mapping.StockHelado;

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

    @After
    public void setDown() {
        manager.setOncomplete(null);
        manager.setIceCreamsList(null);
    }

    @Test
    public void getIceCreamsListTest() {
        List<Helado> iceCreamsResult = manager.getIceCreamsList();

        assertEquals(27, iceCreamsResult.size());

        iceCreamsResult.stream()
                .filter(iceCream -> iceCream.getStockHelado() != null)
                .forEach(iceCream -> assertFalse(iceCream.getStockHelado().getCantidad() == 0));

        // reload
        List<Helado> resultReload = manager.getIceCreamsList();

        assertEquals(iceCreamsResult, resultReload);
        assertSame(iceCreamsResult, resultReload);
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
        assertTrue(manager.getOncomplete().contains("Richfaces"));

        iceCreamsList = manager.getIceCreamsList();

        assertEquals(28, iceCreamsList.size());

        manager.delete(actionEvent);

        iceCreamsList = manager.getIceCreamsList();

        assertEquals(27, iceCreamsList.size());
    }

    @Test
    public void saveNewIceCreamFailedTest() {
        List<Helado> iceCreamsList = manager.getIceCreamsList();

        assertEquals(27, iceCreamsList.size());

        manager.newIceCream(actionEvent);
        Helado iceCreamToPersist = manager.getEditedIceCream();

        // Simulation manual insertion of fields
        DomainStubs.mapIceCream(iceCreamToPersist);
        iceCreamToPersist.getStockHelado().setFechaCaducidad(null);

        assertNull(iceCreamToPersist.getIdHelado());

        manager.setEditedIceCream(iceCreamToPersist);

        manager.saveOrUpdate(actionEvent);

        assertFalse(manager.getOncomplete().contains("Richfaces"));
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
        assertTrue(manager.getOncomplete().contains("Richfaces"));

        iceCreamsList = manager.getIceCreamsList();

        assertEquals(27, iceCreamsList.size());
    }

    @Test
    public void updateIceCreamFailedTest() {
        List<Helado> iceCreamsList = manager.getIceCreamsList();

        assertEquals(27, iceCreamsList.size());

        manager.setEditedIceCream(iceCreamsList.get(0));
        Helado iceCreamToUpdate = manager.getEditedIceCream();

        // Simulation manual update of fields
        DomainStubs.mapIceCream(iceCreamToUpdate);
        iceCreamToUpdate.getStockHelado().setFechaCaducidad(null);

        assertNotNull(iceCreamToUpdate.getIdHelado());

        manager.setEditedIceCream(iceCreamToUpdate);

        manager.saveOrUpdate(actionEvent);

        assertFalse(manager.getOncomplete().contains("Richfaces"));
    }

    @Test
    public void deleteIceCreamFailedTest() {
        Helado iceCream = new Helado();
        iceCream.setIdHelado(100);
        iceCream.setStockHelado(new StockHelado());
        DomainStubs.mapIceCream(iceCream);

        manager.setEditedIceCream(iceCream);

        manager.delete(actionEvent);

        assertFalse(manager.getOncomplete().contains("Richfaces"));
    }
}
