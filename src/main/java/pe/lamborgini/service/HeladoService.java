/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.service;

import pe.lamborgini.dao.HeladoDAO;
import pe.lamborgini.domain.mapping.Helado;

import java.util.Collections;
import java.util.List;

/**
 * @author Cesardl
 */
public final class HeladoService {

    private HeladoService() {
    }

    public static List<Helado> obtenerHeladoPorNombre(final String pref) {
        if (pref == null || "null".equals(pref)) {
            return Collections.emptyList();
        } else {
            HeladoDAO dao = new HeladoDAO();
            return dao.getListaHelados(pref);
        }
    }
}
