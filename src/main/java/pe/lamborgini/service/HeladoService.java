/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.service;

import pe.lamborgini.dao.HeladoDAO;
import pe.lamborgini.dao.StockHeladoDAO;
import pe.lamborgini.domain.mapping.DetalleHelado;
import pe.lamborgini.domain.mapping.Helado;
import pe.lamborgini.domain.mapping.StockHelado;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author Cesardl
 */
public final class HeladoService {

    private static HeladoDAO dao = new HeladoDAO();

    private HeladoService() {
    }

    public static List<Helado> getAllIceCreams() {
        return dao.getAll();
    }

    public static List<Helado> obtenerHeladoPorNombre(final String pref) {
        if (pref == null || "null".equals(pref)) {
            return Collections.emptyList();
        } else {
            return dao.getListaHelados(pref);
        }
    }

    public static boolean saveOrUpdate(final Helado iceCream) {
        if (iceCream.getIdHelado() == null) {
            iceCream.getStockHelado().setCreatedAt(new Date());
            return dao.save(iceCream);
        } else {
            return dao.update(iceCream);
        }
    }

    public static boolean delete(final Helado iceCream) {
        return dao.delete(iceCream);
    }

    private static List<Helado> findIceCreamsToAssign(final List<DetalleHelado> iceCreamDetailsList) {
        Integer[] collect = iceCreamDetailsList.stream()
                .map(icd -> icd.getHelado().getIdHelado())
                .toArray(Integer[]::new);

        return dao.getAll(collect);
    }

    public static List<DetalleHelado> checkAvailableStock(final List<DetalleHelado> iceCreamDetailsList) {
        List<Helado> iceCreamsToAssign = findIceCreamsToAssign(iceCreamDetailsList);

        List<DetalleHelado> iceCreamWithoutStock = new ArrayList<>();

        for (DetalleHelado iceCreamDetail : iceCreamDetailsList) {
            for (Helado helado : iceCreamsToAssign) {
                if (iceCreamDetail.getHelado().getIdHelado().equals(helado.getIdHelado())) {
                    int quantityInStock = helado.getStockHelado().getCantidad();
                    int quantityAssigned = iceCreamDetail.getCantEntregada();
                    int updatedStock = quantityInStock - quantityAssigned;

                    if (updatedStock < 0) {
                        iceCreamWithoutStock.add(iceCreamDetail);
                    } else {
                        helado.getStockHelado().setCantidad(updatedStock);

                        iceCreamDetail.setHelado(helado);
                        iceCreamDetail.setHasStock(true);
                    }

                    break;
                }
            }
        }
        return iceCreamWithoutStock;
    }

    public static boolean updateStock(final List<DetalleHelado> iceCreamDetailsList) {
        Date lastModified = new Date();

        List<StockHelado> stockToUpdate = iceCreamDetailsList.stream()
                .filter(DetalleHelado::isHasStock)
                .map(icd -> {
                    icd.getHelado().getStockHelado().setLastModified(lastModified);
                    return icd.getHelado().getStockHelado();
                })
                .collect(Collectors.toList());

        return new StockHeladoDAO().update(stockToUpdate);
    }
}
