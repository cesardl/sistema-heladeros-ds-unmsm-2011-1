/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.service;

import pe.lamborgini.dao.HeladosEntregadoRecibidoDAO;
import pe.lamborgini.domain.mapping.DetalleHelado;
import pe.lamborgini.domain.mapping.Heladero;
import pe.lamborgini.domain.mapping.HeladosEntregadoRecibido;
import pe.lamborgini.util.AppUtil;

import java.util.Date;
import java.util.HashSet;
import java.util.List;

/**
 * @author Cesardl
 */
public final class HeladosEntregadoRecibidoService {

    private HeladosEntregadoRecibidoService() {
    }

    public static HeladosEntregadoRecibido existeAsignacionParaHeladero(String p_id_heladero) {
        return new HeladosEntregadoRecibidoDAO().getHeladosEntregadoRecibido(
                AppUtil.aInteger(p_id_heladero));
    }

    public static boolean existePagoParaHeladero(HeladosEntregadoRecibido her) {
        boolean tiene_pago = false;
        for (DetalleHelado dh : her.getDetalleHelados()) {
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

        for (DetalleHelado dh : listaDetalleHelados) {
            dh.setCantEntregada(dh.getCantPendiente() + dh.getCantEntregada());
            dh.setHeladosEntregadoRecibido(her);
            total = total + dh.getCantEntregada();
        }
        her.setDetalleHelados(new HashSet<>(listaDetalleHelados));
        her.setTotal(total);

        HeladosEntregadoRecibidoDAO dao = new HeladosEntregadoRecibidoDAO();
        dao.insertHeladosEntregadoRecibido(her);
    }
}
