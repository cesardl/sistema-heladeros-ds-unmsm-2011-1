/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.controller;

import pe.lamborgini.domain.Usuario;
import pe.lamborgini.service.UsuarioService;

/**
 *
 * @author Cesardl
 */
public class ManagerUsuario {

    private Usuario usuario;

    public ManagerUsuario() {
        this.usuario = new Usuario();
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public String ingresar() {
        System.out.println("Bienvenido " + usuario);
        if (UsuarioService.validarUsuario(usuario)) {
            return "SUCCESS";
        } else {
            return "FAIL";
        }
    }
    
    public String salir() {
        return "TO_INDEX";
    }
}
