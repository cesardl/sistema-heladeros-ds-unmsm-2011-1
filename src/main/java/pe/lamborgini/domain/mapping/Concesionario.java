package pe.lamborgini.domain.mapping;
// Generated 29/06/2011 07:47:21 PM by Hibernate Tools 3.2.1.GA

import java.util.HashSet;
import java.util.Set;

/**
 * Concesionario generated by hbm2java
 *
 * @author Cesardl
 */
public class Concesionario implements java.io.Serializable {

    private static final long serialVersionUID = -1874907810652432154L;

    private Integer idConcesionario;
    private String nombreConces;
    private String distrito;
    private String propietario;
    private Set<Usuario> usuarios = new HashSet<>(0);
    private Set<Heladero> heladeros = new HashSet<>(0);

    public Concesionario() {
    }

    public Concesionario(String nombreConces, String distrito, String propietario) {
        this.nombreConces = nombreConces;
        this.distrito = distrito;
        this.propietario = propietario;
    }

    public Concesionario(String nombreConces, String distrito, String propietario, Set<Usuario> usuarios, Set<Heladero> heladeros) {
        this.nombreConces = nombreConces;
        this.distrito = distrito;
        this.propietario = propietario;
        this.usuarios = usuarios;
        this.heladeros = heladeros;
    }

    public Integer getIdConcesionario() {
        return this.idConcesionario;
    }

    public void setIdConcesionario(Integer idConcesionario) {
        this.idConcesionario = idConcesionario;
    }

    public String getNombreConces() {
        return this.nombreConces;
    }

    public void setNombreConces(String nombreConces) {
        this.nombreConces = nombreConces;
    }

    public String getDistrito() {
        return this.distrito;
    }

    public void setDistrito(String distrito) {
        this.distrito = distrito;
    }

    public String getPropietario() {
        return this.propietario;
    }

    public void setPropietario(String propietario) {
        this.propietario = propietario;
    }

    public Set<Usuario> getUsuarios() {
        return this.usuarios;
    }

    public void setUsuarios(Set<Usuario> usuarios) {
        this.usuarios = usuarios;
    }

    public Set<Heladero> getHeladeros() {
        return this.heladeros;
    }

    public void setHeladeros(Set<Heladero> heladeros) {
        this.heladeros = heladeros;
    }
}
