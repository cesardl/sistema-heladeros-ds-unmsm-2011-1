/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.controller;

import java.util.ArrayList;
import java.util.List;
import pe.lamborgini.domain.Usuario;
import pe.lamborgini.service.UsuarioService;

/**
 *
 * @author Cesardl
 */
public class ManagerUsuario {

    private Usuario usuario;
    private List<Usuario> listaUsuarios;

    public ManagerUsuario() {
        this.usuario = new Usuario();
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public List<Usuario> getListaUsuarios() {
        return listaUsuarios;
    }

    public void setListaUsuarios(List<Usuario> listaUsuarios) {
        this.listaUsuarios = listaUsuarios;
    }

    public String ingresar() {
        System.out.println("Bienvenido " + usuario);
        if (UsuarioService.validarUsuario(usuario)) {
            listaUsuarios = new ArrayList<Usuario>();
            listaUsuarios.add(new Usuario("user1", "passwd1"));
            listaUsuarios.add(new Usuario("user2", "passwd2"));
            listaUsuarios.add(new Usuario("user3", "passwd3"));
            listaUsuarios.add(new Usuario("user4", "passwd4"));
            listaUsuarios.add(new Usuario("user5", "passwd5"));
            listaUsuarios.add(new Usuario("user6", "passwd6"));
            listaUsuarios.add(new Usuario("user7", "passwd7"));
            listaUsuarios.add(new Usuario("user8", "passwd8"));
            listaUsuarios.add(new Usuario("user9", "passwd9"));
            System.out.println("se inicializo la lista " + listaUsuarios.size());
            return "SUCCESS";
        } else {
            return "FAIL";
        }
    }

    public String salir() {
        return "TO_INDEX";
    }
}
