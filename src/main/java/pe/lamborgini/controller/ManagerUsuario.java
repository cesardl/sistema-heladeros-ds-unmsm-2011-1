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

    private String nombre_usuario;
    private String contrasenha;
    private List<Usuario> listaUsuarios;
    private String oncomplete;

    public String getContrasenha() {
        return contrasenha;
    }

    public void setContrasenha(String contrasenha) {
        this.contrasenha = contrasenha;
    }

    public String getNombre_usuario() {
        return nombre_usuario;
    }

    public void setNombre_usuario(String nombre_usuario) {
        this.nombre_usuario = nombre_usuario;
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
        if (UsuarioService.validarUsuario(nombre_usuario, contrasenha)) {
            nombre_usuario = null;
            contrasenha = null;
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
