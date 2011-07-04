/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import javax.faces.event.ActionEvent;
import pe.lamborgini.domain.mapping.Heladero;
import pe.lamborgini.service.HeladeroService;

/**
 *
 * @author Cesardl
 */
public class ManagerHeladero {

    private String nombre;
    private String apellido;
    private List<Heladero> listaHeladeros;
    private String oncomplete;
    //Para el modal

    public ManagerHeladero() {
        listaHeladeros = new ArrayList<Heladero>(0);
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public List<Heladero> getListaHeladeros() {
        return listaHeladeros;
    }

    public void setListaHeladeros(List<Heladero> listaHeladeros) {
        this.listaHeladeros = listaHeladeros;
    }

    public String getOncomplete() {
        return oncomplete;
    }

    public void setOncomplete(String oncomplete) {
        this.oncomplete = oncomplete;
    }

    public void buscarHeladero(ActionEvent event) {
        this.setOncomplete("");
        if (nombre.trim().length() == 0 && apellido.trim().length() == 0) {
            this.setOncomplete("javascript:alert('Ingrese campo para realizar la busqueda.')");
        } else {
            Collection<Heladero> c = HeladeroService.obtenerHeladeros(nombre, apellido);
            listaHeladeros = new ArrayList<Heladero>(c);
        }
    }

    public void cleanFormularioPrincipal() {
        this.nombre = "";
        this.apellido = "";
        this.listaHeladeros = new ArrayList<Heladero>(0);
    }
}
