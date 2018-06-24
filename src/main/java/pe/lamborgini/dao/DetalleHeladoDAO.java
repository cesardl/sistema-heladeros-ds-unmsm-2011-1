/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.dao;

import org.hibernate.Criteria;
import org.hibernate.Transaction;
import org.hibernate.classic.Session;
import org.hibernate.criterion.Restrictions;
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

    public void updateManyDetalleHelado(List<DetalleHelado> listaDetalleHelados) {
        Session session = AppUtil.getSessionFactory().openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            for (DetalleHelado dh : listaDetalleHelados) {
                session.update(dh);
            }
            tx.commit();
        } catch (Exception e) {
            LOG.error("DetalleHeladoDAO.updateManyDetalleHelado", e);
            if (tx != null) {
                tx.rollback();
            }
        } finally {
            session.close();
        }
    }

    public DetalleHelado getDetalleHeladoAnterior(String id_heladero, int id_helado) {
        Session session = AppUtil.getSessionFactory().openSession();
        DetalleHelado dh;
        try {
            Criteria c = session.createCriteria(DetalleHelado.class, "dh").
                    createCriteria("dh.heladosEntregadoRecibido", "her").
                    add(Restrictions.eq("her.heladero.idHeladero", AppUtil.aInteger(id_heladero))).
                    add(Restrictions.eq("her.fecha", AppUtil.calcularFechaAnterior())).
                    add(Restrictions.eq("dh.helado.idHelado", id_helado));

            dh = (DetalleHelado) c.uniqueResult();
        } catch (Exception e) {
            LOG.error("DetalleHeladoDAO.getDetalleHeladoAnterior", e);
            dh = null;
        } finally {
            session.close();
        }
        return dh;
    }
}
