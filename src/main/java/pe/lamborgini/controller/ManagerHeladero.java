/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import pe.lamborgini.domain.mapping.Heladero;
import pe.lamborgini.service.HeladeroService;

import javax.faces.event.ActionEvent;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

/**
 * @author Cesardl
 */
public class ManagerHeladero {

    private static final Logger LOG = LoggerFactory.getLogger(ManagerHeladero.class);

    private String nombre;
    private String apellido;
    private List<Heladero> listaHeladeros;
    private String oncomplete;
    //Para el modal

    public ManagerHeladero() {
        listaHeladeros = Collections.emptyList();
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
        LOG.debug("Obteniendo lista de heladeros, {} en total", listaHeladeros.size());
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
        LOG.debug("Buscando heladeros [{}]", event.getPhaseId());
        this.oncomplete = "";
        Collection<Heladero> c = HeladeroService.obtenerHeladeros(nombre, apellido);
        listaHeladeros = new ArrayList<>(c);
    }

    public void cleanFormularioPrincipal() {
        this.nombre = "";
        this.apellido = "";
        this.listaHeladeros = Collections.emptyList();
    }
}
