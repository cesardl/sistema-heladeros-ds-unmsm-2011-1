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
import pe.lamborgini.domain.mapping.Heladero;
import pe.lamborgini.util.AppUtil;

import java.util.List;

/**
 * @author Cesardl
 */
public class HeladeroDAO {

    private static final Logger LOG = LoggerFactory.getLogger(HeladeroDAO.class);

    @SuppressWarnings("unchecked")
    public List<Heladero> getListaHeladeros(final String nombre, final String apellido, final int id_usuario) {
        Session session = AppUtil.getSessionFactory().openSession();
        List<Heladero> heladeros = null;
        try {
            Criteria c = session.createCriteria(Heladero.class).
                    add(Restrictions.eq("concesionario.idConcesionario", id_usuario));
            if (nombre.trim().length() != 0) {
                c.add(Restrictions.like("nombres", "%" + nombre + "%"));
            }
            if (apellido.trim().length() != 0) {
                c.add(Restrictions.like("apellidos", "%" + apellido + "%"));
            }
            heladeros = c.list();
            LOG.info("Busqueda de heladeros {}", heladeros.size());
        } catch (HibernateException e) {
            LOG.error(e.getMessage(), e);
        } finally {
            session.close();
        }
        return heladeros;
    }
}
