/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.dao;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import pe.lamborgini.domain.mapping.Concesionario;
import pe.lamborgini.util.AppUtil;

import java.util.Collections;
import java.util.List;

/**
 * @author Cesardl
 */
public class ConcesionarioDAO {

    private static final Logger LOG = LoggerFactory.getLogger(ConcesionarioDAO.class);

    @SuppressWarnings("unchecked")
    public List<Concesionario> listConcessionaires() {
        LOG.debug("DB query: concessionaires");
        Session session = AppUtil.getSessionFactory().openSession();
        List<Concesionario> concessionaires;
        try {
            Criteria c = session.createCriteria(Concesionario.class)
                    .add(Restrictions.ne("idConcesionario", 1));

            concessionaires = c.list();
            LOG.debug("Getting {} rows from DB", concessionaires.size());
        } catch (HibernateException e) {
            LOG.error("ConcesionarioDAO.getConcesionarios", e);
            concessionaires = Collections.emptyList();
        } finally {
            session.close();
        }
        return concessionaires;
    }
}
