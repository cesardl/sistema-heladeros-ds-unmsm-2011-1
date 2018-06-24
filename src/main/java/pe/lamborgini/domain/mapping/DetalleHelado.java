package pe.lamborgini.domain.mapping;
// Generated 29/06/2011 07:47:21 PM by Hibernate Tools 3.2.1.GA

/**
 * DetalleHelado generated by hbm2java
 */
public class DetalleHelado implements java.io.Serializable {

    private Integer idDetalleHelado;
    private int posicion;
    private Helado helado;
    private PagoHelado pagoHelado;
    private HeladosEntregadoRecibido heladosEntregadoRecibido;
    private int cantEntregada;
    private int cantPendiente;
    private int cantDevuelta;
    private String strCantDevuelta;
    private int cantVendida;

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

    public int getPosicion() {
        return posicion;
    }

    public void setPosicion(int posicion) {
        this.posicion = posicion;
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

    public int getCantPendiente() {
        return cantPendiente;
    }

    public void setCantPendiente(int cantPendiente) {
        this.cantPendiente = cantPendiente;
    }

    public int getCantDevuelta() {
        return this.cantDevuelta;
    }

    public void setCantDevuelta(int cantDevuelta) {
        this.cantDevuelta = cantDevuelta;
    }

    public String getStrCantDevuelta() {
        return strCantDevuelta;
    }

    public void setStrCantDevuelta(String strCantDevuelta) {
        this.strCantDevuelta = strCantDevuelta;
    }

    public int getCantVendida() {
        return this.cantVendida;
    }

    public void setCantVendida(int cantVendida) {
        this.cantVendida = cantVendida;
    }
}