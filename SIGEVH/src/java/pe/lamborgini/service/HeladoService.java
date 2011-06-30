/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.service;

import java.util.List;
import pe.lamborgini.dao.HeladoDAO;
import pe.lamborgini.domain.mapping.Helado;

/**
 *
 * @author Cesardl
 */
public class HeladoService {

    public static List<Helado> obtenerHeladoPorNombre(String pref) {
        HeladoDAO dao = new HeladoDAO();
        return dao.getListaHelados(pref);
    }
}
