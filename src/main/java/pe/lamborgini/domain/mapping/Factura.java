package pe.lamborgini.domain.mapping;

import jakarta.persistence.*;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * @author Cesardl
 */
@Entity
@Table(name = "factura")
public class Factura implements java.io.Serializable {

    private static final long serialVersionUID = 8079542536491248051L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_factura")
    private Integer idFactura;

    @Column(name = "numero_factura", nullable = false)
    private int numeroFactura;

    @Temporal(TemporalType.DATE)
    @Column(name = "fecha", nullable = false)
    private Date fecha;

    @Column(name = "descripcion", length = 250, nullable = false)
    private String descripcion;

    @Column(name = "pago", nullable = false, precision = 22, scale = 0)
    private double pago;

    @OneToMany(mappedBy = "factura")
    private Set<PagoHelado> pagoHelados = new HashSet<>(0);

    public Factura() {
    }

    public Factura(int numeroFactura, Date fecha, String descripcion, double pago) {
        this.numeroFactura = numeroFactura;
        this.fecha = fecha;
        this.descripcion = descripcion;
        this.pago = pago;
    }

    public Factura(int numeroFactura, Date fecha, String descripcion, double pago, Set<PagoHelado> pagoHelados) {
        this.numeroFactura = numeroFactura;
        this.fecha = fecha;
        this.descripcion = descripcion;
        this.pago = pago;
        this.pagoHelados = pagoHelados;
    }

    public Integer getIdFactura() {
        return this.idFactura;
    }

    public void setIdFactura(Integer idFactura) {
        this.idFactura = idFactura;
    }

    public int getNumeroFactura() {
        return this.numeroFactura;
    }

    public void setNumeroFactura(int numeroFactura) {
        this.numeroFactura = numeroFactura;
    }

    public Date getFecha() {
        return this.fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getDescripcion() {
        return this.descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public double getPago() {
        return this.pago;
    }

    public void setPago(double pago) {
        this.pago = pago;
    }

    public Set<PagoHelado> getPagoHelados() {
        return this.pagoHelados;
    }

    public void setPagoHelados(Set<PagoHelado> pagoHelados) {
        this.pagoHelados = pagoHelados;
    }
}
