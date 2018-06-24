/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.service;

import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
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

    public static HeladosEntregadoRecibido existeAsignacionParaHeladero(String p_id_heladero) {
        HeladosEntregadoRecibido her =
                new HeladosEntregadoRecibidoDAO().getHeladosEntregadoRecibido(
                AppUtil.aInteger(p_id_heladero));

        return her;
    }

    public static boolean existePagoParaHeladero(HeladosEntregadoRecibido her) {
        boolean tiene_pago = false;
        Iterator<DetalleHelado> it = her.getDetalleHelados().iterator();
        while (it.hasNext()) {
            DetalleHelado dh = it.next();
            if (dh.getPagoHelado() != null) {
                tiene_pago = true;
                break;
            }
        }
        return tiene_pago;
    }

    public static void guardarHeladosEntregadoRecibido(List<DetalleHelado> listaDetalleHelados, String p_id_heladero) {
        HeladosEntregadoRecibido her = new HeladosEntregadoRecibido();

        her.setFecha(new Date());
        her.setHeladero(new Heladero(AppUtil.aInteger(p_id_heladero)));

        double total = 0;

        for (int i = 0; i < listaDetalleHelados.size(); i++) {
            DetalleHelado dh = listaDetalleHelados.get(i);
            dh.setCantEntregada(dh.getCantPendiente() + dh.getCantEntregada());
            dh.setHeladosEntregadoRecibido(her);
            total = total + dh.getCantEntregada();
        }
        her.setDetalleHelados(new HashSet<DetalleHelado>(listaDetalleHelados));
        her.setTotal(total);

        HeladosEntregadoRecibidoDAO dao = new HeladosEntregadoRecibidoDAO();
        dao.insertHeladosEntregadoRecibido(her);
    }
}