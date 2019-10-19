package pe.lamborgini.controller.modal;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;
import pe.lamborgini.DomainStubs;
import pe.lamborgini.domain.mapping.DetalleHelado;
import pe.lamborgini.domain.mapping.Helado;

import javax.faces.component.UIComponent;
import javax.faces.component.UIParameter;
import javax.faces.event.ActionEvent;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import static org.junit.Assert.*;
import static org.mockito.Matchers.anyString;
import static org.mockito.Mockito.when;

/**
 * Created on 14/07/2019.
 *
 * @author Cesardl
 */
@RunWith(MockitoJUnitRunner.class)
public class ManagerAsignacionTest {

    private static final String ICE_CREAM_STUB_NAME = "STUB";

    private ManagerAsignacion manager = new ManagerAsignacion();

    @Mock
    private ActionEvent actionEvent;
    @Mock
    private UIComponent uiComponent;
    @Mock
    private UIParameter uiParameter;

    @Before
    public void setUp() {
        when(actionEvent.getComponent()).thenReturn(uiComponent);
        when(uiComponent.findComponent(anyString())).thenReturn(uiParameter);
    }

    @After
    public void setDown() {
        manager.setOncomplete(null);
        manager.setIceCreamDetailsList(null);
        manager.setParamIceCreamManNames(null);
        manager.setParamConcessionaireName(null);
    }

    @Test
    public void autocompleteWithResultTest() {
        List<Helado> result = manager.autocomplete("fru");

        assertEquals(3, result.size());
    }

    @Test
    public void autocompleteWithoutResultTest() {
        List<Helado> result = manager.autocomplete(null);

        assertTrue(result.isEmpty());
    }

    @Test
    public void openModalForIceCreamsAssignationTest() {
        when(uiParameter.getValue()).thenReturn("20");

        manager.asignarHelado(actionEvent);

        assertNotNull(manager.getParamConcessionaireName());
        assertNotNull(manager.getParamIceCreamManNames());
        assertNotNull(manager.getParamIceCreamManId());
        assertEquals("20", manager.getParamIceCreamManId());
        assertEquals(0, manager.getSuggestedIceCreamId());
        assertEquals(0, manager.getQuantity());
        assertNull(manager.getSuggestedIceCream());

        assertTrue(manager.getIceCreamDetailsList().isEmpty());
        assertTrue(manager.getOncomplete().startsWith("Richfaces."));
    }

    @Test
    public void openModalForIceCreamsAssignationOnSellerWithDailyAssignationTest() {
        String paramIceCreamManId = "37";
        when(uiParameter.getValue()).thenReturn(paramIceCreamManId);

        manager.asignarHelado(actionEvent);

        assertNotNull(manager.getParamConcessionaireName());
        assertNotNull(manager.getParamIceCreamManNames());
        assertNotNull(manager.getParamIceCreamManId());
        assertEquals(paramIceCreamManId, manager.getParamIceCreamManId());
        assertEquals(0, manager.getSuggestedIceCreamId());
        assertEquals(0, manager.getQuantity());
        assertNull(manager.getSuggestedIceCream());

        assertNull(manager.getIceCreamDetailsList());
        assertTrue(manager.getOncomplete().startsWith("javascript:"));
    }

    @Test
    public void addingIceCreamsToSellWithAssignEmptyQuantityTest() {
        manager.setIceCreamDetailsList(new ArrayList<>());
        manager.setParamIceCreamManId("21");
        manager.setSuggestedIceCreamId(1);
        manager.setQuantity(0);

        manager.addIceCream(actionEvent);

        assertTrue(manager.getIceCreamDetailsList().isEmpty());
        assertTrue(manager.getOncomplete().startsWith("javascript:"));
    }

    @Test
    public void addingIceCreamsToSellWithAssignEmptySuggestedIceCreamTest() {
        manager.setIceCreamDetailsList(new ArrayList<>());
        manager.setParamIceCreamManId("22");
        manager.setSuggestedIceCreamId(0);
        manager.setQuantity(1000);

        manager.addIceCream(actionEvent);

        assertTrue(manager.getIceCreamDetailsList().isEmpty());
        assertTrue(manager.getOncomplete().startsWith("javascript:"));
    }

    @Test
    public void addingAndRemovingIceCreamWhenCurrentListIsEmpty() {
        manager.setIceCreamDetailsList(new ArrayList<>());
        manager.setParamIceCreamManId("23");

        // new ice cream with id 1
        manager.setSuggestedIceCreamId(1);
        manager.setSuggestedIceCream(ICE_CREAM_STUB_NAME);
        manager.setQuantity(10);

        manager.addIceCream(actionEvent);

        assertFalse(manager.getIceCreamDetailsList().isEmpty());
        assertEquals(1, manager.getIceCreamDetailsList().size());
        assertNotNull(manager.getIceCreamDetailsList().get(0).getHelado().getIdHelado());
        assertNotNull(manager.getIceCreamDetailsList().get(0).getHelado().getNombreHelado());
        assertEquals(10, manager.getIceCreamDetailsList().get(0).getCantEntregada());
        assertEquals(0, manager.getIceCreamDetailsList().get(0).getCantDevuelta());
        assertEquals(0, manager.getIceCreamDetailsList().get(0).getCantVendida());

        // new ice cream with id 2
        manager.setSuggestedIceCreamId(2);
        manager.setSuggestedIceCream(ICE_CREAM_STUB_NAME);
        manager.setQuantity(20);

        manager.addIceCream(actionEvent);

        assertFalse(manager.getIceCreamDetailsList().isEmpty());
        assertEquals(2, manager.getIceCreamDetailsList().size());
        assertNotNull(manager.getIceCreamDetailsList().get(0).getHelado().getIdHelado());
        assertNotNull(manager.getIceCreamDetailsList().get(1).getHelado().getIdHelado());
        assertNotNull(manager.getIceCreamDetailsList().get(0).getHelado().getNombreHelado());
        assertNotNull(manager.getIceCreamDetailsList().get(1).getHelado().getNombreHelado());
        assertEquals(10, manager.getIceCreamDetailsList().get(0).getCantEntregada());
        assertEquals(20, manager.getIceCreamDetailsList().get(1).getCantEntregada());
        assertEquals(0, manager.getIceCreamDetailsList().get(1).getCantDevuelta());
        assertEquals(0, manager.getIceCreamDetailsList().get(1).getCantVendida());

        // new ice cream with id 3
        manager.setSuggestedIceCreamId(3);
        manager.setSuggestedIceCream(ICE_CREAM_STUB_NAME);
        manager.setQuantity(15);

        manager.addIceCream(actionEvent);

        assertFalse(manager.getIceCreamDetailsList().isEmpty());
        assertEquals(3, manager.getIceCreamDetailsList().size());
        assertNotNull(manager.getIceCreamDetailsList().get(0).getHelado().getIdHelado());
        assertNotNull(manager.getIceCreamDetailsList().get(1).getHelado().getIdHelado());
        assertNotNull(manager.getIceCreamDetailsList().get(2).getHelado().getIdHelado());
        assertNotNull(manager.getIceCreamDetailsList().get(0).getHelado().getNombreHelado());
        assertNotNull(manager.getIceCreamDetailsList().get(1).getHelado().getNombreHelado());
        assertNotNull(manager.getIceCreamDetailsList().get(2).getHelado().getNombreHelado());
        assertEquals(10, manager.getIceCreamDetailsList().get(0).getCantEntregada());
        assertEquals(20, manager.getIceCreamDetailsList().get(1).getCantEntregada());
        assertEquals(15, manager.getIceCreamDetailsList().get(2).getCantEntregada());
        assertEquals(0, manager.getIceCreamDetailsList().get(2).getCantDevuelta());
        assertEquals(0, manager.getIceCreamDetailsList().get(2).getCantVendida());

        //adding more ice creams to the same id 2
        manager.setSuggestedIceCreamId(2);
        manager.setSuggestedIceCream(ICE_CREAM_STUB_NAME);
        manager.setQuantity(5);

        manager.addIceCream(actionEvent);

        assertFalse(manager.getIceCreamDetailsList().isEmpty());
        assertEquals(3, manager.getIceCreamDetailsList().size());
        assertNotNull(manager.getIceCreamDetailsList().get(0).getHelado().getIdHelado());
        assertNotNull(manager.getIceCreamDetailsList().get(1).getHelado().getIdHelado());
        assertNotNull(manager.getIceCreamDetailsList().get(2).getHelado().getIdHelado());
        assertNotNull(manager.getIceCreamDetailsList().get(0).getHelado().getNombreHelado());
        assertNotNull(manager.getIceCreamDetailsList().get(1).getHelado().getNombreHelado());
        assertNotNull(manager.getIceCreamDetailsList().get(2).getHelado().getNombreHelado());
        assertEquals(10, manager.getIceCreamDetailsList().get(0).getCantEntregada());
        assertEquals(25, manager.getIceCreamDetailsList().get(1).getCantEntregada());
        assertEquals(0, manager.getIceCreamDetailsList().get(1).getCantDevuelta());
        assertEquals(0, manager.getIceCreamDetailsList().get(1).getCantVendida());
        assertEquals(15, manager.getIceCreamDetailsList().get(2).getCantEntregada());

        // removing by index position 1
        when(uiParameter.getValue()).thenReturn("1");

        manager.removeIceCream(actionEvent);

        assertFalse(manager.getIceCreamDetailsList().isEmpty());
        assertEquals(2, manager.getIceCreamDetailsList().size());
        assertNotNull(manager.getIceCreamDetailsList().get(0).getHelado().getIdHelado());
        assertNotNull(manager.getIceCreamDetailsList().get(1).getHelado().getIdHelado());
        assertNotNull(manager.getIceCreamDetailsList().get(0).getHelado().getNombreHelado());
        assertNotNull(manager.getIceCreamDetailsList().get(1).getHelado().getNombreHelado());
        assertEquals(25, manager.getIceCreamDetailsList().get(0).getCantEntregada());
        assertEquals(15, manager.getIceCreamDetailsList().get(1).getCantEntregada());
    }

    @Test
    public void saveAssignationsTest() {
        List<DetalleHelado> iceCreamDetails = new ArrayList<>();
        iceCreamDetails.add(DomainStubs.iceCreamDetail(1, 500));
        iceCreamDetails.add(DomainStubs.iceCreamDetail(2, 500));
        iceCreamDetails.add(DomainStubs.iceCreamDetail(3, 500));
        iceCreamDetails.add(DomainStubs.iceCreamDetail(4, 500));

        manager.setIceCreamDetailsList(iceCreamDetails);

        manager.setParamIceCreamManId("24");

        manager.saveAssignations(actionEvent);

        assertTrue(manager.getOncomplete().contains("javascript:alert"));
        assertTrue(manager.getOncomplete().contains("Richfaces.hideModalPanel"));
    }

    @Test
    public void tryingToSaveAssignationWithoutIceCreamsTest() {
        manager.setIceCreamDetailsList(Collections.emptyList());

        manager.setParamIceCreamManId("25");

        manager.saveAssignations(actionEvent);

        assertTrue(manager.getOncomplete().contains("javascript:alert('Debe de ingresar algun helado.')"));
        assertFalse(manager.getOncomplete().contains("Richfaces.hideModalPanel"));
    }

    @Test
    public void tryingToSaveAssignationsWithoutStockTest() {
        List<DetalleHelado> iceCreamDetails = new ArrayList<>();
        iceCreamDetails.add(DomainStubs.iceCreamDetail(5, 21584));
        iceCreamDetails.add(DomainStubs.iceCreamDetail(6, 38416 + 1));
        iceCreamDetails.add(DomainStubs.iceCreamDetail(7, 318421));

        manager.setIceCreamDetailsList(iceCreamDetails);

        manager.setParamIceCreamManId("26");

        manager.saveAssignations(actionEvent);

        assertTrue(manager.getOncomplete().contains("mp_ice_cream_without_stock"));
    }
}
