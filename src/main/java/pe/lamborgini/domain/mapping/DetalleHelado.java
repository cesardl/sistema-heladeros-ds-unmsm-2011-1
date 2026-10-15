package pe.lamborgini.domain.mapping;

import jakarta.persistence.*;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

/**
 * @author Cesardl
 */
@Entity
@Table(name = "detalle_helado")
public class DetalleHelado implements java.io.Serializable {

    private static final long serialVersionUID = -2363126522481600244L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_detalle_helado")
    private Integer idDetalleHelado;

    @Transient
    private int position;

    @ManyToOne(fetch = FetchType.EAGER)
    @Fetch(FetchMode.JOIN)
    @JoinColumn(name = "id_helado", nullable = false)
    private Helado helado;

    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "id_pago_helado", nullable = true)
    private PagoHelado pagoHelado;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_helados_entregado_recibido", nullable = false)
    private HeladosEntregadoRecibido heladosEntregadoRecibido;

    @Column(name = "cant_entregada", nullable = false)
    private int cantEntregada;

    @Column(name = "cant_devuelta", nullable = false)
    private int cantDevuelta;

    @Column(name = "cant_vendida", nullable = false)
    private int cantVendida;

    @Transient
    private boolean hasStock;

    public DetalleHelado() {
    }

    public DetalleHelado(Helado helado, PagoHelado pagoHelado, HeladosEntregadoRecibido heladosEntregadoRecibido, int cantEntregada, int cantDevuelta, int cantVendida) {
        this.helado = helado;
        this.pagoHelado = pagoHelado;
        this.heladosEntregadoRecibido = heladosEntregadoRecibido;
        this.cantEntregada = cantEntregada;
        this.cantDevuelta = cantDevuelta;
        this.cantVendida = cantVendida;
    }

    public Integer getIdDetalleHelado() {
        return this.idDetalleHelado;
    }

    public void setIdDetalleHelado(Integer idDetalleHelado) {
        this.idDetalleHelado = idDetalleHelado;
    }

    public int getPosition() {
        return position;
    }

    public void setPosition(int position) {
        this.position = position;
    }

    public Helado getHelado() {
        return this.helado;
    }

    public void setHelado(Helado helado) {
        this.helado = helado;
    }

    public PagoHelado getPagoHelado() {
        return this.pagoHelado;
    }

    public void setPagoHelado(PagoHelado pagoHelado) {
        this.pagoHelado = pagoHelado;
    }

    public HeladosEntregadoRecibido getHeladosEntregadoRecibido() {
        return this.heladosEntregadoRecibido;
    }

    public void setHeladosEntregadoRecibido(HeladosEntregadoRecibido heladosEntregadoRecibido) {
        this.heladosEntregadoRecibido = heladosEntregadoRecibido;
    }

    public int getCantEntregada() {
        return this.cantEntregada;
    }

    public void setCantEntregada(int cantEntregada) {
        this.cantEntregada = cantEntregada;
    }

    public int getCantDevuelta() {
        return this.cantDevuelta;
    }

    public void setCantDevuelta(int cantDevuelta) {
        this.cantDevuelta = cantDevuelta;
    }

    public int getCantVendida() {
        return this.cantVendida;
    }

    public void setCantVendida(int cantVendida) {
        this.cantVendida = cantVendida;
    }

    public boolean isHasStock() {
        return hasStock;
    }

    public void setHasStock(boolean hasStock) {
        this.hasStock = hasStock;
    }
}
