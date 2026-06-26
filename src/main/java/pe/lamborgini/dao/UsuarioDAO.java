/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.dao;

import org.hibernate.Session;
import org.hibernate.query.Query;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import pe.lamborgini.domain.mapping.Usuario;
import pe.lamborgini.util.AppUtil;

import java.util.List;

/**
 * @author Cesardl
 */
public class UsuarioDAO {

    private static final Logger LOG = LoggerFactory.getLogger(UsuarioDAO.class);

    public Usuario getUsuario(final String userName, final String password) {
        LOG.debug("DB query: userName: '{}' | password: '{}'", userName, password);
        Session session = AppUtil.getSessionFactory().openSession();
        try {
            Query<Usuario> query = session.createQuery(
                    "from Usuario where nombreUsuario = :userName and contrasenha = :password",
                    Usuario.class);
            query.setParameter("userName", userName);
            query.setParameter("password", password);

            return query.uniqueResult();
        } finally {
            session.close();
        }
    }

    public List<Usuario> findByConcessionaire(final int userId, final int concessionaireId) {
        LOG.debug("DB query: userId:{} | concessionaireId: '{}'", userId, concessionaireId);
        Session session = AppUtil.getSessionFactory().openSession();
        try {
            StringBuilder hql = new StringBuilder("from Usuario where idUsuario <> :userId ");

            if (concessionaireId != 0) {
                hql.append("and concesionario.idConcesionario = :concessionaireId ");
            }

            Query<Usuario> query = session.createQuery(hql.toString(), Usuario.class);
            query.setParameter("userId", userId);
            if (concessionaireId != 0) {
                query.setParameter("concessionaireId", concessionaireId);
            }

            return query.list();
        } finally {
            session.close();
        }
    }
}
