package pe.lamborgini.domain.mapping;
// Generated 29/06/2011 07:47:21 PM by Hibernate Tools 3.2.1.GA

import java.util.HashSet;
import java.util.Set;

/**
 * Heladero generated by hbm2java
 *
 * @author Cesardl
 */
public class Heladero implements java.io.Serializable {

    private static final long serialVersionUID = 5272503182365777160L;

    private Integer idHeladero;
    private Concesionario concesionario;
    private String nombres;
    private String lastName;
    private Set<ContratoHeladero> contratoHeladeros = new HashSet<>(0);
    private Set<HeladosEntregadoRecibido> heladosEntregadoRecibidos = new HashSet<>(0);

    public Heladero() {
    }

    public Heladero(int idHeladero) {
        this.idHeladero = idHeladero;
    }

    public Heladero(Concesionario concesionario, String nombres, String lastName) {
        this.concesionario = concesionario;
        this.nombres = nombres;
        this.lastName = lastName;
    }

    public Heladero(Concesionario concesionario, String nombres, String lastName, Set<ContratoHeladero> contratoHeladeros, Set<HeladosEntregadoRecibido> heladosEntregadoRecibidos) {
        this.concesionario = concesionario;
        this.nombres = nombres;
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

    public Concesionario getConcesionario() {
        return this.concesionario;
    }

    public void setConcesionario(Concesionario concesionario) {
        this.concesionario = concesionario;
    }

    public String getNombres() {
        return this.nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
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
        return lastName + " " + nombres;
    }
}
