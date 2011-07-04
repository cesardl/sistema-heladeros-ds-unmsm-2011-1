/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.service;

import java.util.Date;
import java.util.List;
import pe.lamborgini.dao.DetalleHeladoDAO;
import pe.lamborgini.domain.mapping.Concepto;
import pe.lamborgini.domain.mapping.DetalleHelado;
import pe.lamborgini.domain.mapping.Factura;
import pe.lamborgini.domain.mapping.PagoHelado;
import pe.lamborgini.util.AppUtil;

/**
 *
 * @author Cesardl
 */
public class DetalleHeladoService {

    public static int calcularHeladosPendientes(String id_heladero, int id_helado) {
        DetalleHelado dh = new DetalleHeladoDAO().getDetalleHeladoAnterior(id_heladero, id_helado);
        if (dh == null) {
            return 0;
        } else {
            System.out.println("a la fecha " + AppUtil.calcularFechaAnterior());
            System.out.println("sobro " + dh.getCantDevuelta());
            return dh.getCantDevuelta();
        }
    }

    public static boolean validarListaDeEntrega(List<DetalleHelado> listaDetalleHelados) {
        for (int i = 0; i < listaDetalleHelados.size(); i++) {
            DetalleHelado dh = listaDetalleHelados.get(i);
            int cd = AppUtil.aInteger(dh.getStrCantDevuelta());
            int ce = dh.getCantEntregada();
            if (cd > ce || cd == AppUtil.ERROR || cd == 0) {
                return false;
            } else {
                dh.setCantDevuelta(cd);
                dh.setCantVendida(ce - cd);
            }
        }
        return true;
    }

    public static void actualizarEntregaHelados(List<DetalleHelado> listaDetalleHelados,
            String id_heladero) {

        double pago = 0;
        Factura factura = new Factura();
        factura.setNumeroFactura(AppUtil.random());
        factura.setDescripcion("Venta de helados a fecha " + AppUtil.dateWithFormat(new Date()));
        factura.setFecha(new Date());
        factura.setNumeroFactura(AppUtil.random() * 100);
        for (int i = 0; i < listaDetalleHelados.size(); i++) {
            DetalleHelado detalleHelado = listaDetalleHelados.get(i);

            double cantidad_pagada = detalleHelado.getHelado().getPrecio()
                    * detalleHelado.getCantVendida();

            pago = pago + cantidad_pagada;
            PagoHelado ph = new PagoHelado();
            ph.setCantPagada(cantidad_pagada);
            ph.setConcepto(new Concepto(1));

            ph.setFactura(factura);

            detalleHelado.setPagoHelado(ph);
        }
        factura.setPago(pago);
        new DetalleHeladoDAO().updateManyDetalleHelado(listaDetalleHelados);
    }
}
