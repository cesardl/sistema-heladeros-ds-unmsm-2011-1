package pe.lamborgini.dao;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.query.Query;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import pe.lamborgini.domain.mapping.ContratoHeladero;
import pe.lamborgini.util.AppUtil;

public class ContratoHeladeroDAO {

    private static final Logger LOG = LoggerFactory.getLogger(ContratoHeladeroDAO.class);

    public ContratoHeladero findByIceCreamMan(final int iceCreamManId) {
        LOG.debug("DB query: contract");
        Session session = AppUtil.getSessionFactory().openSession();
        try {
            Query<ContratoHeladero> query = session.createQuery(
                    "from ContratoHeladero where heladero.idHeladero = :iceCreamManId",
                    ContratoHeladero.class);
            query.setParameter("iceCreamManId", iceCreamManId);

            return query.uniqueResult();
        } catch (HibernateException e) {
            LOG.error("ContratoHeladeroDAO.findByIceCreamMan", e);
            return null;
        } finally {
            session.close();
        }
    }
}
