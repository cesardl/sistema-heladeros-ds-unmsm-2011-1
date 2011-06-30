/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.controller;

import pe.lamborgini.service.HeladosEntregadoRecibidoService;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import javax.faces.component.UIParameter;
import javax.faces.event.ActionEvent;
import pe.lamborgini.domain.mapping.DetalleHelado;
import pe.lamborgini.domain.mapping.Heladero;
import pe.lamborgini.domain.mapping.Helado;
import pe.lamborgini.domain.mapping.HeladosEntregadoRecibido;
import pe.lamborgini.service.HeladeroService;
import pe.lamborgini.service.HeladoService;
import pe.lamborgini.util.AppUtil;

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
    private String p_id_heladero;
    private String sug_helado;
    private int cantidad;
    private int sug_id_helado;
    private List<DetalleHelado> listaDetalleHelados;

    public ManagerHeladero() {
        listaHeladeros = new ArrayList<Heladero>(0);
        listaDetalleHelados = new ArrayList<DetalleHelado>(0);
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

    public int getSug_id_helado() {
        return sug_id_helado;
    }

    public void setSug_id_helado(int sug_id_helado) {
        this.sug_id_helado = sug_id_helado;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public String getP_id_heladero() {
        return p_id_heladero;
    }

    public void setP_id_heladero(String p_id_heladero) {
        this.p_id_heladero = p_id_heladero;
    }

    public String getSug_helado() {
        return sug_helado;
    }

    public void setSug_helado(String sug_helado) {
        this.sug_helado = sug_helado;
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

    public List<DetalleHelado> getListaDetalleHelados() {
        return listaDetalleHelados;
    }

    public void setListaDetalleHelados(List<DetalleHelado> listaDetalleHelados) {
        this.listaDetalleHelados = listaDetalleHelados;
    }

    public void buscarHeladero(ActionEvent event) {
        System.out.println("event!" + nombre + " " + apellido);
        if (nombre.trim().length() == 0 && apellido.trim().length() == 0) {
            System.out.println("ingrese campo para realizar la busqueda");
        } else {
            Collection<Heladero> c = HeladeroService.obtenerHeladeros(nombre, apellido);
            listaHeladeros = new ArrayList<Heladero>(c);
        }
    }

    public void asignarHelado(ActionEvent event) {
        p_id_heladero = ((UIParameter) event.getComponent().findComponent("p_id_heladero")).getValue().toString();
        listaDetalleHelados = new ArrayList<DetalleHelado>(0);
        System.out.println("ASIGNAR al heladero " + p_id_heladero);
    }

    public List<Helado> autocomplete(Object suggest) throws Exception {
        String pref = (String) suggest;
        System.out.println("autocomplete " + pref);
        List<Helado> helados = HeladoService.obtenerHeladoPorNombre(pref);

        return helados;
    }

    public void addHelado(ActionEvent event) {
        this.setOncomplete("");
        if (cantidad == 0) {
            this.setOncomplete("javascript:alert('Ingrese un valor distinto a cero (0).')");
        } else {
            System.out.println("helado " + sug_id_helado + " - " + sug_helado);
            DetalleHelado dh = new DetalleHelado();
            dh.setCantDevuelta(0);
            dh.setCantEntregada(cantidad);
            dh.setCantVendida(0);

            Helado helado = new Helado();
            helado.setIdHelado(sug_id_helado);
            helado.setNombreHelado(sug_helado);
            dh.setHelado(helado);

            listaDetalleHelados.add(dh);
            updatePositions();
            cleanFormularioAsignacion();
        }
    }

    public void removeHelado(ActionEvent event) {
        String p_dh_pos = ((UIParameter) event.getComponent().findComponent("dh_pos")).getValue().toString();
        System.out.println("dh_pos " + p_dh_pos);
        for (int i = 0; i < listaDetalleHelados.size(); i++) {
            DetalleHelado dh = listaDetalleHelados.get(i);
            if (dh.getPosicion() == AppUtil.aInteger(p_dh_pos)) {
                listaDetalleHelados.remove(i);
                break;
            }
        }
        updatePositions();
    }

    private void updatePositions() {
        for (int i = 0; i < listaDetalleHelados.size(); i++) {
            listaDetalleHelados.get(i).setPosicion(i + 1);
        }
    }

    private void cleanFormularioAsignacion() {
        this.sug_id_helado = 0;
        this.sug_helado = "";
        this.cantidad = 0;
    }

    private void cleanFormularioPrincipal() {
        this.nombre = "";
        this.apellido = "";
        this.listaHeladeros = new ArrayList<Heladero>(0);
    }

    public void guardarAsignaciones(ActionEvent event) {
        this.setOncomplete("");
        if (listaDetalleHelados.isEmpty()) {
            this.setOncomplete("javascript:alert('Debe de ingresar algun helado.')");
        } else {
            HeladosEntregadoRecibido her = new HeladosEntregadoRecibido();

            her.setFecha(new Date());
            her.setHeladero(new Heladero(AppUtil.aInteger(p_id_heladero)));

            double total = 0;

            for (int i = 0; i < listaDetalleHelados.size(); i++) {
                DetalleHelado dh = listaDetalleHelados.get(i);
                dh.setHeladosEntregadoRecibido(her);
                total = total + dh.getCantEntregada();
            }
            her.setDetalleHelados(new HashSet<DetalleHelado>(listaDetalleHelados));
            her.setTotal(total);

            System.out.println("total : " + total + "-" + listaDetalleHelados.size());
            HeladosEntregadoRecibidoService.guardarHeladosEntregadoRecibido(her);

            cleanFormularioPrincipal();
            this.setOncomplete("Richfaces.hideModalPanel('mp_asignar_helados')");
        }
    }
}
