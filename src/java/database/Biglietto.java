/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database;


import java.math.BigInteger;
import java.util.Date;


/**
 *
 * @author Manu
 */

public class Biglietto  {
 
    private String codice;
   
    private Date dataEmissione;
   
   
    private int numeroPosto;
  
    private Evento evento;
  
    private Settore settore;

    public Biglietto() {
    }

    public Biglietto(String codice) {
        this.codice = codice;
    }

    public Biglietto(String codice, Date dataEmissione) {
        this.codice = codice;
        this.dataEmissione = dataEmissione;
       
    }

    public Biglietto(String codice, Date dataEmissione,  int numeroPosto, Evento evento, Settore settore) {
        this.codice = codice;
        this.dataEmissione = dataEmissione;
        
        this.numeroPosto = numeroPosto;
        this.evento = evento;
        this.settore = settore;
    }

    public Biglietto( int numeroPosto, Evento evento, Settore settore) {
      
        this.numeroPosto = numeroPosto;
        this.evento = evento;
        this.settore = settore;
    }
    
    

    public String getCodice() {
        return codice;
    }

    public void setCodice(String codice) {
        this.codice = codice;
    }

    public Date getDataEmissione() {
        return dataEmissione;
    }

    public void setDataEmissione(Date dataEmissione) {
        this.dataEmissione = dataEmissione;
    }

   
    public int getNumeroPosto() {
        return numeroPosto;
    }

    public void setNumeroPosto(int numeroPosto) {
        this.numeroPosto = numeroPosto;
    }

    public Evento getEvento() {
        return evento;
    }

    public void setEvento(Evento evento) {
        this.evento = evento;
    }

    public Settore getSettore() {
        return settore;
    }

    public void setSettore(Settore settore) {
        this.settore = settore;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (codice != null ? codice.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Biglietto)) {
            return false;
        }
        Biglietto other = (Biglietto) object;
        if ((this.codice == null && other.codice != null) || (this.codice != null && !this.codice.equals(other.codice))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "database.Biglietto[ codice=" + codice + " ]";
    }
    
}
