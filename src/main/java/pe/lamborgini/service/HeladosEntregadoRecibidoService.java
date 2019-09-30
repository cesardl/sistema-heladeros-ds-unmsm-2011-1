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

    private static HeladosEntregadoRecibidoDAO dao = new HeladosEntregadoRecibidoDAO();

    private HeladosEntregadoRecibidoService() {
    }

    /**
     * Check if exist current daily assignation.
     *
     * @param iceCreamManId seller
     * @return an instance of <i>helados_entregado_recibido</i>
     */
    public static HeladosEntregadoRecibido existeAsignacionParaHeladero(final String iceCreamManId) {
        return dao.getHeladosEntregadoRecibido(AppUtil.aInteger(iceCreamManId));
    }

    public static boolean existePagoParaHeladero(final HeladosEntregadoRecibido her) {
        boolean hasPayment = false;
        for (DetalleHelado dh : her.getDetalleHelados()) {
            if (dh.getPagoHelado() != null) {
                hasPayment = true;
                break;
            }
        }
        return hasPayment;
    }

    /**
     * Only create a row in <i>helados_entregado_recibido</i> on daily assignation.
     *
     * @param iceCreamsDetail a list of ice creams
     * @param iceCreamMan     seller
     */
    public static void guardarHeladosEntregadoRecibido(final List<DetalleHelado> iceCreamsDetail, final String iceCreamMan) {
        // TODO revisar si hay stock

        HeladosEntregadoRecibido her = new HeladosEntregadoRecibido();

        Date currentDate = new Date();
        her.setFecha(currentDate);
        her.setCreatedAt(currentDate);
        her.setHeladero(new Heladero(AppUtil.aInteger(iceCreamMan)));

        for (DetalleHelado dh : iceCreamsDetail) {
            dh.setHeladosEntregadoRecibido(her);
        }
        her.setDetalleHelados(new HashSet<>(iceCreamsDetail));

        dao.insertHeladosEntregadoRecibido(her);
    }
}
