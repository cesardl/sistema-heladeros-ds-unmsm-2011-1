/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.dao;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import pe.lamborgini.domain.mapping.DetalleHelado;
import pe.lamborgini.util.AppUtil;

import java.util.List;

/**
 * @author Cesardl
 */
public class DetalleHeladoDAO {

    private static final Logger LOG = LoggerFactory.getLogger(DetalleHeladoDAO.class);

    public void updateManyDetalleHelado(final List<DetalleHelado> listaDetalleHelados) {
        Session session = AppUtil.getSessionFactory().openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            for (DetalleHelado dh : listaDetalleHelados) {
                session.merge(dh);
            }
            tx.commit();
        } catch (HibernateException e) {
            LOG.error("DetalleHeladoDAO.updateManyDetalleHelado", e);
            if (tx != null) {
                tx.rollback();
            }
        } finally {
            session.close();
        }
    }

    public DetalleHelado getDetalleHeladoAnterior(final String iceCreamManId, final int iceCreamId) {
        LOG.debug("DB query: iceCreamManId: '{}' | iceCreamId: '{}'", iceCreamManId, iceCreamId);
        Session session = AppUtil.getSessionFactory().openSession();
        DetalleHelado dh;
        try {
            Query<DetalleHelado> query = session.createQuery(
                    "select dh from DetalleHelado dh " +
                            "join dh.heladosEntregadoRecibido her " +
                            "where her.heladero.idHeladero = :iceCreamManId " +
                            "and her.fecha = :previousDate " +
                            "and dh.helado.idHelado = :iceCreamId",
                    DetalleHelado.class);
            query.setParameter("iceCreamManId", AppUtil.aInteger(iceCreamManId));
            query.setParameter("previousDate", AppUtil.calcularFechaAnterior());
            query.setParameter("iceCreamId", iceCreamId);

            dh = query.uniqueResult();
        } catch (HibernateException e) {
            LOG.error("DetalleHeladoDAO.getDetalleHeladoAnterior", e);
            dh = null;
        } finally {
            session.close();
        }
        return dh;
    }
}
