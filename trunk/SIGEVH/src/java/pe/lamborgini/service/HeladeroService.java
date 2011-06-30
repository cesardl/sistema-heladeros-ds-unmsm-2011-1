/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import pe.lamborgini.dao.HeladeroDAO;
import pe.lamborgini.domain.mapping.Heladero;

/**
 *
 * @author Cesardl
 */
public class HeladeroService {

    public static Collection<Heladero> obtenerHeladeros(String nombre, String apellido) {
        HeladeroDAO dao = new HeladeroDAO();
        List<Heladero> c = dao.getListaHeladeros(nombre, apellido);
        if (c == null) {
            return new ArrayList<Heladero>(0);
        } else {
            return c;
        }
    }
}
