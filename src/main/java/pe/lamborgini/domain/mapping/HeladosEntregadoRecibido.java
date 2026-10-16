package pe.lamborgini.domain.mapping;

import jakarta.persistence.*;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * @author Cesardl
 */
@Entity
@Table(name = "helados_entregado_recibido")
public class HeladosEntregadoRecibido implements java.io.Serializable {

    private static final long serialVersionUID = 8584291007039612009L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_helados_entregado_recibido")
    private Integer idHeladosEntregadoRecibido;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_heladero", nullable = false)
    private Heladero heladero;

    @Temporal(TemporalType.DATE)
    @Column(name = "fecha", nullable = false)
    private Date fecha;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_at", nullable = false)
    private Date createdAt;

    @OneToMany(mappedBy = "heladosEntregadoRecibido", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
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
