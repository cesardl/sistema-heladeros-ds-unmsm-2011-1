package pe.lamborgini.dao;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import pe.lamborgini.domain.mapping.StockHelado;
import pe.lamborgini.util.AppUtil;

import java.util.List;

/**
 * Created on 09/10/2019.
 *
 * @author Cesardl
 */
public class StockHeladoDAO {

    private static final Logger LOG = LoggerFactory.getLogger(StockHeladoDAO.class);

    public boolean update(final List<StockHelado> stocks) {
        LOG.debug("DB update: iceCreamsStock");
        Session session = AppUtil.getSessionFactory().openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            for (StockHelado stock : stocks) {
                session.update(stock);
            }
            tx.commit();
            LOG.info("DB updated entity");
            return true;
        } catch (final HibernateException e) {
            LOG.error(e.getMessage(), e);
            if (tx != null) {
                tx.rollback();
            }
            return false;
        } finally {
            session.close();
        }
    }
}
