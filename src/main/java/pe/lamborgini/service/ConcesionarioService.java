/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.service;

import pe.lamborgini.dao.ConcesionarioDAO;
import pe.lamborgini.domain.mapping.Concesionario;

import java.util.Collection;

/**
 * @author Cesardl
 */
public final class ConcesionarioService {

    private ConcesionarioService() {
    }

    public static Collection<Concesionario> obtenerConcesionario() {
        ConcesionarioDAO dao = new ConcesionarioDAO();
        return dao.getConcesionarios();
    }
}
