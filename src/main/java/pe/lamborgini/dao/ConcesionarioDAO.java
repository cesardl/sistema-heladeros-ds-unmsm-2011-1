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
import pe.lamborgini.domain.mapping.Concesionario;
import pe.lamborgini.util.AppUtil;

import java.util.Collections;
import java.util.List;

/**
 * @author Cesardl
 */
public class ConcesionarioDAO {

    private static final Logger LOG = LoggerFactory.getLogger(ConcesionarioDAO.class);

    public List<Concesionario> listConcessionaires() {
        LOG.debug("DB query: concessionaires");
        Session session = AppUtil.getSessionFactory().openSession();
        List<Concesionario> concessionaires;
        try {
            Query<Concesionario> query = session.createQuery(
                    "from Concesionario where idConcesionario <> :id", Concesionario.class);
            query.setParameter("id", 1);

            concessionaires = query.list();
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
