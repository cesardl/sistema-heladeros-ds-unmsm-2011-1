/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.controller.modal;

import java.util.ArrayList;
import java.util.List;
import javax.faces.component.UIParameter;
import javax.faces.event.ActionEvent;
import pe.lamborgini.controller.ManagerHeladero;
import pe.lamborgini.domain.mapping.DetalleHelado;
import pe.lamborgini.domain.mapping.Helado;
import pe.lamborgini.domain.mapping.HeladosEntregadoRecibido;
import pe.lamborgini.service.DetalleHeladoService;
import pe.lamborgini.service.HeladoService;
import pe.lamborgini.service.HeladosEntregadoRecibidoService;
import pe.lamborgini.util.AppUtil;

/**
 *
 * @author Cesardl
 */
public class ManagerAsignacion {

    private String nombre_consecionario;
    private String nombres_heladero;
    private String p_id_heladero;
    private String sug_helado;
    private int cantidad;
    private int sug_id_helado;
    private List<DetalleHelado> listaDetalleHelados;
    private String oncomplete;

    public ManagerAsignacion() {
    }

    public String getNombre_consecionario() {
        return nombre_consecionario;
    }

    public void setNombre_consecionario(String nombre_consecionario) {
        this.nombre_consecionario = nombre_consecionario;
    }

    public String getNombres_heladero() {
        return nombres_heladero;
    }

    public void setNombres_heladero(String nombres_heladero) {
        this.nombres_heladero = nombres_heladero;
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

    public List<DetalleHelado> getListaDetalleHelados() {
        return listaDetalleHelados;
    }

    public void setListaDetalleHelados(List<DetalleHelado> listaDetalleHelados) {
        this.listaDetalleHelados = listaDetalleHelados;
    }

    public String getOncomplete() {
        return oncomplete;
    }

    public void setOncomplete(String oncomplete) {
        this.oncomplete = oncomplete;
    }

    public void asignarHelado(ActionEvent event) {
        this.setOncomplete("");
        p_id_heladero = ((UIParameter) event.getComponent().findComponent("p_id_heladero")).getValue().toString();
        nombres_heladero = ((UIParameter) event.getComponent().findComponent("p_nombres_heladero")).getValue().toString();
        nombre_consecionario = ((UIParameter) event.getComponent().findComponent("p_nombre_consecionario")).getValue().toString();
        HeladosEntregadoRecibido her = HeladosEntregadoRecibidoService.existeAsignacionParaHeladero(p_id_heladero);
        if (her != null) {
            this.setOncomplete("javascript:alert('Ya presenta asignaciones para el de hoy.');");
        } else {
            listaDetalleHelados = new ArrayList<DetalleHelado>(0);
            this.setOncomplete("Richfaces.showModalPanel('mp_asignar_helados');");
        }
    }

    public List<Helado> autocomplete(Object suggest) throws Exception {
        String pref = (String) suggest;
        List<Helado> helados = HeladoService.obtenerHeladoPorNombre(pref);

        return helados;
    }

    public void addHelado(ActionEvent event) {
        this.setOncomplete("");
        if (cantidad == 0) {
            this.setOncomplete("javascript:alert('Ingrese un valor distinto a cero (0).');");
        } else {
            DetalleHelado dh = new DetalleHelado();
            dh.setCantDevuelta(0);
            dh.setCantEntregada(cantidad);
            dh.setCantVendida(0);
            dh.setCantPendiente(DetalleHeladoService.calcularHeladosPendientes(p_id_heladero, sug_id_helado));

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

    public void guardarAsignaciones(ActionEvent event) {
        this.setOncomplete("");
        if (listaDetalleHelados.isEmpty()) {
            this.setOncomplete("javascript:alert('Debe de ingresar algun helado.')");
        } else {
            HeladosEntregadoRecibidoService.guardarHeladosEntregadoRecibido(listaDetalleHelados, p_id_heladero);

            ManagerHeladero mh = (ManagerHeladero) AppUtil.callManageBean("managerHeladero");
            mh.cleanFormularioPrincipal();
            this.setOncomplete("javascript:alert('Asignacion realizada con exito.');"
                    + "Richfaces.hideModalPanel('mp_asignar_helados');");
        }
    }
}
