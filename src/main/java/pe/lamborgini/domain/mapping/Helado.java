package pe.lamborgini.domain.mapping;

import jakarta.persistence.*;

import java.util.HashSet;
import java.util.Set;

/**
 * @author Cesardl
 */
@Entity
@Table(name = "helado")
public class Helado implements java.io.Serializable {

    private static final long serialVersionUID = 397776243260252512L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_helado")
    private Integer idHelado;

    @Column(name = "nombre_helado", length = 45, nullable = false)
    private String nombreHelado;

    @Column(name = "precio", nullable = false, precision = 22, scale = 0)
    private double precio;

    @ManyToOne(fetch = FetchType.LAZY, cascade = {CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REMOVE})
    @JoinColumn(name = "id_stock_helado")
    private StockHelado stockHelado;

    @OneToMany(mappedBy = "helado")
    private Set<DetalleHelado> detalleHelados = new HashSet<>(0);

    public Helado() {
    }

    public Helado(String nombreHelado, double precio) {
        this.nombreHelado = nombreHelado;
        this.precio = precio;
    }

    public Helado(String nombreHelado, double precio, StockHelado stockHelado, Set<DetalleHelado> detalleHelados) {
        this.nombreHelado = nombreHelado;
        this.precio = precio;
        this.stockHelado = stockHelado;
        this.detalleHelados = detalleHelados;
    }

    public Integer getIdHelado() {
        return this.idHelado;
    }

    public void setIdHelado(Integer idHelado) {
        this.idHelado = idHelado;
    }

    public String getNombreHelado() {
        return this.nombreHelado;
    }

    public void setNombreHelado(String nombreHelado) {
        this.nombreHelado = nombreHelado;
    }

    public double getPrecio() {
        return this.precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public StockHelado getStockHelado() {
        return stockHelado;
    }

    public void setStockHelado(StockHelado stockHelado) {
        this.stockHelado = stockHelado;
    }

    public Set<DetalleHelado> getDetalleHelados() {
        return this.detalleHelados;
    }

    public void setDetalleHelados(Set<DetalleHelado> detalleHelados) {
        this.detalleHelados = detalleHelados;
    }
}
