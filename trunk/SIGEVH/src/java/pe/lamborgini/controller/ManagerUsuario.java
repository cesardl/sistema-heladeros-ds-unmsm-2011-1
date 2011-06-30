/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.controller;

import java.util.ArrayList;
import java.util.List;
import pe.lamborgini.domain.mapping.Usuario;
import pe.lamborgini.service.UsuarioService;

/**
 *
 * @author Cesardl
 */
public class ManagerUsuario {

    private String nombre_usuario;
    private String contrasenha;

    public ManagerUsuario() {
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

    public String ingresar() {
        System.out.println("Bienvenido " + nombre_usuario);
        if (UsuarioService.validarUsuario(nombre_usuario, contrasenha)) {
            return "SUCCESS";
        } else {
            return "FAIL";
        }
    }

    public String salir() {
        return "TO_INDEX";
    }
}
