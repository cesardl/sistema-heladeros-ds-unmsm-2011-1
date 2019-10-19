/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.dao;

import org.hibernate.*;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import pe.lamborgini.domain.mapping.Helado;
import pe.lamborgini.util.AppUtil;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @author Cesardl
 */
public class HeladoDAO {

    private static final Logger LOG = LoggerFactory.getLogger(HeladoDAO.class);

    @SuppressWarnings("unchecked")
    public List<Helado> getAll(final Integer... ids) {
        LOG.debug("DB query: iceCreamName");
        Session session = AppUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();

        Criteria criteria = session.createCriteria(Helado.class)
                .setFetchMode("stockHelado", FetchMode.JOIN)
                .addOrder(Order.asc("nombreHelado"));

        if (ids.length > 0) {
            criteria.add(Restrictions.in("idHelado", Arrays.asList(ids)));
        }

        List<Helado> iceCreams = criteria.list();

        LOG.debug("Getting {} rows from DB", iceCreams.size());
        tx.commit();
        return iceCreams;
    }

    public List<Helado> getListaHelados(final String iceCreamName) {
        LOG.debug("DB query: iceCreamName: '{}'", iceCreamName);
        Session session = AppUtil.getSessionFactory().getCurrentSession();
        Transaction tx = session.beginTransaction();
        List<Helado> iceCreams = new ArrayList<>();

        Query query = session.createSQLQuery("SELECT id_helado, nombre_helado FROM helado "
                + "WHERE nombre_helado LIKE :n_helado").
                addScalar("id_helado", Hibernate.INTEGER).
                addScalar("nombre_helado", Hibernate.STRING).
                setString("n_helado", "%" + iceCreamName + "%");

        List list = query.list();
        LOG.debug("Getting {} rows from DB", list.size());
        for (Object obj : list) {
            Object[] objs = (Object[]) obj;

            Helado h = new Helado();
            h.setIdHelado(AppUtil.aInteger(objs[0].toString()));
            h.setNombreHelado(objs[1].toString());
            iceCreams.add(h);
        }
        tx.commit();
        return iceCreams;
    }

    public boolean save(final Helado iceCream) {
        LOG.debug("DB insert: iceCreamName: '{}'", iceCream.getNombreHelado());
        Session session = AppUtil.getSessionFactory().openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Serializable saved = session.save(iceCream);
            tx.commit();
            LOG.info("DB saved entity '{}'", saved);
            return true;
        } catch (final HibernateException e) {
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
            session.update(iceCream);
            tx.commit();
            LOG.info("DB updated entity");
            return true;
        } catch (final HibernateException e) {
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
            session.delete(iceCream);
            tx.commit();
            LOG.info("DB deleted entity");
            return true;
        } catch (final HibernateException e) {
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
