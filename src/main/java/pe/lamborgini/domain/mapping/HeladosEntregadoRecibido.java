package pe.lamborgini.domain.mapping;
// Generated 29/06/2011 07:47:21 PM by Hibernate Tools 3.2.1.GA

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * HeladosEntregadoRecibido generated by hbm2java
 *
 * @author Cesardl
 */
public class HeladosEntregadoRecibido implements java.io.Serializable {

    private static final long serialVersionUID = 8584291007039612009L;

    private Integer idHeladosEntregadoRecibido;
    private Heladero heladero;
    private Date fecha;
    private Date createdAt;
    private Set<DetalleHelado> detalleHelados = new HashSet<>(0);

    public HeladosEntregadoRecibido() {
    }

    public HeladosEntregadoRecibido(Heladero heladero, Date fecha) {
        this.heladero = heladero;
        this.fecha = fecha;
    }

    public HeladosEntregadoRecibido(Heladero heladero, Date fecha, Set<DetalleHelado> detalleHelados) {
        this.heladero = heladero;
        this.fecha = fecha;
        this.detalleHelados = detalleHelados;
    }

    public Integer getIdHeladosEntregadoRecibido() {
        return this.idHeladosEntregadoRecibido;
    }

    public void setIdHeladosEntregadoRecibido(Integer idHeladosEntregadoRecibido) {
        this.idHeladosEntregadoRecibido = idHeladosEntregadoRecibido;
    }

    public Heladero getHeladero() {
        return this.heladero;
    }

    public void setHeladero(Heladero heladero) {
        this.heladero = heladero;
    }

    public Date getFecha() {
        return this.fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Set<DetalleHelado> getDetalleHelados() {
        return this.detalleHelados;
    }

    public void setDetalleHelados(Set<DetalleHelado> detalleHelados) {
        this.detalleHelados = detalleHelados;
    }
}
