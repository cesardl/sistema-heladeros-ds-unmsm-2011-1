/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.dao;

import jakarta.persistence.PersistenceException;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import pe.lamborgini.domain.mapping.Helado;
import pe.lamborgini.util.AppUtil;

import java.util.Arrays;
import java.util.List;

/**
 * @author Cesardl
 */
public class HeladoDAO {

    private static final Logger LOG = LoggerFactory.getLogger(HeladoDAO.class);

    public List<Helado> getAll(final Integer... ids) {
        LOG.debug("DB query: iceCreamName");
        Session session = AppUtil.getSessionFactory().openSession();
        try {
            String hql = "select h from Helado h left join fetch h.stockHelado ";
            if (ids.length > 0) {
                hql += "where h.idHelado in :ids ";
            }
            hql += "order by h.nombreHelado";

            Query<Helado> query = session.createQuery(hql, Helado.class);
            if (ids.length > 0) {
                query.setParameterList("ids", Arrays.asList(ids));
            }

            List<Helado> iceCreams = query.list();

            LOG.debug("Getting {} rows from DB", iceCreams.size());
            return iceCreams;
        } finally {
            session.close();
        }
    }

    public List<Helado> getListaHelados(final String iceCreamName) {
        LOG.debug("DB query: iceCreamName: '{}'", iceCreamName);
        Session session = AppUtil.getSessionFactory().openSession();
        try {
            Query<Helado> query = session.createQuery(
                    "from Helado where nombreHelado like :iceCreamName order by nombreHelado",
                    Helado.class);
            query.setParameter("iceCreamName", "%" + iceCreamName + "%");

            List<Helado> iceCreams = query.list();
            LOG.debug("Getting {} rows from DB", iceCreams.size());
            return iceCreams;
        } finally {
            session.close();
        }
    }

    public boolean save(final Helado iceCream) {
        LOG.debug("DB insert: iceCreamName: '{}'", iceCream.getNombreHelado());
        Session session = AppUtil.getSessionFactory().openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.persist(iceCream);
            tx.commit();
            LOG.info("DB saved entity '{}'", iceCream.getIdHelado());
            return true;
        } catch (final HibernateException e) {
            LOG.error(e.getMessage(), e);
            if (tx != null) {
                tx.rollback();
            }
            return false;
        } catch (final PersistenceException e) {
            LOG.error(e.getMessage(), e);
            if (tx != null) {
                tx.rollback();
            }
            return false;
        } finally {
            session.close();
        }
    }

    public boolean update(final Helado iceCream) {
        LOG.debug("DB update: iceCreamName: '{}'", iceCream.getNombreHelado());
        Session session = AppUtil.getSessionFactory().openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.merge(iceCream.getStockHelado());
            session.merge(iceCream);
            tx.commit();
            LOG.info("DB updated entity");
            return true;
        } catch (final HibernateException e) {
            LOG.error(e.getMessage(), e);
            if (tx != null) {
                tx.rollback();
            }
            return false;
        } catch (final PersistenceException e) {
            LOG.error(e.getMessage(), e);
            if (tx != null) {
                tx.rollback();
            }
            return false;
        } finally {
            session.close();
        }
    }

    public boolean delete(final Helado iceCream) {
        LOG.debug("DB delete: iceCreamName: '{}'", iceCream.getNombreHelado());
        Session session = AppUtil.getSessionFactory().openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.remove(session.contains(iceCream) ? iceCream : session.merge(iceCream));
            tx.commit();
            LOG.info("DB deleted entity");
            return true;
        } catch (final HibernateException e) {
            LOG.error(e.getMessage(), e);
            if (tx != null) {
                tx.rollback();
            }
            return false;
        } catch (final PersistenceException e) {
            LOG.error(e.getMessage(), e);
            if (tx != null) {
                tx.rollback();
            }
            return false;
        } finally {
            session.close();
        }
    }
}
