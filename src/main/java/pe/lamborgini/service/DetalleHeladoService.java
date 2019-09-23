/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import pe.lamborgini.dao.DetalleHeladoDAO;
import pe.lamborgini.domain.mapping.Concepto;
import pe.lamborgini.domain.mapping.DetalleHelado;
import pe.lamborgini.domain.mapping.Factura;
import pe.lamborgini.domain.mapping.PagoHelado;
import pe.lamborgini.util.AppUtil;

import java.util.Date;
import java.util.List;

/**
 * @author Cesardl
 */
public final class DetalleHeladoService {

    private static final Logger LOG = LoggerFactory.getLogger(DetalleHeladoService.class);

    private DetalleHeladoService() {
    }

    public static int calcularHeladosPendientes(final String iceCreamManId, final int iceCreamId) {
        DetalleHelado dh = new DetalleHeladoDAO().getDetalleHeladoAnterior(iceCreamManId, iceCreamId);
        if (dh == null) {
            LOG.warn("Ice cream detail not found");
            return 0;
        } else {
            LOG.debug("A la fecha {} sobro {}", AppUtil.calcularFechaAnterior(), dh.getCantDevuelta());
            return dh.getCantDevuelta();
        }
    }

    public static boolean validarListaDeEntrega(List<DetalleHelado> listaDetalleHelados) {
        for (DetalleHelado dh : listaDetalleHelados) {
            int cd = AppUtil.aInteger(dh.getStrCantDevuelta());
            int ce = dh.getCantEntregada();
            if (cd > ce || cd == AppUtil.ERROR) {
                return false;
            } else {
                dh.setCantDevuelta(cd);
                dh.setCantVendida(ce - cd);
            }
        }
        return true;
    }

    public static void actualizarEntregaHelados(List<DetalleHelado> listaDetalleHelados, String iceCreamManId) {
        double pago = 0;
        Factura factura = new Factura();
        factura.setDescripcion("Venta de helados a fecha " + AppUtil.dateWithFormat(new Date()));
        factura.setFecha(new Date());
        factura.setNumeroFactura(AppUtil.random() * 100);
        for (DetalleHelado detalleHelado : listaDetalleHelados) {
            double paidAmount = detalleHelado.getHelado().getPrecio() * detalleHelado.getCantVendida();

            pago = pago + paidAmount;
            PagoHelado ph = new PagoHelado();
            ph.setCantPagada(paidAmount);
            ph.setConcepto(new Concepto(1));

            ph.setFactura(factura);

            detalleHelado.setPagoHelado(ph);
        }
        factura.setPago(pago);
        new DetalleHeladoDAO().updateManyDetalleHelado(listaDetalleHelados);
    }
}
