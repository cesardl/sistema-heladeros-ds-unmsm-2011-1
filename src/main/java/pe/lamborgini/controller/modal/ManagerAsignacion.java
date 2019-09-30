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

    private String paramIceCreamManId;
    private String paramIceCreamManNames;
    private String paramConcessionaireName;
    private int suggestedIceCreamId;
    private String suggestedIceCream;
    private int quantity;
    private List<DetalleHelado> iceCreamDetailsList;
    private String oncomplete;

    public String getParamIceCreamManId() {
        return paramIceCreamManId;
    }

    public void setParamIceCreamManId(String paramIceCreamManId) {
        this.paramIceCreamManId = paramIceCreamManId;
    }

    public String getParamIceCreamManNames() {
        return paramIceCreamManNames;
    }

    public void setParamIceCreamManNames(String paramIceCreamManNames) {
        this.paramIceCreamManNames = paramIceCreamManNames;
    }

    public String getParamConcessionaireName() {
        return paramConcessionaireName;
    }

    public void setParamConcessionaireName(String paramConcessionaireName) {
        this.paramConcessionaireName = paramConcessionaireName;
    }

    public int getSuggestedIceCreamId() {
        return suggestedIceCreamId;
    }

    public void setSuggestedIceCreamId(int suggestedIceCreamId) {
        this.suggestedIceCreamId = suggestedIceCreamId;
    }

    public String getSuggestedIceCream() {
        return suggestedIceCream;
    }

    public void setSuggestedIceCream(String suggestedIceCream) {
        this.suggestedIceCream = suggestedIceCream;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
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

    public void asignarHelado(ActionEvent event) {
        LOG.debug("Iniciando proceso de asignacion de helados [{}]", event.getPhaseId());

        oncomplete = "";

        paramIceCreamManId = ((UIParameter) event.getComponent().findComponent("p_id_heladero")).getValue().toString();
        paramIceCreamManNames = ((UIParameter) event.getComponent().findComponent("p_nombres_heladero")).getValue().toString();
        paramConcessionaireName = ((UIParameter) event.getComponent().findComponent("p_nombre_consecionario")).getValue().toString();

        HeladosEntregadoRecibido her = HeladosEntregadoRecibidoService.existeAsignacionParaHeladero(paramIceCreamManId);
        if (her == null) {
            iceCreamDetailsList = new ArrayList<>(0);
            oncomplete = "Richfaces.showModalPanel('mp_asignar_helados');";
        } else {
            iceCreamDetailsList = null;
            oncomplete = "javascript:alert('Ya presenta asignaciones para el de hoy.');";
        }
    }

    public List<Helado> autocomplete(Object suggest) {
        String pref = (String) suggest;
        LOG.debug("Making search of an ice cream with name '{}'", pref);
        return HeladoService.obtenerHeladoPorNombre(pref);
    }

    public void addIceCream(ActionEvent event) {
        LOG.debug("Ice cream assignation [{}]", event.getPhaseId());

        oncomplete = "";

        if (suggestedIceCreamId == 0) {
            LOG.warn("Should to select an ice cream");
            oncomplete = "javascript:alert('Debe de ingresar algun helado.')";

        } else if (quantity == 0) {
            LOG.warn("Should to enter a quantity");
            oncomplete = "javascript:alert('Ingrese un valor distinto a cero (0).');";

        } else {
            LOG.info("Generating ice cream assignation");
            DetalleHelado iceCreamDetail = iceCreamDetailsList.stream()
                    .filter(dh -> dh.getHelado().getIdHelado() == suggestedIceCreamId)
                    .findFirst().orElse(new DetalleHelado());

            if (iceCreamDetail.getHelado() == null) {
                LOG.info("Adding new ice cream {} to current list", suggestedIceCream);
                iceCreamDetailsList.add(iceCreamDetail);

                int lastDayPendingIceCreams = DetalleHeladoService.calcularHeladosPendientes(paramIceCreamManId, suggestedIceCreamId);

                // Actually + pending assignations
                iceCreamDetail.setCantEntregada(quantity + iceCreamDetail.getCantEntregada() + lastDayPendingIceCreams);
                iceCreamDetail.setCantDevuelta(0);
                iceCreamDetail.setCantVendida(0);

                Helado helado = new Helado();
                helado.setIdHelado(suggestedIceCreamId);
                helado.setNombreHelado(suggestedIceCream);
                iceCreamDetail.setHelado(helado);
            } else {
                LOG.info("Founded ice cream detail: {}", iceCreamDetail.getHelado().getNombreHelado());

                // Actually + new assignation
                iceCreamDetail.setCantEntregada(quantity + iceCreamDetail.getCantEntregada());
            }

            updatePositions();
            clearAssignationForm();
            LOG.info("Assigned ice creams after add: {}", iceCreamDetailsList.size());
        }
    }

    public void removeIceCream(ActionEvent event) {
        String index = ((UIParameter) event.getComponent().findComponent("dh_pos")).getValue().toString();
        LOG.info("Removing ice cream on index {}", index);
        iceCreamDetailsList.removeIf(dh -> dh.getPosition() == AppUtil.aInteger(index));
        updatePositions();
        LOG.info("Assigned ice creams after remove: {}", iceCreamDetailsList.size());
    }

    private void updatePositions() {
        IntStream.range(0, iceCreamDetailsList.size()).forEach(i -> iceCreamDetailsList.get(i).setPosition(i + 1));
    }

    private void clearAssignationForm() {
        this.suggestedIceCreamId = 0;
        this.suggestedIceCream = "";
        this.quantity = 0;
    }

    public void saveAssignations(ActionEvent event) {
        LOG.debug("Guardando asignacione de helados [{}]", event.getPhaseId());

        oncomplete = "";

        if (iceCreamDetailsList.isEmpty()) {
            oncomplete = "javascript:alert('Debe de ingresar algun helado.')";
        } else {
            if (HeladoService.reservarStock(iceCreamDetailsList)) {
                HeladosEntregadoRecibidoService.guardarHeladosEntregadoRecibido(iceCreamDetailsList, paramIceCreamManId);

                oncomplete = "javascript:alert('Asignacion realizada con exito.');" +
                        "Richfaces.hideModalPanel('mp_asignar_helados');";
            } else {
                oncomplete = "javascript:alert('No hay stock disponible.')";
            }
        }
    }
}
