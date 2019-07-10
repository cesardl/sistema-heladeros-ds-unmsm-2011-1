/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.dao;

import org.hibernate.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import pe.lamborgini.domain.mapping.Helado;
import pe.lamborgini.util.AppUtil;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Cesardl
 */
public class HeladoDAO {

    private static final Logger LOG = LoggerFactory.getLogger(HeladoDAO.class);

    public List<Helado> getListaHelados(String nombre) {
        Session session = AppUtil.getSessionFactory().getCurrentSession();
        Transaction tx = null;
        List<Helado> helados = null;
        try {
            tx = session.beginTransaction();

            Query query = session.createSQLQuery("SELECT id_helado, nombre_helado FROM helado "
                    + "WHERE nombre_helado LIKE :n_helado").
                    addScalar("id_helado", Hibernate.INTEGER).
                    addScalar("nombre_helado", Hibernate.STRING).
                    setString("n_helado", "%" + nombre + "%");

            List list = query.list();
            helados = new ArrayList<>();
            for (Object obj : list) {
                Object[] objs = (Object[]) obj;

                Helado h = new Helado();
                h.setIdHelado(AppUtil.aInteger(objs[0].toString()));
                h.setNombreHelado(objs[1].toString());
                helados.add(h);
            }
            tx.commit();
        } catch (HibernateException e) {
            LOG.error("HeladoDAO.getListaHeladosPorNombre", e);
            if (tx != null) {
                tx.rollback();
            }
        }
        return helados;
    }
}
