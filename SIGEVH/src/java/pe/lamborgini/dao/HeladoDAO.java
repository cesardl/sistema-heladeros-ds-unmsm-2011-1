/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.dao;

import java.util.ArrayList;
import java.util.List;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.Transaction;
import org.hibernate.classic.Session;
import org.hibernate.transaction.WebSphereExtendedJTATransactionLookup.TransactionManagerAdapter.TransactionAdapter;
import pe.lamborgini.domain.mapping.Helado;
import pe.lamborgini.util.AppUtil;

/**
 *
 * @author Cesardl
 */
public class HeladoDAO {

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

            List l = query.list();
            helados = new ArrayList<Helado>();
            for (int i = 0; i < l.size(); i++) {
                Object[] objs = (Object[]) l.get(i);

                Helado h = new Helado();
                h.setIdHelado(AppUtil.aInteger(objs[0].toString()));
                h.setNombreHelado(objs[1].toString());
                helados.add(h);
            }
            tx.commit();
        } catch (Exception e) {
            System.err.println("Error: HeladoDAO.getListaHeladosPorNombre " + e);
            if (tx != null) {
                tx.rollback();
            }
        }
        return helados;
    }
}
