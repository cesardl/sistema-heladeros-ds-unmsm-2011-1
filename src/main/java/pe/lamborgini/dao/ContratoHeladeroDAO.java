package pe.lamborgini.dao;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
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
            Criteria c = session.createCriteria(ContratoHeladero.class)
                    .add(Restrictions.eq("heladero.idHeladero", iceCreamManId));

            return (ContratoHeladero) c.uniqueResult();
        } catch (HibernateException e) {
            LOG.error("ContratoHeladeroDAO.findByIceCreamMan", e);
            return null;
        } finally {
            session.close();
        }
    }
}
