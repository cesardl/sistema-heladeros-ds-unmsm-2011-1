/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.service;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import pe.lamborgini.dao.HeladosEntregadoRecibidoDAO;
import pe.lamborgini.domain.mapping.DetalleHelado;
import pe.lamborgini.domain.mapping.Heladero;
import pe.lamborgini.domain.mapping.HeladosEntregadoRecibido;
import pe.lamborgini.util.AppUtil;

/**
 *
 * @author Cesardl
 */
public class HeladosEntregadoRecibidoService {

    public static void guardarHeladosEntregadoRecibido(List<DetalleHelado> listaDetalleHelados, String id_heladero) {
        HeladosEntregadoRecibido her = new HeladosEntregadoRecibido();

        her.setFecha(new Date());
        her.setHeladero(new Heladero(AppUtil.aInteger(id_heladero)));

        double total = 0;

        for (int i = 0; i < listaDetalleHelados.size(); i++) {
            DetalleHelado dh = listaDetalleHelados.get(i);
            dh.setHeladosEntregadoRecibido(her);
            total = total + dh.getCantEntregada();
        }
        her.setDetalleHelados(new HashSet<DetalleHelado>(listaDetalleHelados));
        her.setTotal(total);

        System.out.println("total : " + total + "-" + listaDetalleHelados.size());

        new HeladosEntregadoRecibidoDAO().insertHeladosEntregadoRecibido(her);
    }
}
