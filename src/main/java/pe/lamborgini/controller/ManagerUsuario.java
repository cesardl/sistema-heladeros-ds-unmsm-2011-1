/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import pe.lamborgini.domain.mapping.Concesionario;
import pe.lamborgini.domain.mapping.Usuario;
import pe.lamborgini.service.ConcesionarioService;
import pe.lamborgini.service.UsuarioService;

import javax.faces.model.SelectItem;
import java.io.Serializable;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

/**
 * @author Cesardl
 */
public class ManagerUsuario implements Serializable {

    private static final long serialVersionUID = 1863859236352270934L;

    private static final Logger LOG = LoggerFactory.getLogger(ManagerUsuario.class);

    private String nombre_usuario;
    private String contrasenha;
    private List<Usuario> listaUsuarios;
    private int id_concesionario;
    private SelectItem[] concesionarios;
    private String oncomplete;

    public ManagerUsuario() {
        listaUsuarios = Collections.emptyList();
    }

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
        LOG.debug("Obteniendo lista de usuarios, {} en total", listaUsuarios.size());
        return listaUsuarios;
    }

    public void setListaUsuarios(List<Usuario> listaUsuarios) {
        this.listaUsuarios = listaUsuarios;
    }

    public SelectItem[] getConcesionarios() {
        LOG.debug("Obteniendo lista de concesionarios");
        if (concesionarios == null) {
            Collection<Concesionario> c = ConcesionarioService.obtenerConcesionario();
            concesionarios = new SelectItem[c.size()];
            int i = 0;
            for (Concesionario con : c) {
                concesionarios[i] = new SelectItem(con.getIdConcesionario(), con.getNombreConces());
                i++;
            }
        }
        return concesionarios;
    }

    public void setConcesionarios(SelectItem[] concesionarios) {
        this.concesionarios = concesionarios;
    }

    public int getId_concesionario() {
        return id_concesionario;
    }

    public void setId_concesionario(int id_concesionario) {
        this.id_concesionario = id_concesionario;
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
}
