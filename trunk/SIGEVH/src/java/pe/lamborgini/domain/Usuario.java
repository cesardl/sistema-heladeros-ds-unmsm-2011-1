/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.domain;

/**
 *
 * @author Cesardl
 */
public class Usuario {

    private String usuario;
    private String contrasenha;

    public Usuario() {
        this.usuario = "";
        this.contrasenha = "";
    }

    public Usuario(String usuario, String contrasena) {
        this.usuario = usuario;
        this.contrasenha = contrasena;
    }

    public String getContrasenha() {
        return contrasenha;
    }

    public void setContrasenha(String contrasenha) {
        this.contrasenha = contrasenha;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    @Override
    public String toString() {
        return "Usuario: " + usuario + "\t Contrasenha: " + contrasenha;
    }
}
