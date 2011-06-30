/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.dao;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.classic.Session;
import org.hibernate.criterion.Restrictions;
import pe.lamborgini.domain.mapping.Helado;
import pe.lamborgini.util.AppUtil;

/**
 *
 * @author Cesardl
 */
public class HeladoDAO {

    public List<Helado> getListaHelados(String nombre) {
        Session session = AppUtil.getSessionFactory().openSession();
        List<Helado> helados = null;
        try {
            Criteria c = session.createCriteria(Helado.class).
                    add(Restrictions.like("nombreHelado", "%" + nombre + "%"));

            helados = c.list();
        } catch (Exception e) {
            System.err.println("Error: HeladoDAO.getListaHeladosPorNombre " + e);
        } finally {
            session.close();
        }
        return helados;
    }
}
