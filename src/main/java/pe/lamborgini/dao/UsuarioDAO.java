/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.dao;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import pe.lamborgini.domain.mapping.Usuario;
import pe.lamborgini.util.AppUtil;

/**
 * @author Cesardl
 */
public class UsuarioDAO {

    private static final Logger LOG = LoggerFactory.getLogger(UsuarioDAO.class);

    public Usuario getUsuario(final String userName, final String password) {
        LOG.debug("DB query: userName: '{}' | password: '{}'", userName, password);
        Session session = AppUtil.getSessionFactory().openSession();
        try {
            Criteria c = session.createCriteria(Usuario.class)
                    .add(Restrictions.and(
                            Restrictions.eq("nombreUsuario", userName),
                            Restrictions.eq("contrasenha", password)));

            return (Usuario) c.uniqueResult();
        } finally {
            session.close();
        }
    }
}
