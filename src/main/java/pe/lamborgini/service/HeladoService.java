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

    private static HeladoDAO dao = new HeladoDAO();

    private HeladoService() {
    }

    public static List<Helado> getAllIceCreams() {
        return dao.getAll();
    }

    public static List<Helado> obtenerHeladoPorNombre(final String pref) {
        if (pref == null || "null".equals(pref)) {
            return Collections.emptyList();
        } else {
            return dao.getListaHelados(pref);
        }
    }
}
