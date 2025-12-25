/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import pe.lamborgini.domain.dto.ContratoHeladeroDTO;
import pe.lamborgini.domain.mapping.ContratoHeladero;
import pe.lamborgini.domain.mapping.Heladero;
import pe.lamborgini.service.HeladeroService;
import pe.lamborgini.util.AppUtil;

import javax.faces.component.UIParameter;
import javax.faces.event.ActionEvent;
import java.io.Serializable;
import java.util.List;

/**
 * @author Cesardl
 */
public class ManagerHeladero extends BaseManager implements Serializable {

    private static final long serialVersionUID = -864588576450764331L;

    private static final Logger LOG = LoggerFactory.getLogger(ManagerHeladero.class);

    private String nombre;
    private String apellido;

    private List<Heladero> listaHeladeros;
    private Heladero editedIceCreamMan;
    private ContratoHeladeroDTO contract;

    private String oncomplete;

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public List<Heladero> getListaHeladeros() {
        synchronized (this) {
            if (listaHeladeros == null) {
                LOG.info("Initializing ice creams list");

                listaHeladeros = HeladeroService.obtenerHeladeros("", "", 0);
            }
        }
        LOG.debug("Obteniendo lista de heladeros, {} en total", listaHeladeros.size());
        return listaHeladeros;
    }

    public void setListaHeladeros(List<Heladero> listaHeladeros) {
        this.listaHeladeros = listaHeladeros;
    }

    public Heladero getEditedIceCreamMan() {
        return editedIceCreamMan;
    }

    public void setEditedIceCreamMan(Heladero editedIceCreamMan) {
        this.editedIceCreamMan = editedIceCreamMan;
    }

    public ContratoHeladeroDTO getContract() {
        return contract;
    }

    public void setContract(ContratoHeladeroDTO contract) {
        this.contract = contract;
    }

    public String getOncomplete() {
        return oncomplete;
    }

    public void setOncomplete(String oncomplete) {
        this.oncomplete = oncomplete;
    }

    public void buscarHeladero(ActionEvent event) {
        LOG.debug("Buscando heladeros [{}]", event.getPhaseId());

        listaHeladeros = HeladeroService.obtenerHeladeros(nombre, apellido, concessionaireId);
    }

    public void newIceCreamMan(ActionEvent event) {
        LOG.debug("Nuevo heladero [{}]", event.getPhaseId());

        editedIceCreamMan = new Heladero();
    }

    public void saveOrUpdate(final ActionEvent event) {
        LOG.debug("Guardando edicion de heladero [{}]", event.getPhaseId());
    }

    public void loadContract(final ActionEvent event) {
        LOG.debug("Loading contract [{}]", event.getPhaseId());
        String strIceCreamManId = ((UIParameter) event.getComponent().findComponent("p_id_heladero")).getValue().toString();
        int paramIceCreamManId = AppUtil.aInteger(strIceCreamManId);
        LOG.debug("Validating contract of IceCreamMan '{}'", paramIceCreamManId);

        contract = HeladeroService.loadcontract(paramIceCreamManId);
    }
}
