/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.service;

import pe.lamborgini.domain.Usuario;

/**
 *
 * @author Cesardl
 */
public class UsuarioService {

    public static boolean validarUsuario(Usuario usuario) {
        if (usuario.getUsuario().equals("admin")
                && usuario.getContrasenha().equals("admin")) {
            return true;
        } else {
            return false;
        }
    }
}
