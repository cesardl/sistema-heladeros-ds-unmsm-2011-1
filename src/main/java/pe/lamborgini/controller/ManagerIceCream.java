package pe.lamborgini.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import pe.lamborgini.domain.mapping.Helado;
import pe.lamborgini.service.HeladoService;

import javax.faces.event.ActionEvent;
import java.util.List;

/**
 * Created on 21/07/2019.
 *
 * @author Cesardl
 */
public class ManagerIceCream {

    private static final Logger LOG = LoggerFactory.getLogger(ManagerIceCream.class);

    private List<Helado> iceCreamsList;

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

    public void newIceCream(ActionEvent event) {
        LOG.debug("New Ice Cream [{}]", event.getPhaseId());
    }
}
