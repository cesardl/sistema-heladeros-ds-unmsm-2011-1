/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import pe.lamborgini.domain.mapping.Usuario;
import pe.lamborgini.service.UsuarioService;

import javax.faces.event.ActionEvent;
import java.io.Serializable;
import java.util.List;

/**
 * @author Cesardl
 */
public class ManagerUsuario extends BaseManager implements Serializable {

    private static final long serialVersionUID = 1863859236352270934L;

    private static final Logger LOG = LoggerFactory.getLogger(ManagerUsuario.class);

    private String username;
    private String password;
    private List<Usuario> listaUsuarios;
    private String oncomplete;

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public List<Usuario> getListaUsuarios() {
        if (listaUsuarios == null) {
            listaUsuarios = UsuarioService.listUsersByConcessionaires(this.concessionaireId);
        }
        LOG.debug("Obteniendo lista de usuarios, {} en total", listaUsuarios.size());
        return listaUsuarios;
    }

    public void setListaUsuarios(List<Usuario> listaUsuarios) {
        this.listaUsuarios = listaUsuarios;
    }

    public String getOncomplete() {
        return oncomplete;
    }

    public void setOncomplete(String oncomplete) {
        this.oncomplete = oncomplete;
    }

    public String ingresar() {
        if (UsuarioService.validarUsuario(username, password)) {
            username = null;
            password = null;
            return "SUCCESS";
        } else {
            return "FAIL";
        }
    }

    public String salir() {
        UsuarioService.cerrarSesion();
        return "TO_INDEX";
    }

    public void findByConcessionaire(ActionEvent event) {
        LOG.debug("Buscando por concesionario [{}]", event.getPhaseId());

        listaUsuarios = UsuarioService.listUsersByConcessionaires(this.concessionaireId);
    }
}
