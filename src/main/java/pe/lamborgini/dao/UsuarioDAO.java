/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.lamborgini.dao;

import org.hibernate.Criteria;
import org.hibernate.classic.Session;
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

    public Usuario getUsuario(String nombre_usuario, String contrasenha) {
        Session session = AppUtil.getSessionFactory().openSession();
        Usuario usuario = null;
        try {
            Criteria c = session.createCriteria(Usuario.class).add(Restrictions.and(
                    Restrictions.eq("nombreUsuario", nombre_usuario),
                    Restrictions.eq("contrasenha", contrasenha)));

            usuario = (Usuario) c.uniqueResult();
        } catch (Exception e) {
            LOG.error("UsuarioDAO.getUsuario", e);
        } finally {
            session.close();
        }
        return usuario;
    }
}
