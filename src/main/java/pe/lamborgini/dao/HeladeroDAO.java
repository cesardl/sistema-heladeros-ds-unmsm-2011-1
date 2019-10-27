/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.dao;

import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import pe.lamborgini.domain.mapping.Heladero;
import pe.lamborgini.util.AppUtil;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Cesardl
 */
public class HeladeroDAO {

    private static final Logger LOG = LoggerFactory.getLogger(HeladeroDAO.class);

    @SuppressWarnings("unchecked")
    public List<Heladero> getListaHeladeros(final String name, final String lastName, final int concessionaireId) {
        LOG.debug("DB query: name: '{}' | lastName: '{}' | concessionaireId: '{}'", name, lastName, concessionaireId);

        Session session = AppUtil.getSessionFactory().openSession();
        List<Heladero> heladeros = new ArrayList<>();
        try {
            Criteria c = session.createCriteria(Heladero.class)
                    .setFetchMode("heladosEntregadoRecibidos", FetchMode.JOIN);

            if (concessionaireId != 0) {
                c.add(Restrictions.eq("concesionario.idConcesionario", concessionaireId));
            }
            if (name.trim().length() != 0) {
                c.add(Restrictions.like("name", "%" + name + "%"));
            }
            if (lastName.trim().length() != 0) {
                c.add(Restrictions.like("lastName", "%" + lastName + "%"));
            }

            c.addOrder(Order.asc("lastName"));

            heladeros = c.list();
            LOG.debug("Getting {} rows from DB", heladeros.size());
        } catch (HibernateException e) {
            LOG.error(e.getMessage(), e);
        } finally {
            session.close();
        }
        return heladeros;
    }
}
