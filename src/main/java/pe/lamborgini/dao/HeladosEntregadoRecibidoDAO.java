/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.dao;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import pe.lamborgini.domain.mapping.HeladosEntregadoRecibido;
import pe.lamborgini.util.AppUtil;

import java.util.Date;

/**
 * @author Cesardl
 */
public class HeladosEntregadoRecibidoDAO {

    private static final Logger LOG = LoggerFactory.getLogger(HeladosEntregadoRecibidoDAO.class);

    public HeladosEntregadoRecibido getHeladosEntregadoRecibido(final int iceCreamManId) {
        LOG.debug("DB query: iceCreamManId: '{}'", iceCreamManId);
        Session session = AppUtil.getSessionFactory().openSession();
        Transaction tx = null;
        HeladosEntregadoRecibido her = null;
        try {
            tx = session.beginTransaction();
            Criteria c = session.createCriteria(HeladosEntregadoRecibido.class).
                    add(Restrictions.eq("heladero.idHeladero", iceCreamManId)).
                    add(Restrictions.eq("fecha", new Date()));

            her = (HeladosEntregadoRecibido) c.uniqueResult();
            tx.commit();
        } catch (HibernateException e) {
            LOG.error("HeladosEntregadoRecibidoDAO.getHeladosEntregadoRecibido", e);
            if (tx != null) {
                tx.rollback();
            }
        } finally {
            session.close();
        }
        return her;
    }

    public void insertHeladosEntregadoRecibido(final HeladosEntregadoRecibido her) {
        Session session = AppUtil.getSessionFactory().openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(her);
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
