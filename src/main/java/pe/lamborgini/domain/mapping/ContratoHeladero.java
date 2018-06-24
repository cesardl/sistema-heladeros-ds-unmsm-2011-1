package pe.lamborgini.domain.mapping;
// Generated 29/06/2011 07:47:21 PM by Hibernate Tools 3.2.1.GA


import java.util.Date;

/**
 * ContratoHeladero generated by hbm2java
 */
public class ContratoHeladero  implements java.io.Serializable {


     private Integer idcontratoHeladero;
     private Heladero heladero;
     private int numeroContrato;
     private String tipo;
     private String contenido;
     private Date fechaInicio;
     private Date fechaFin;

    public ContratoHeladero() {
    }

    public ContratoHeladero(Heladero heladero, int numeroContrato, String tipo, String contenido, Date fechaInicio, Date fechaFin) {
       this.heladero = heladero;
       this.numeroContrato = numeroContrato;
       this.tipo = tipo;
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
    public int getNumeroContrato() {
        return this.numeroContrato;
    }
    
    public void setNumeroContrato(int numeroContrato) {
        this.numeroContrato = numeroContrato;
    }
    public String getTipo() {
        return this.tipo;
    }
    
    public void setTipo(String tipo) {
        this.tipo = tipo;
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

