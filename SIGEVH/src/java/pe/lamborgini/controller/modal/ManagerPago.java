/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.controller.modal;

import java.util.ArrayList;
import java.util.List;
import javax.faces.component.UIParameter;
import javax.faces.event.ActionEvent;
import pe.lamborgini.domain.mapping.DetalleHelado;
import pe.lamborgini.domain.mapping.HeladosEntregadoRecibido;
import pe.lamborgini.service.HeladosEntregadoRecibidoService;

/**
 *
 * @author cesardl
 */
public class ManagerPago {

    private List<DetalleHelado> listaDetalleHelados;
    private String p_id_heladero;
    private String oncomplete;

    public ManagerPago() {
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
        listaDetalleHelados = new ArrayList<DetalleHelado>(0);
        System.out.println("ASIGNAR al heladero " + p_id_heladero);

         HeladosEntregadoRecibido her = HeladosEntregadoRecibidoService.existeAsignacionParaHeladero(p_id_heladero);
        if (her == null) {
            this.setOncomplete("javascript:alert('Debe realizar una asignacion de helados antes de pagar.');");
        } else {
            System.out.println(her.getDetalleHelados());
            this.setOncomplete("Richfaces.showModalPanel('mp_pagar_heladero');");
        }
    }
}
