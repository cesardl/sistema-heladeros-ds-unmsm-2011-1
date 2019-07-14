/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.dao;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
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
    public List<Concesionario> getConcesionarios() {
        LOG.debug("DB query");
        Session session = AppUtil.getSessionFactory().openSession();
        List<Concesionario> concesionarios;
        try {
            Criteria c = session.createCriteria(Concesionario.class);

            concesionarios = c.list();
            LOG.debug("Getting {} rows from DB", concesionarios.size());
        } catch (HibernateException e) {
            LOG.error("ConcesionarioDAO.getConcesionarios", e);
            concesionarios = Collections.emptyList();
        } finally {
            session.close();
        }
        return concesionarios;
    }
}
