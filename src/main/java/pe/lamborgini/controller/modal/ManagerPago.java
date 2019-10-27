/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.controller.modal;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import pe.lamborgini.domain.mapping.DetalleHelado;
import pe.lamborgini.domain.mapping.HeladosEntregadoRecibido;
import pe.lamborgini.service.DetalleHeladoService;
import pe.lamborgini.service.HeladosEntregadoRecibidoService;

import javax.faces.component.UIParameter;
import javax.faces.event.ActionEvent;
import java.util.ArrayList;
import java.util.List;

/**
 * @author cesardl
 */
public class ManagerPago {

    private static final Logger LOG = LoggerFactory.getLogger(ManagerPago.class);

    private String concessionaireName;
    private String iceCreamManName;
    private List<DetalleHelado> iceCreamDetailsList;
    private String paramIceCreamManId;
    private String oncomplete;

    public String getConcessionaireName() {
        return concessionaireName;
    }

    public void setConcessionaireName(String concessionaireName) {
        this.concessionaireName = concessionaireName;
    }

    public String getIceCreamManName() {
        return iceCreamManName;
    }

    public void setIceCreamManName(String iceCreamManName) {
        this.iceCreamManName = iceCreamManName;
    }

    public List<DetalleHelado> getIceCreamDetailsList() {
        return iceCreamDetailsList;
    }

    public void setIceCreamDetailsList(List<DetalleHelado> iceCreamDetailsList) {
        this.iceCreamDetailsList = iceCreamDetailsList;
    }

    public String getOncomplete() {
        return oncomplete;
    }

    public void setOncomplete(String oncomplete) {
        this.oncomplete = oncomplete;
    }

    public void pagarHeladero(ActionEvent event) {
        LOG.debug("Iniciar proceso de devolucion de helados y pago al heladero [{}]", event.getPhaseId());
        this.setOncomplete("");
        paramIceCreamManId = ((UIParameter) event.getComponent().findComponent("p_id_heladero")).getValue().toString();
        iceCreamDetailsList = null;

        HeladosEntregadoRecibido her = HeladosEntregadoRecibidoService.existeAsignacionParaHeladero(paramIceCreamManId);
        if (her == null) {
            this.setOncomplete("javascript:alert('Debe realizar una asignacion de helados antes de pagar.');");
        } else {
            if (HeladosEntregadoRecibidoService.existePagoParaHeladero(her)) {
                this.setOncomplete("javascript:alert('Ya se ejecuto el proceso de pago.');");
            } else {
                iceCreamManName = her.getHeladero().toString();
                concessionaireName = her.getHeladero().getConcessionaire().getNombreConces();
                iceCreamDetailsList = new ArrayList<>(her.getDetalleHelados());
                this.setOncomplete("Richfaces.showModalPanel('mp_pagar_heladero');");
            }
        }
    }

    public void realizarPago(ActionEvent event) {
        LOG.debug("Realizando pago [{}]", event.getPhaseId());
        this.setOncomplete("");
        if (DetalleHeladoService.validarListaDeEntrega(iceCreamDetailsList)) {
            DetalleHeladoService.actualizarEntregaHelados(iceCreamDetailsList, paramIceCreamManId);

            this.setOncomplete("javascript:alert('Pago generados con exito.');"
                    + "Richfaces.hideModalPanel('mp_pagar_heladero');");
        } else {
            this.setOncomplete("javascript:alert('Ingrese valores correctos.');");
        }
    }
}
