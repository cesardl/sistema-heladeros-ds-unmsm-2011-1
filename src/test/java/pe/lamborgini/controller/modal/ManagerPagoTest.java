package pe.lamborgini.controller.modal;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;

import javax.faces.component.UIComponent;
import javax.faces.component.UIParameter;
import javax.faces.event.ActionEvent;

import static org.junit.Assert.*;
import static org.mockito.Matchers.anyString;
import static org.mockito.Mockito.when;

/**
 * Created on 05/10/2019.
 *
 * @author Cesardl
 */
@RunWith(MockitoJUnitRunner.class)
public class ManagerPagoTest {

    private ManagerPago manager = new ManagerPago();

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
        manager.setConcessionaireName(null);
        manager.setIceCreamManName(null);
        manager.setIceCreamDetailsList(null);
    }

    @Test
    public void openModalForIceCreamsPaymentTest() {
        when(uiParameter.getValue()).thenReturn("214");

        manager.pagarHeladero(actionEvent);

        assertNotNull(manager.getIceCreamManName());
        assertNotNull(manager.getConcessionaireName());

        assertFalse(manager.getIceCreamDetailsList().isEmpty());
        assertTrue(manager.getOncomplete().startsWith("Richfaces."));
    }

    @Test
    public void openModalForIceCreamsPaymentWithoutAssignationTest() {
        when(uiParameter.getValue()).thenReturn("200");

        manager.pagarHeladero(actionEvent);

        assertNull(manager.getIceCreamManName());
        assertNull(manager.getConcessionaireName());

        assertNull(manager.getIceCreamDetailsList());
        assertTrue(manager.getOncomplete().startsWith("javascript:alert"));
        assertTrue(manager.getOncomplete().contains("pagar"));
    }
}
