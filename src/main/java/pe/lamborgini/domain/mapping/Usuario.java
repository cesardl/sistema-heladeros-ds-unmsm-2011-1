package pe.lamborgini.domain.mapping;
// Generated 29/06/2011 07:47:21 PM by Hibernate Tools 3.2.1.GA

/**
 * Usuario generated by hbm2java
 *
 * @author Cesardl
 */
public class Usuario implements java.io.Serializable {

    private static final long serialVersionUID = 2388413229420564302L;

    private Integer idUsuario;
    private Concesionario concesionario;
    private String nombreUsuario;
    private String contrasenha;
    private String cargo;
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


