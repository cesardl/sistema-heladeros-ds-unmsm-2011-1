/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.controller.modal;

import java.util.ArrayList;
import java.util.List;
import javax.el.ExpressionFactory;
import javax.faces.component.UIParameter;
import javax.faces.context.FacesContext;
import javax.faces.el.ValueBinding;
import javax.faces.event.ActionEvent;
import org.apache.el.ExpressionFactoryImpl;
import pe.lamborgini.controller.ManagerHeladero;
import pe.lamborgini.domain.mapping.DetalleHelado;
import pe.lamborgini.domain.mapping.Helado;
import pe.lamborgini.service.HeladoService;
import pe.lamborgini.service.HeladosEntregadoRecibidoService;
import pe.lamborgini.util.AppUtil;

/**
 *
 * @author Cesardl
 */
public class ManagerAsignacion {

    private String p_id_heladero;
    private String sug_helado;
    private int cantidad;
    private int sug_id_helado;
    private List<DetalleHelado> listaDetalleHelados;
    private String oncomplete;

    public ManagerAsignacion() {
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

    public void guardarAsignaciones(ActionEvent event) {
        this.setOncomplete("");
        if (listaDetalleHelados.isEmpty()) {
            this.setOncomplete("javascript:alert('Debe de ingresar algun helado.')");
        } else {
            HeladosEntregadoRecibidoService.guardarHeladosEntregadoRecibido(listaDetalleHelados, p_id_heladero);

            FacesContext ctx = FacesContext.getCurrentInstance();
            ValueBinding vb = ctx.getApplication().createValueBinding("#{managerHeladero}");
            ManagerHeladero mh = (ManagerHeladero) vb.getValue(ctx);
            mh.cleanFormularioPrincipal();
            this.setOncomplete("javascript:alert('Asignacion realizada con exito.');"
                    + "Richfaces.hideModalPanel('mp_asignar_helados');");
        }
    }
}
