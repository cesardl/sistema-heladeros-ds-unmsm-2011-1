package pe.lamborgini.domain.mapping;

import jakarta.persistence.*;

import java.util.HashSet;
import java.util.Set;

/**
 * @author Cesardl
 */
@Entity
@Table(name = "concepto")
public class Concepto implements java.io.Serializable {

    private static final long serialVersionUID = -1596668618166585590L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_concepto")
    private Integer idConcepto;

    @Column(name = "detalle_concepto", nullable = false)
    private String detalleConcepto;

    @OneToMany(mappedBy = "concepto")
    private Set<PagoHelado> pagoHelados = new HashSet<>(0);

    public Concepto() {
    }

    public Concepto(int idConcepto) {
        this.idConcepto = idConcepto;
    }

    public Concepto(String detalleConcepto) {
        this.detalleConcepto = detalleConcepto;
    }

    public Concepto(String detalleConcepto, Set<PagoHelado> pagoHelados) {
        this.detalleConcepto = detalleConcepto;
        this.pagoHelados = pagoHelados;
    }

    public Integer getIdConcepto() {
        return this.idConcepto;
    }

    public void setIdConcepto(Integer idConcepto) {
        this.idConcepto = idConcepto;
    }

    public String getDetalleConcepto() {
        return detalleConcepto;
    }

    public void setDetalleConcepto(String detalleConcepto) {
        this.detalleConcepto = detalleConcepto;
    }

    public Set<PagoHelado> getPagoHelados() {
        return this.pagoHelados;
    }

    public void setPagoHelados(Set<PagoHelado> pagoHelados) {
        this.pagoHelados = pagoHelados;
    }
}
