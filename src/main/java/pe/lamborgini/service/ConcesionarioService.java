/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.service;

import pe.lamborgini.dao.ConcesionarioDAO;
import pe.lamborgini.domain.mapping.Concesionario;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * @author Cesardl
 */
public class ConcesionarioService {

    public static Collection<Concesionario> obtenerConcesionario() {
        ConcesionarioDAO dao = new ConcesionarioDAO();
        List<Concesionario> c = dao.getConcesionarios();
        if (c == null) {
            return new ArrayList<>(0);
        } else {
            return c;
        }
    }
}
