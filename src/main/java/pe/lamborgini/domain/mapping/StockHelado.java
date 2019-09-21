package pe.lamborgini.domain.mapping;
// Generated 29/06/2011 07:47:21 PM by Hibernate Tools 3.2.1.GA

import java.util.Date;

/**
 * StockHelado generated by hbm2java
 *
 * @author Cesardl
 */
public class StockHelado implements java.io.Serializable {

    private static final long serialVersionUID = -5743705707098731924L;

    private Integer idStockHelado;
    private Integer cantidad;
    private Date fechaCaducidad;
    private Date createdAt;

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
}


