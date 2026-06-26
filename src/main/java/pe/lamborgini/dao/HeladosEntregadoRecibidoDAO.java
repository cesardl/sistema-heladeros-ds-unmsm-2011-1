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
import pe.lamborgini.domain.mapping.HeladosEntregadoRecibido;
import pe.lamborgini.util.AppUtil;

import java.util.List;

/**
 * @author Cesardl
 */
public class HeladosEntregadoRecibidoDAO {

    private static final Logger LOG = LoggerFactory.getLogger(HeladosEntregadoRecibidoDAO.class);

    public List<HeladosEntregadoRecibido> getHeladosEntregadoRecibido(final int iceCreamManId) {
        LOG.debug("DB query: iceCreamManId: '{}'", iceCreamManId);
        Session session = AppUtil.getSessionFactory().openSession();
        try {
            Query<HeladosEntregadoRecibido> query = session.createQuery(
                    "from HeladosEntregadoRecibido " +
                            "where heladero.idHeladero = :iceCreamManId and fecha = current_date " +
                            "order by idHeladosEntregadoRecibido desc",
                    HeladosEntregadoRecibido.class);
            query.setParameter("iceCreamManId", iceCreamManId);

            return query.list();
        } catch (HibernateException e) {
            LOG.error("HeladosEntregadoRecibidoDAO.getHeladosEntregadoRecibido", e);
            throw e;
        } finally {
            session.close();
        }
    }

    public void insertHeladosEntregadoRecibido(final HeladosEntregadoRecibido her) {
        Session session = AppUtil.getSessionFactory().openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.persist(her);
            tx.commit();
        } catch (HibernateException e) {
            LOG.error("HeladosEntregadoRecibidoDAO.insertHeladosEntregadoRecibido", e);
            if (tx != null) {
                tx.rollback();
            }
        } finally {
            session.close();
        }
    }
}
