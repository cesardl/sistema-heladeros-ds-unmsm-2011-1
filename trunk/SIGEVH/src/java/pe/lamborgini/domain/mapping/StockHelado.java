package pe.lamborgini.domain.mapping;
// Generated 29/06/2011 07:47:21 PM by Hibernate Tools 3.2.1.GA



/**
 * StockHelado generated by hbm2java
 */
public class StockHelado  implements java.io.Serializable {


     private Integer idStockHelado;
     private Helado helado;
     private int cantidad;

    public StockHelado() {
    }

    public StockHelado(Helado helado, int cantidad) {
       this.helado = helado;
       this.cantidad = cantidad;
    }
   
    public Integer getIdStockHelado() {
        return this.idStockHelado;
    }
    
    public void setIdStockHelado(Integer idStockHelado) {
        this.idStockHelado = idStockHelado;
    }
    public Helado getHelado() {
        return this.helado;
    }
    
    public void setHelado(Helado helado) {
        this.helado = helado;
    }
    public int getCantidad() {
        return this.cantidad;
    }
    
    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }




}

