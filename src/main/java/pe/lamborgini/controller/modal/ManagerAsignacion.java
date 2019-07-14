/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.controller.modal;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import pe.lamborgini.controller.ManagerHeladero;
import pe.lamborgini.domain.mapping.DetalleHelado;
import pe.lamborgini.domain.mapping.Helado;
import pe.lamborgini.domain.mapping.HeladosEntregadoRecibido;
import pe.lamborgini.service.DetalleHeladoService;
import pe.lamborgini.service.HeladoService;
import pe.lamborgini.service.HeladosEntregadoRecibidoService;
import pe.lamborgini.util.AppUtil;

import javax.faces.component.UIParameter;
import javax.faces.event.ActionEvent;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.IntStream;

/**
 * @author Cesardl
 */
public class ManagerAsignacion {

    private static final Logger LOG = LoggerFactory.getLogger(ManagerAsignacion.class);

    private String nombre_consecionario;
    private String nombres_heladero;
    private String p_id_heladero;
    private String sug_helado;
    private int cantidad;
    private int sug_id_helado;
    private List<DetalleHelado> listaDetalleHelados;
    private String oncomplete;

    public ManagerAsignacion() {
        listaDetalleHelados = new ArrayList<>(0);
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
        LOG.debug("Obteniendo lista de detalle de helado, {} en total", listaDetalleHelados.size());
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
        LOG.debug("Iniciando proceso de asignacion de helados [{}]", event.getPhaseId());

        oncomplete = "";

        p_id_heladero = ((UIParameter) event.getComponent().findComponent("p_id_heladero")).getValue().toString();
        nombres_heladero = ((UIParameter) event.getComponent().findComponent("p_nombres_heladero")).getValue().toString();
        nombre_consecionario = ((UIParameter) event.getComponent().findComponent("p_nombre_consecionario")).getValue().toString();

        HeladosEntregadoRecibido her = HeladosEntregadoRecibidoService.existeAsignacionParaHeladero(p_id_heladero);
        if (her == null) {
            listaDetalleHelados = new ArrayList<>(0);
            oncomplete = "Richfaces.showModalPanel('mp_asignar_helados');";
        } else {
            oncomplete = "javascript:alert('Ya presenta asignaciones para el de hoy.');";
        }
    }

    public List<Helado> autocomplete(Object suggest) {
        String pref = (String) suggest;
        LOG.debug("Making search of an ice cream with name '{}'", pref);
        return HeladoService.obtenerHeladoPorNombre(pref);
    }

    public void addHelado(ActionEvent event) {
        LOG.debug("Asignando helado [{}]", event.getPhaseId());
        oncomplete = "";

        if (sug_id_helado == 0) {
            LOG.warn("Should to select an ice cream");
            oncomplete = "javascript:alert('Debe de ingresar algun helado.')";

        } else if (cantidad == 0) {
            LOG.warn("Should to enter a quantity");
            oncomplete = "javascript:alert('Ingrese un valor distinto a cero (0).');";

        } else {
            LOG.info("Generating ice cream assignation");
            DetalleHelado iceCreamDetail = listaDetalleHelados.stream()
                    .filter(dh -> AppUtil.aInteger(dh.getHelado().getIdHelado().toString()) == sug_id_helado)
                    .findFirst().orElse(new DetalleHelado());

            if (iceCreamDetail.getHelado() == null) {
                listaDetalleHelados.add(iceCreamDetail);
                LOG.info("Adding new ice cream {} to current list", sug_helado);
            } else {
                LOG.info("Founded ice cream detail: {}", iceCreamDetail.getHelado().getNombreHelado());
            }

            int lastDayPendingIceCreams = DetalleHeladoService.calcularHeladosPendientes(p_id_heladero, sug_id_helado);

            iceCreamDetail.setCantEntregada(cantidad + iceCreamDetail.getCantEntregada());
            iceCreamDetail.setCantDevuelta(0);
            iceCreamDetail.setCantVendida(0);
            // Actually + pending assignations
            iceCreamDetail.setCantPendiente(cantidad + +iceCreamDetail.getCantPendiente() + lastDayPendingIceCreams);

            Helado helado = new Helado();
            helado.setIdHelado(sug_id_helado);
            helado.setNombreHelado(sug_helado);
            iceCreamDetail.setHelado(helado);

            LOG.info("Adding {} ice creams", listaDetalleHelados.size());
            updatePositions();
            cleanFormularioAsignacion();
        }
    }

    public void removeHelado(ActionEvent event) {
        String p_dh_pos = ((UIParameter) event.getComponent().findComponent("dh_pos")).getValue().toString();
        listaDetalleHelados.removeIf(dh -> dh.getPosicion() == AppUtil.aInteger(p_dh_pos));
        updatePositions();
    }

    private void updatePositions() {
        IntStream.range(0, listaDetalleHelados.size()).forEach(i -> listaDetalleHelados.get(i).setPosicion(i + 1));
    }

    private void cleanFormularioAsignacion() {
        this.sug_id_helado = 0;
        this.sug_helado = "";
        this.cantidad = 0;
    }

    public void guardarAsignaciones(ActionEvent event) {
        LOG.debug("Guardando asignacione de helados [{}]", event.getPhaseId());

        oncomplete = "";

        if (listaDetalleHelados.isEmpty()) {
            oncomplete = "javascript:alert('Debe de ingresar algun helado.')";
        } else {
            HeladosEntregadoRecibidoService.guardarHeladosEntregadoRecibido(listaDetalleHelados, p_id_heladero);

            ManagerHeladero mh = (ManagerHeladero) AppUtil.callManageBean("managerHeladero");
            mh.cleanFormularioPrincipal();
            oncomplete = "javascript:alert('Asignacion realizada con exito.');" +
                    "Richfaces.hideModalPanel('mp_asignar_helados');";
        }
    }
}
