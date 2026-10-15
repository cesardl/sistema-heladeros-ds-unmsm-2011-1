package pe.lamborgini.domain.mapping;

import jakarta.persistence.*;

import java.util.HashSet;
import java.util.Set;

/**
 * @author Cesardl
 */
@Entity
@Table(name = "concesionario")
public class Concesionario implements java.io.Serializable {

    private static final long serialVersionUID = -1874907810652432154L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_concesionario")
    private Integer idConcesionario;

    @Column(name = "nombre_conces", length = 45, nullable = false)
    private String nombreConces;

    @Column(name = "distrito", length = 45, nullable = false)
    private String distrito;

    @Column(name = "propietario", length = 45, nullable = false)
    private String propietario;

    @OneToMany(mappedBy = "concesionario")
    private Set<Usuario> usuarios = new HashSet<>(0);

    @OneToMany(mappedBy = "concessionaire")
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
