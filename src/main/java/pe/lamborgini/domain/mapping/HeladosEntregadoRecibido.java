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
    private double total;
    private Set<DetalleHelado> detalleHelados = new HashSet<>(0);

    public HeladosEntregadoRecibido() {
    }

    public HeladosEntregadoRecibido(Heladero heladero, Date fecha, double total) {
        this.heladero = heladero;
        this.fecha = fecha;
        this.total = total;
    }

    public HeladosEntregadoRecibido(Heladero heladero, Date fecha, double total, Set<DetalleHelado> detalleHelados) {
        this.heladero = heladero;
        this.fecha = fecha;
        this.total = total;
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

    public double getTotal() {
        return this.total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public Set<DetalleHelado> getDetalleHelados() {
        return this.detalleHelados;
    }

    public void setDetalleHelados(Set<DetalleHelado> detalleHelados) {
        this.detalleHelados = detalleHelados;
    }
}
