package pe.lamborgini.domain.mapping;

import jakarta.persistence.*;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import java.util.HashSet;
import java.util.Set;

/**
 * @author Cesardl
 */
@Entity
@Table(name = "heladero")
public class Heladero implements java.io.Serializable {

    private static final long serialVersionUID = 5272503182365777160L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_heladero")
    private Integer idHeladero;

    @ManyToOne(fetch = FetchType.EAGER)
    @Fetch(FetchMode.JOIN)
    @JoinColumn(name = "id_concesionario", nullable = false)
    private Concesionario concessionaire;

    @Column(name = "nombres", length = 45, nullable = false)
    private String name;

    @Column(name = "apellidos", length = 45, nullable = false)
    private String lastName;

    @OneToMany(mappedBy = "heladero")
    private Set<ContratoHeladero> contratoHeladeros = new HashSet<>(0);

    @OneToMany(mappedBy = "heladero")
    private Set<HeladosEntregadoRecibido> heladosEntregadoRecibidos = new HashSet<>(0);

    public Heladero() {
    }

    public Heladero(int idHeladero) {
        this.idHeladero = idHeladero;
    }

    public Heladero(Concesionario concessionaire, String name, String lastName) {
        this.concessionaire = concessionaire;
        this.name = name;
        this.lastName = lastName;
    }

    public Heladero(Concesionario concessionaire, String name, String lastName, Set<ContratoHeladero> contratoHeladeros, Set<HeladosEntregadoRecibido> heladosEntregadoRecibidos) {
        this.concessionaire = concessionaire;
        this.name = name;
        this.lastName = lastName;
        this.contratoHeladeros = contratoHeladeros;
        this.heladosEntregadoRecibidos = heladosEntregadoRecibidos;
    }

    public Integer getIdHeladero() {
        return this.idHeladero;
    }

    public void setIdHeladero(Integer idHeladero) {
        this.idHeladero = idHeladero;
    }

    public Concesionario getConcessionaire() {
        return this.concessionaire;
    }

    public void setConcessionaire(Concesionario concesionario) {
        this.concessionaire = concesionario;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String nombres) {
        this.name = nombres;
    }

    public String getLastName() {
        return this.lastName;
    }

    public void setLastName(String apellidos) {
        this.lastName = apellidos;
    }

    public Set<ContratoHeladero> getContratoHeladeros() {
        return this.contratoHeladeros;
    }

    public void setContratoHeladeros(Set<ContratoHeladero> contratoHeladeros) {
        this.contratoHeladeros = contratoHeladeros;
    }

    public Set<HeladosEntregadoRecibido> getHeladosEntregadoRecibidos() {
        return this.heladosEntregadoRecibidos;
    }

    public void setHeladosEntregadoRecibidos(Set<HeladosEntregadoRecibido> heladosEntregadoRecibidos) {
        this.heladosEntregadoRecibidos = heladosEntregadoRecibidos;
    }

    @Override
    public String toString() {
        return lastName + " " + name;
    }
}
