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
import pe.lamborgini.domain.mapping.HeladosEntregadoRecibido;
import pe.lamborgini.service.DetalleHeladoService;
import pe.lamborgini.service.HeladosEntregadoRecibidoService;
import pe.lamborgini.util.AppUtil;

/**
 *
 * @author cesardl
 */
public class ManagerPago {

    private String nombre_consecionario;
    private String nombres_heladero;
    private List<DetalleHelado> listaDetalleHelados;
    private String p_id_heladero;
    private String oncomplete;

    public ManagerPago() {
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

    public void pagarHeladero(ActionEvent event) {
        this.setOncomplete("");
        p_id_heladero = ((UIParameter) event.getComponent().findComponent("p_id_heladero")).getValue().toString();

        HeladosEntregadoRecibido her = HeladosEntregadoRecibidoService.existeAsignacionParaHeladero(p_id_heladero);
        if (her == null) {
            this.setOncomplete("javascript:alert('Debe realizar una asignacion de helados antes de pagar.');");
        } else {
            if (HeladosEntregadoRecibidoService.existePagoParaHeladero(her)) {
                this.setOncomplete("javascript:alert('Ya se ejecuto el proceso de pago.');");
            } else {
                nombres_heladero = her.getHeladero().toString();
                nombre_consecionario = her.getHeladero().getConcesionario().getNombreConces();
                listaDetalleHelados = new ArrayList<DetalleHelado>(her.getDetalleHelados());
                this.setOncomplete("Richfaces.showModalPanel('mp_pagar_heladero');");
            }
        }
    }

    public void realizarPago(ActionEvent event) {
        this.setOncomplete("");
        if (DetalleHeladoService.validarListaDeEntrega(listaDetalleHelados)) {
            DetalleHeladoService.actualizarEntregaHelados(listaDetalleHelados, p_id_heladero);

            ManagerHeladero mh = (ManagerHeladero) AppUtil.callManageBean("managerHeladero");
            mh.cleanFormularioPrincipal();
            this.setOncomplete("javascript:alert('Pago generados con exito.');"
                    + "Richfaces.hideModalPanel('mp_pagar_heladero');");
        } else {
            this.setOncomplete("javascript:alert('Ingrese valores correctos.');");
        }
    }
}
