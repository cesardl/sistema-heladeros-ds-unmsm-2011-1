/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.dao;

import org.hibernate.Transaction;
import org.hibernate.classic.Session;
import pe.lamborgini.domain.mapping.HeladosEntregadoRecibido;
import pe.lamborgini.util.AppUtil;

/**
 *
 * @author Cesardl
 */
public class HeladosEntregadoRecibidoDAO {

    public void insertHeladosEntregadoRecibido(HeladosEntregadoRecibido her) {
        Session session = AppUtil.getSessionFactory().openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(her);
            tx.commit();
        } catch (Exception e) {
            System.err.println("Error: HeladosEntregadoRecibidoDAO.insertHeladosEntregadoRecibido " + e);
            if (tx != null) {
                tx.rollback();
            }
        } finally {
            session.close();
        }
    }
}
