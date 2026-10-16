package pe.lamborgini.domain.mapping;

import jakarta.persistence.*;

import java.util.Date;

/**
 * @author Cesardl
 */
@Entity
@Table(name = "contrato_heladero")
public class ContratoHeladero implements java.io.Serializable {

    private static final long serialVersionUID = -7400370372833961240L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idcontrato_heladero")
    private Integer idcontratoHeladero;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_heladero", nullable = false)
    private Heladero heladero;

    @Column(name = "numero_contrato", nullable = false)
    private String numeroContrato;

    @Enumerated(EnumType.STRING)
    @Column(name = "tipo", nullable = false)
    private ContractType contractType;

    @Column(name = "contenido", nullable = false)
    private String contenido;

    @Temporal(TemporalType.DATE)
    @Column(name = "fecha_inicio", nullable = false)
    private Date fechaInicio;

    @Temporal(TemporalType.DATE)
    @Column(name = "fecha_fin", nullable = false)
    private Date fechaFin;

    public ContratoHeladero() {
    }

    public ContratoHeladero(Heladero heladero, String numeroContrato, ContractType contractType, String contenido, Date fechaInicio, Date fechaFin) {
        this.heladero = heladero;
        this.numeroContrato = numeroContrato;
        this.contractType = contractType;
        this.contenido = contenido;
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin;
    }

    public Integer getIdcontratoHeladero() {
        return this.idcontratoHeladero;
    }

    public void setIdcontratoHeladero(Integer idcontratoHeladero) {
        this.idcontratoHeladero = idcontratoHeladero;
    }

    public Heladero getHeladero() {
        return this.heladero;
    }

    public void setHeladero(Heladero heladero) {
        this.heladero = heladero;
    }

    public String getNumeroContrato() {
        return this.numeroContrato;
    }

    public void setNumeroContrato(String numeroContrato) {
        this.numeroContrato = numeroContrato;
    }

    public ContractType getContractType() {
        return this.contractType;
    }

    public void setContractType(ContractType contractType) {
        this.contractType = contractType;
    }

    public String getContenido() {
        return this.contenido;
    }

    public void setContenido(String contenido) {
        this.contenido = contenido;
    }

    public Date getFechaInicio() {
        return this.fechaInicio;
    }

    public void setFechaInicio(Date fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public Date getFechaFin() {
        return this.fechaFin;
    }

    public void setFechaFin(Date fechaFin) {
        this.fechaFin = fechaFin;
    }
}
