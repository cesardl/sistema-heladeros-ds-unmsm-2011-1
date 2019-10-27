package pe.lamborgini.controller;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.powermock.api.mockito.PowerMockito;
import org.powermock.core.classloader.annotations.PowerMockIgnore;
import org.powermock.core.classloader.annotations.PrepareForTest;
import org.powermock.modules.junit4.PowerMockRunner;
import pe.lamborgini.DomainStubs;
import pe.lamborgini.domain.mapping.Heladero;

import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import javax.faces.event.ActionEvent;
import javax.servlet.http.HttpSession;
import java.util.List;

import static org.junit.Assert.*;
import static org.mockito.Matchers.anyBoolean;
import static org.mockito.Mockito.when;

/**
 * Created on 07/07/2019.
 *
 * @author Cesardl
 * @see <a href='https://github.com/powermock/powermock/wiki/Code-coverage-with-JaCoCo'>Code Coverage with JaCoCo</a>
 */
@RunWith(PowerMockRunner.class)
@PowerMockIgnore({"javax.management.*", "org.jacoco.agent.rt.*", "org.apache.log4j.*"})
@PrepareForTest(FacesContext.class)
public class ManagerHeladeroTest {

    private ManagerHeladero manager = new ManagerHeladero();
    @Mock
    private ActionEvent actionEvent;
    @Mock
    private FacesContext facesContext;
    @Mock
    private ExternalContext externalContext;
    @Mock
    private HttpSession httpSession;

    @Before
    public void setUp() {
        PowerMockito.mockStatic(FacesContext.class);
        when(FacesContext.getCurrentInstance()).thenReturn(facesContext);
        when(facesContext.getExternalContext()).thenReturn(externalContext);
        when(externalContext.getSession(anyBoolean())).thenReturn(httpSession);
    }

    @After
    public void setDown() {
        manager.setOncomplete(null);
        manager.setListaHeladeros(null);
        manager.setConcessionaires(null);
    }

    @Test
    public void firstPageLoadIceCreamMenListForAdminTest() {
        manager.setNombre("");
        manager.setApellido("");
        manager.setConcessionaireId(0);

        when(httpSession.getAttribute("usuario")).thenReturn(DomainStubs.userAdmin());

        List<Heladero> result = manager.getListaHeladeros();

        assertEquals(281, result.size());
        result.forEach(icm -> {
            assertNotNull(icm.getIdHeladero());
            assertNotNull(icm.getLastName());
            assertNotNull(icm.getName());
            assertNotNull(icm.getConcessionaire().getNombreConces());
            assertNotNull(icm.getHeladosEntregadoRecibidos());
        });
        assertTrue(manager.getNombre().isEmpty());
        assertTrue(manager.getApellido().isEmpty());
    }

    @Test
    public void firstPageLoadIceCreamMenListForManagerTest() {
        manager.setNombre("");
        manager.setApellido("");

        when(httpSession.getAttribute("usuario")).thenReturn(DomainStubs.userManager(5, 5));

        List<Heladero> result = manager.getListaHeladeros();

        assertEquals(47, result.size());
        assertTrue(manager.getNombre().isEmpty());
        assertTrue(manager.getApellido().isEmpty());
        assertEquals(0, manager.getConcessionaireId());
    }

    @Test
    public void buscarHeladeroWithFilterForAdminTest() {
        manager.setNombre("d");
        manager.setApellido("z");
        manager.setConcessionaireId(6);

        when(httpSession.getAttribute("usuario")).thenReturn(DomainStubs.userAdmin());

        manager.buscarHeladero(actionEvent);

        List<Heladero> result = manager.getListaHeladeros();

        assertEquals(7, result.size());
        assertFalse(manager.getNombre().isEmpty());
        assertFalse(manager.getApellido().isEmpty());
    }

    @Test
    public void buscarHeladeroWithFilterForManagerTest() {
        manager.setNombre("d");
        manager.setApellido("z");

        when(httpSession.getAttribute("usuario")).thenReturn(DomainStubs.userManager(2, 2));

        manager.buscarHeladero(actionEvent);

        List<Heladero> result = manager.getListaHeladeros();

        assertEquals(5, result.size());
        assertFalse(manager.getNombre().isEmpty());
        assertFalse(manager.getApellido().isEmpty());
        assertEquals(0, manager.getConcessionaireId());
    }
}
