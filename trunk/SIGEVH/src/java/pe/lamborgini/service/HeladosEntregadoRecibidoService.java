/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.service;

import pe.lamborgini.dao.HeladosEntregadoRecibidoDAO;
import pe.lamborgini.domain.mapping.HeladosEntregadoRecibido;

/**
 *
 * @author Cesardl
 */
public class HeladosEntregadoRecibidoService {

    public static void guardarHeladosEntregadoRecibido(HeladosEntregadoRecibido her) {
        new HeladosEntregadoRecibidoDAO().insertHeladosEntregadoRecibido(her);
    }
}
