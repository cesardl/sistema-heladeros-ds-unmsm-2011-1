package pe.lamborgini.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.powermock.api.mockito.PowerMockito;
import org.powermock.core.classloader.annotations.PowerMockIgnore;
import org.powermock.core.classloader.annotations.PrepareForTest;
import org.powermock.modules.junit4.PowerMockRunner;
import pe.lamborgini.domain.mapping.Concesionario;
import pe.lamborgini.domain.mapping.Usuario;

import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import javax.faces.event.ActionEvent;
import javax.servlet.http.HttpSession;

import static org.mockito.Matchers.anyBoolean;
import static org.mockito.Mockito.when;

/**
 * Created on 07/07/2019.
 *
 * @author Cesardl
 */
@RunWith(PowerMockRunner.class)
@PowerMockIgnore({"org.apache.log4j.*", "org.apache.commons.logging.*"})
@PrepareForTest({FacesContext.class})
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
        when(httpSession.getAttribute("usuario")).thenReturn(usuarioStub());
    }

    private Usuario usuarioStub() {
        Usuario usuario = new Usuario();
        usuario.setConcesionario(new Concesionario());
        usuario.getConcesionario().setIdConcesionario(1);
        return usuario;
    }

    @Test
    public void buscarHeladeroTest() {
        manager.setNombre("");
        manager.setApellido("");
        manager.buscarHeladero(actionEvent);
    }
}