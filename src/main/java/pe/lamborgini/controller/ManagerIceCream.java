package pe.lamborgini.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import pe.lamborgini.domain.mapping.Helado;
import pe.lamborgini.domain.mapping.StockHelado;
import pe.lamborgini.service.HeladoService;

import javax.faces.event.ActionEvent;
import java.io.Serializable;
import java.util.List;

/**
 * Created on 21/07/2019.
 *
 * @author Cesardl
 */
public class ManagerIceCream implements Serializable {

    private static final long serialVersionUID = 2057210783706393567L;

    private static final Logger LOG = LoggerFactory.getLogger(ManagerIceCream.class);

    private List<Helado> iceCreamsList;
    private Helado editedIceCream;

    private String oncomplete;
    private boolean refresh;

    public List<Helado> getIceCreamsList() {
        synchronized (this) {
            if (iceCreamsList == null || refresh) {
                LOG.info("Initializing ice creams list");

                iceCreamsList = HeladoService.getAllIceCreams();
            }
        }
        LOG.debug("Getting ice creams list, {} total", iceCreamsList.size());
        return iceCreamsList;
    }

    public void setIceCreamsList(List<Helado> iceCreamsList) {
        this.iceCreamsList = iceCreamsList;
    }

    public Helado getEditedIceCream() {
        return editedIceCream;
    }

    public void setEditedIceCream(Helado editedIceCream) {
        this.editedIceCream = editedIceCream;
    }

    public String getOncomplete() {
        return oncomplete;
    }

    public void setOncomplete(String oncomplete) {
        this.oncomplete = oncomplete;
    }

    public void newIceCream(final ActionEvent event) {
        LOG.debug("New Ice Cream [{}]", event.getPhaseId());

        editedIceCream = new Helado();
        editedIceCream.setStockHelado(new StockHelado());
    }

    public void saveOrUpdate(final ActionEvent event) {
        LOG.debug("Guardando edicion de helado [{}]", event.getPhaseId());

        boolean operationResult = HeladoService.saveOrUpdate(editedIceCream);

        if (operationResult) {
            refresh = true;
            oncomplete = "javascript:alert('Registro de helado realizado con exito.');" +
                    "Richfaces.hideModalPanel('mp_ice_cream');";
        } else {
            refresh = false;
            oncomplete = "javascript:alert('Ocurrio un problema interno.')";
        }
    }

    public void delete(final ActionEvent event) {
        LOG.debug("Eliminando helado [{}]", event.getPhaseId());

        boolean operationResult = HeladoService.delete(editedIceCream);

        if (operationResult) {
            refresh = true;
            oncomplete = "javascript:alert('Registro de helado eliminado con exito.');" +
                    "Richfaces.hideModalPanel('mp_ice_cream_deletion_confirm');";
        } else {
            refresh = false;
            oncomplete = "javascript:alert('Ocurrio un problema interno.')";
        }
    }
}
