package pe.lamborgini.domain.mapping;

import jakarta.persistence.*;

import java.util.HashSet;
import java.util.Set;

/**
 * @author Cesardl
 */
@Entity
@Table(name = "pago_helado")
public class PagoHelado implements java.io.Serializable {

    private static final long serialVersionUID = -7570929217617713382L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idpago_helado")
    private Integer idpagoHelado;

    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "id_factura", nullable = false)
    private Factura factura;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_concepto", nullable = false)
    private Concepto concepto;

    @Column(name = "cant_pagada", nullable = false)
    private double cantPagada;

    @OneToMany(mappedBy = "pagoHelado")
    private Set<DetalleHelado> detalleHelados = new HashSet<>(0);

    public PagoHelado() {
    }

    public PagoHelado(Factura factura, Concepto concepto, int cantPagada) {
        this.factura = factura;
        this.concepto = concepto;
        this.cantPagada = cantPagada;
    }

    public PagoHelado(Factura factura, Concepto concepto, int cantPagada, Set<DetalleHelado> detalleHelados) {
        this.factura = factura;
        this.concepto = concepto;
        this.cantPagada = cantPagada;
        this.detalleHelados = detalleHelados;
    }

    public Integer getIdpagoHelado() {
        return this.idpagoHelado;
    }

    public void setIdpagoHelado(Integer idpagoHelado) {
        this.idpagoHelado = idpagoHelado;
    }

    public Factura getFactura() {
        return this.factura;
    }

    public void setFactura(Factura factura) {
        this.factura = factura;
    }

    public Concepto getConcepto() {
        return this.concepto;
    }

    public void setConcepto(Concepto concepto) {
        this.concepto = concepto;
    }

    public double getCantPagada() {
        return this.cantPagada;
    }

    public void setCantPagada(double cantPagada) {
        this.cantPagada = cantPagada;
    }

    public Set<DetalleHelado> getDetalleHelados() {
        return this.detalleHelados;
    }

    public void setDetalleHelados(Set<DetalleHelado> detalleHelados) {
        this.detalleHelados = detalleHelados;
    }
}
