package pe.lamborgini.domain.mapping;

import jakarta.persistence.*;

import java.util.Date;

/**
 * @author Cesardl
 */
@Entity
@Table(name = "stock_helado")
public class StockHelado implements java.io.Serializable {

    private static final long serialVersionUID = -5743705707098731924L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_stock_helado")
    private Integer idStockHelado;

    @Column(name = "cantidad", nullable = false)
    private Integer cantidad;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "fecha_caducidad", nullable = false)
    private Date fechaCaducidad;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_at", nullable = false)
    private Date createdAt;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "last_modified")
    private Date lastModified;

    public StockHelado() {
    }

    public StockHelado(int cantidad) {
        this.cantidad = cantidad;
    }

    public Integer getIdStockHelado() {
        return this.idStockHelado;
    }

    public void setIdStockHelado(Integer idStockHelado) {
        this.idStockHelado = idStockHelado;
    }

    public Integer getCantidad() {
        return this.cantidad;
    }

    public void setCantidad(Integer cantidad) {
        this.cantidad = cantidad;
    }

    public Date getFechaCaducidad() {
        return fechaCaducidad;
    }

    public void setFechaCaducidad(Date fechaCaducidad) {
        this.fechaCaducidad = fechaCaducidad;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getLastModified() {
        return lastModified;
    }

    public void setLastModified(Date lastModified) {
        this.lastModified = lastModified;
    }
}
