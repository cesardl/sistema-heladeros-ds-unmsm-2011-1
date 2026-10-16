package pe.lamborgini.domain.mapping;

import jakarta.persistence.*;

/**
 * @author Cesardl
 */
@Entity
@Table(name = "usuario")
public class Usuario implements java.io.Serializable {

    private static final long serialVersionUID = 2388413229420564302L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_usuario")
    private Integer idUsuario;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_concesionario", nullable = false)
    private Concesionario concesionario;

    @Column(name = "nombre_usuario", length = 45, nullable = false)
    private String nombreUsuario;

    @Column(name = "contrasenha", length = 45, nullable = false)
    private String contrasenha;

    @Column(name = "cargo", length = 45, nullable = false)
    private String cargo;

    @Enumerated(EnumType.STRING)
    @Column(name = "role", nullable = false)
    private RoleType roleType;

    public Usuario() {
    }

    public Usuario(Concesionario concesionario, String nombreUsuario, String contrasenha, String cargo) {
        this.concesionario = concesionario;
        this.nombreUsuario = nombreUsuario;
        this.contrasenha = contrasenha;
        this.cargo = cargo;
    }

    public Integer getIdUsuario() {
        return this.idUsuario;
    }

    public void setIdUsuario(Integer idUsuario) {
        this.idUsuario = idUsuario;
    }

    public Concesionario getConcesionario() {
        return this.concesionario;
    }

    public void setConcesionario(Concesionario concesionario) {
        this.concesionario = concesionario;
    }

    public String getNombreUsuario() {
        return this.nombreUsuario;
    }

    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }

    public String getContrasenha() {
        return this.contrasenha;
    }

    public void setContrasenha(String contrasenha) {
        this.contrasenha = contrasenha;
    }

    public String getCargo() {
        return this.cargo;
    }

    public void setCargo(String cargo) {
        this.cargo = cargo;
    }

    public RoleType getRoleType() {
        return roleType;
    }

    public void setRoleType(RoleType role) {
        this.roleType = role;
    }
}
