/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.dao;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import pe.lamborgini.domain.mapping.Heladero;
import pe.lamborgini.util.AppUtil;

/**
 *
 * @author Cesardl
 */
public class HeladeroDAO {

    public List<Heladero> getListaHeladeros(String nombre, String apellido, int id_usuario) {
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
        } catch (Exception e) {
            System.err.println("Error: HeladeroDAO.getListaHeladeros " + e);
        } finally {
            session.close();
        }
        return heladeros;
    }
}
