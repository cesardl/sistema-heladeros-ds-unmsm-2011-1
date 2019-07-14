package pe.lamborgini.controller.modal;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;
import pe.lamborgini.domain.mapping.Helado;

import javax.faces.component.UIComponent;
import javax.faces.component.UIParameter;
import javax.faces.event.ActionEvent;
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

    private static final String ICE_CREAM_MAN_ID = "20";
    private static final String ICE_CREAM_STUB_NAME = "STUB";

    private ManagerAsignacion manager;

    @Mock
    private ActionEvent actionEvent;
    @Mock
    private UIComponent uiComponent;
    @Mock
    private UIParameter uiParameter;

    @Before
    public void setUp() {
        manager = new ManagerAsignacion();

        when(actionEvent.getComponent()).thenReturn(uiComponent);
        when(uiComponent.findComponent(anyString())).thenReturn(uiParameter);
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
        when(uiParameter.getValue()).thenReturn(ICE_CREAM_MAN_ID);

        manager.asignarHelado(actionEvent);

        assertNotNull(manager.getNombre_consecionario());
        assertNotNull(manager.getNombres_heladero());
        assertNotNull(manager.getP_id_heladero());
        assertEquals(ICE_CREAM_MAN_ID, manager.getP_id_heladero());
        assertEquals(0, manager.getSug_id_helado());
        assertEquals(0, manager.getCantidad());
        assertNull(manager.getSug_helado());

        assertTrue(manager.getListaDetalleHelados().isEmpty());
        assertTrue(manager.getOncomplete().startsWith("Richfaces."));
    }

    @Test
    public void addingIceCreamsToSellWithAssignEmptyQuantityTest() {
        manager.setP_id_heladero(ICE_CREAM_MAN_ID);
        manager.setSug_id_helado(1);
        manager.setCantidad(0);

        manager.addHelado(actionEvent);

        assertTrue(manager.getListaDetalleHelados().isEmpty());
        assertTrue(manager.getOncomplete().startsWith("javascript:"));
    }

    @Test
    public void addingIceCreamsToSellWithAssignEmptySuggestedIceCreamTest() {
        manager.setP_id_heladero(ICE_CREAM_MAN_ID);
        manager.setSug_id_helado(0);
        manager.setCantidad(1000);

        manager.addHelado(actionEvent);

        assertTrue(manager.getListaDetalleHelados().isEmpty());
        assertTrue(manager.getOncomplete().startsWith("javascript:"));
    }

    @Test
    public void addingAndRemovingIceCreamWhenCurrentListIsEmpty() {
        manager.setP_id_heladero(ICE_CREAM_MAN_ID);
        manager.setSug_id_helado(1);
        manager.setSug_helado(ICE_CREAM_STUB_NAME);
        manager.setCantidad(10);

        manager.addHelado(actionEvent);

        assertFalse(manager.getListaDetalleHelados().isEmpty());
        assertEquals(1, manager.getListaDetalleHelados().size());
        assertNotNull(manager.getListaDetalleHelados().get(0).getHelado().getNombreHelado());
        assertEquals(10, manager.getListaDetalleHelados().get(0).getCantPendiente());
        assertEquals(10, manager.getListaDetalleHelados().get(0).getCantEntregada());

        // new ice cream with id 2
        manager.setSug_id_helado(2);
        manager.setSug_helado(ICE_CREAM_STUB_NAME);
        manager.setCantidad(10);

        manager.addHelado(actionEvent);

        assertFalse(manager.getListaDetalleHelados().isEmpty());
        assertEquals(2, manager.getListaDetalleHelados().size());
        assertNotNull(manager.getListaDetalleHelados().get(0).getHelado().getNombreHelado());
        assertNotNull(manager.getListaDetalleHelados().get(1).getHelado().getNombreHelado());

        // new ice cream with id 3
        manager.setSug_id_helado(3);
        manager.setSug_helado(ICE_CREAM_STUB_NAME);
        manager.setCantidad(15);

        manager.addHelado(actionEvent);

        assertFalse(manager.getListaDetalleHelados().isEmpty());
        assertEquals(3, manager.getListaDetalleHelados().size());
        assertNotNull(manager.getListaDetalleHelados().get(0).getHelado().getNombreHelado());
        assertNotNull(manager.getListaDetalleHelados().get(1).getHelado().getNombreHelado());
        assertNotNull(manager.getListaDetalleHelados().get(2).getHelado().getNombreHelado());

        //adding more ice creams to the same
        manager.setSug_id_helado(2);
        manager.setSug_helado(ICE_CREAM_STUB_NAME);
        manager.setCantidad(20);

        manager.addHelado(actionEvent);

        assertFalse(manager.getListaDetalleHelados().isEmpty());
        assertEquals(3, manager.getListaDetalleHelados().size());
        assertEquals(30, manager.getListaDetalleHelados().get(1).getCantPendiente());
        assertEquals(30, manager.getListaDetalleHelados().get(1).getCantEntregada());
        assertNotNull(manager.getListaDetalleHelados().get(0).getHelado().getIdHelado());
        assertNotNull(manager.getListaDetalleHelados().get(1).getHelado().getIdHelado());
        assertNotNull(manager.getListaDetalleHelados().get(2).getHelado().getIdHelado());
        assertNotNull(manager.getListaDetalleHelados().get(0).getHelado().getNombreHelado());
        assertNotNull(manager.getListaDetalleHelados().get(1).getHelado().getNombreHelado());
        assertNotNull(manager.getListaDetalleHelados().get(2).getHelado().getNombreHelado());

        // removing by index
        when(uiParameter.getValue()).thenReturn("1");

        manager.removeHelado(actionEvent);

        assertFalse(manager.getListaDetalleHelados().isEmpty());
        assertEquals(2, manager.getListaDetalleHelados().size());
        assertNotNull(manager.getListaDetalleHelados().get(0).getHelado().getIdHelado());
        assertNotNull(manager.getListaDetalleHelados().get(1).getHelado().getIdHelado());
        assertNotNull(manager.getListaDetalleHelados().get(0).getHelado().getNombreHelado());
        assertNotNull(manager.getListaDetalleHelados().get(1).getHelado().getNombreHelado());
    }
}