/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.service;

import pe.lamborgini.dao.UsuarioDAO;
import pe.lamborgini.domain.mapping.Usuario;

/**
 *
 * @author Cesardl
 */
public class UsuarioService {

    public static boolean validarUsuario(String nombre_usuario, String contrasenha) {
        UsuarioDAO dao = new UsuarioDAO();
        Usuario usuario = dao.getUsuario(nombre_usuario, contrasenha);
        if (usuario != null) {
            return true;
        } else {
            return false;
        }
    }
}
