/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.dao;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import pe.lamborgini.domain.mapping.Concesionario;
import pe.lamborgini.util.AppUtil;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Cesardl
 */
public class ConcesionarioDAO {

    private static final Logger LOG = LoggerFactory.getLogger(ConcesionarioDAO.class);

    public List<Concesionario> getConcesionarios() {
        Session session = AppUtil.getSessionFactory().openSession();
        List<Concesionario> concesionarios;
        try {
            Criteria c = session.createCriteria(Concesionario.class);

            concesionarios = new ArrayList<Concesionario>(c.list());
        } catch (Exception e) {
            LOG.error("ConcesionarioDAO.getConcesionarios", e);
            concesionarios = null;
        } finally {
            session.close();
        }
        return concesionarios;
    }
}
