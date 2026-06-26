/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.dao;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.query.Query;
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

    public List<Heladero> getListaHeladeros(final String name, final String lastName, final int concessionaireId) {
        LOG.debug("DB query: name: '{}' | lastName: '{}' | concessionaireId: '{}'", name, lastName, concessionaireId);

        Session session = AppUtil.getSessionFactory().openSession();
        List<Heladero> heladeros = new ArrayList<>();
        try {
            StringBuilder hql = new StringBuilder("select distinct h from Heladero h ")
                    .append("left join fetch h.heladosEntregadoRecibidos ")
                    .append("where 1 = 1 ");

            if (concessionaireId != 0) {
                hql.append("and h.concessionaire.idConcesionario = :concessionaireId ");
            }
            if (name.trim().length() != 0) {
                hql.append("and h.name like :name ");
            }
            if (lastName.trim().length() != 0) {
                hql.append("and h.lastName like :lastName ");
            }
            hql.append("order by h.lastName");

            Query<Heladero> query = session.createQuery(hql.toString(), Heladero.class);
            if (concessionaireId != 0) {
                query.setParameter("concessionaireId", concessionaireId);
            }
            if (name.trim().length() != 0) {
                query.setParameter("name", "%" + name + "%");
            }
            if (lastName.trim().length() != 0) {
                query.setParameter("lastName", "%" + lastName + "%");
            }

            heladeros = query.list();
            LOG.debug("Getting {} rows from DB", heladeros.size());
        } catch (HibernateException e) {
            LOG.error(e.getMessage(), e);
        } finally {
            session.close();
        }
        return heladeros;
    }
}
