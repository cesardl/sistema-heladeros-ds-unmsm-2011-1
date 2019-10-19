package pe.lamborgini.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import pe.lamborgini.domain.mapping.Concesionario;
import pe.lamborgini.service.ConcesionarioService;

import javax.faces.model.SelectItem;
import java.util.Collection;

/**
 * Created on 22/09/2019.
 *
 * @author Cesardl
 */
public class BaseManager {

    private static final Logger LOG = LoggerFactory.getLogger(BaseManager.class);

    protected int concessionaireId;
    private SelectItem[] concessionaires;

    public int getConcessionaireId() {
        return concessionaireId;
    }

    public void setConcessionaireId(int concessionaireId) {
        this.concessionaireId = concessionaireId;
    }

    public SelectItem[] getConcessionaires() {
        LOG.debug("Getting concessionaires");
        if (concessionaires == null) {
            Collection<Concesionario> c = ConcesionarioService.obtenerConcesionario();

            concessionaires = new SelectItem[c.size() + 1];
            concessionaires[0] = new SelectItem("0", "----");

            int i = 1;
            for (Concesionario con : c) {
                concessionaires[i] = new SelectItem(con.getIdConcesionario(), con.getNombreConces());
                i++;
            }
        }
        return concessionaires;
    }

    public void setConcessionaires(SelectItem[] concessionaires) {
        this.concessionaires = concessionaires;
    }
}
