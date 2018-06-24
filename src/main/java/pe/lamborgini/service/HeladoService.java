/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.service;

import pe.lamborgini.dao.HeladoDAO;
import pe.lamborgini.domain.mapping.Helado;

import java.util.List;

/**
 * @author Cesardl
 */
public class HeladoService {

    public static List<Helado> obtenerHeladoPorNombre(String pref) {
        HeladoDAO dao = new HeladoDAO();
        return dao.getListaHelados(pref);
    }
}
