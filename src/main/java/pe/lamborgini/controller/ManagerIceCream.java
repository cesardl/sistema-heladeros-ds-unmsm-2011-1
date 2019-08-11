package pe.lamborgini.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import pe.lamborgini.domain.mapping.Helado;
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

    public List<Helado> getIceCreamsList() {
        synchronized (this) {
            if (iceCreamsList == null) {
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

    public void newIceCream(ActionEvent event) {
        LOG.debug("New Ice Cream [{}]", event.getPhaseId());

        editedIceCream = new Helado();

        oncomplete = "Richfaces.showModalPanel('mp_ice_cream');";
    }

    public void resetValues() {
        LOG.debug("Iniciar proceso de edicion de helado");
    }

    public void saveOrUpdate(ActionEvent event) {
        LOG.debug("Guardando edicion de helado [{}]", event.getPhaseId());
    }
}
