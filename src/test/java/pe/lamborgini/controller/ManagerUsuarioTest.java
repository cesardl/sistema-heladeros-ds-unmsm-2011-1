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
import pe.lamborgini.domain.mapping.Usuario;
import pe.lamborgini.util.AppUtil;

import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import javax.faces.event.ActionEvent;
import javax.faces.model.SelectItem;
import javax.servlet.http.HttpSession;
import java.util.Collections;
import java.util.List;

import static org.junit.Assert.*;
import static org.mockito.Matchers.anyBoolean;
import static org.mockito.Mockito.*;

/**
 * Created on 14/07/2019.
 *
 * @author Cesardl
 * @see <a href='https://github.com/powermock/powermock/wiki/Code-coverage-with-JaCoCo'>Code Coverage with JaCoCo</a>
 * @see <a href='https://github.com/powermock/powermock/issues/478'>Add jacoco package to the default packages to be deferred #478</a>
 */
@RunWith(PowerMockRunner.class)
@PowerMockIgnore({"javax.management.*", "org.jacoco.agent.rt.*", "org.apache.log4j.*"})
@PrepareForTest(FacesContext.class)
public class ManagerUsuarioTest {

    private ManagerUsuario manager = new ManagerUsuario();
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
        manager.setListaUsuarios(null);
        manager.setConcessionaires(null);
    }

    @Test
    public void ingresarUsuarioSuccessfulTest() {
        manager.setUsername("LHanampa");
        manager.setPassword("luis");

        String result = manager.ingresar();

        assertEquals("SUCCESS", result);
        assertNull(manager.getUsername());
        assertNull(manager.getPassword());
        assertNull(manager.getOncomplete());

        verify(httpSession, times(1)).setAttribute(anyString(), any(Usuario.class));
        verifyNoMoreInteractions(httpSession);
    }

    @Test
    public void ingresarUsuarioFailedTest() {
        manager.setUsername("fakeUser");
        manager.setPassword("fakePassword");

        String result = manager.ingresar();

        assertEquals("FAIL", result);
        assertNull(manager.getOncomplete());

        verify(httpSession, never()).setAttribute(anyString(), any(Usuario.class));
    }

    @Test
    public void salirTest() {
        when(httpSession.getAttributeNames()).thenReturn(Collections.enumeration(Collections.singleton("usuario")));
        String result = manager.salir();

        assertEquals("TO_INDEX", result);
    }

    @Test
    public void listConcessionairesTest() {
        SelectItem[] result = manager.getConcessionaires();

        assertEquals(6, result.length);
        assertEquals(0, AppUtil.aInteger(result[0].getValue().toString()));

        // reload
        SelectItem[] resultReload = manager.getConcessionaires();
        assertArrayEquals(result, resultReload);
    }

    @Test
    public void findAllConcessionaireTest() {
        manager.setConcessionaireId(0);

        when(httpSession.getAttribute("usuario")).thenReturn(DomainStubs.userAdmin());

        List<Usuario> result = manager.getListaUsuarios();

        assertEquals(5, result.size());
    }

    @Test
    public void findConcessionaireByFilterTest() {
        manager.setConcessionaireId(2);

        when(httpSession.getAttribute("usuario")).thenReturn(DomainStubs.userAdmin());

        manager.findByConcessionaire(actionEvent);

        assertEquals(1, manager.getListaUsuarios().size());
    }
}
