/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package view;

import database.Biglietto;
import database.Database;
import database.Evento;
import database.Settore;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ApplicationScoped;
import javax.faces.event.ValueChangeEvent;


/**
 *
 * @author Manu
 */
@ManagedBean (name="tk")
@ApplicationScoped
public class BigliettoView implements Serializable{

    /**
     * Creates a new instance of BigliettoView
     */
        private Evento selezionato;
        private String tipoSettore;
        private Settore settore;
        private String numeroSettore;
        private String posto;
        private Database d;
        private ArrayList <Settore> settori;
        private HashMap <Settore ,Integer> postiOccupati;
        private boolean tipoSelezionato=false;
        private boolean settoreSelezionato = false;
        private boolean postoSelezionato=false;
        private String nome;
        private String cognome;
        private String via;
        private String cartaCredito;
                
    public BigliettoView() {
        d =Database.getInstance();
        tipoSettore="";
    }

    public Evento getSelezionato() {
        return selezionato;
    }

    public void setSelezionato(Evento selezionato) {
        this.selezionato = selezionato;
    }

    public String getTipoSettore() {
        return tipoSettore;
    }

    public void setTipoSettore(String tipoSettore) {
        
        this.tipoSettore = tipoSettore;
        tipoSelezionato = (tipoSettore!=null);
        this.numeroSettore=null;
        this.settoreSelezionato=false;
        this.postoSelezionato=false;
        this.posto=null;
    }

    public Settore getSettore() {
        return settore;
    }

   

    public String getPosto() {
        return posto;
    }

    public void setPosto(String posto) {
        
            this.posto =posto;
            
        postoSelezionato=posto!=null;
       
    }

    public String getNumeroSettore() {
        return numeroSettore;
    }

    public void setNumeroSettore(String numeroSettore) {
       
      //  System.out.println("wpiefepifuwepifwpiefwepi");
         
           try{  
            this.numeroSettore = numeroSettore;
            for(Settore s:this.settori)
                if((""+s.getNumero()).equals(numeroSettore))
                    this.settore=s;
           }catch(NullPointerException e){
               
           }
         settoreSelezionato = numeroSettore!=null;
         this.posto=null;
         this.postoSelezionato=false;
       
    }
    
    public ArrayList<String> tipiSettoriDisponibili(){
        return d.tipiSettoriEvento(selezionato);
    }
    public ArrayList<Integer> settoriDisponibili(){
        
        ArrayList<Integer> l=new ArrayList<>();
        this.settori=d.settoriEvento(selezionato, tipoSettore);
        for(Settore s:this.settori)
            l.add(s.getNumero());
        return l;
    }
    public ArrayList<String> postiDisponibili(){
       
        ArrayList<String> l=new ArrayList<>();
        ArrayList<Integer>i;
        if(tipoSelezionato&&settoreSelezionato){
            i=d.postiLiberiSettore(selezionato,settore);
            for(Integer n:i)
                l.add(""+n);
        }
        return l;
    }
   public void printState(){
       System.out.println("tipo="+tipoSettore+"|"+tipoSelezionato);
        System.out.println("settore="+numeroSettore+"|"+settoreSelezionato);
        System.out.println("posto="+posto+"|"+postoSelezionato);
   }
    public boolean visualizzaSceltaPosto(){
       
        try{
            return this.tipoSettore.equals("posti numerati")&&settoreSelezionato&&tipoSelezionato;
        } catch(NullPointerException e){
            return false;
        }
    }
   public boolean visualizzaPrezzo(){
       try{
       if(tipoSettore.equals("posti numerati")){
            if(isSettoreSelezionato()&&isPostoSelezionato())
                return true;
       }else
           if(isSettoreSelezionato())
               return true;
       }catch(NullPointerException e){
           return false;
       }
       return false;
       
   }
    public String acquista(){
        if(tipoSettore.equals("posti numerati")){
            if(isSettoreSelezionato()&&isPostoSelezionato())
                d.acqustaBiglietto(new Biglietto(Integer.parseInt(posto),this.selezionato,this.settore));
        } else
             if(isSettoreSelezionato())
                 d.acqustaBiglietto(new Biglietto(0,this.selezionato,this.settore));
        return "acquisto";
    }
    public void statoPrenotazione(){
        this.postiOccupati=  d.statoPrenotazione(selezionato);
    }
    public Collection<Settore> settoriEventoPrenotazione(){
        return this.postiOccupati.keySet();
         
    }
    public int postiOccupatiEventoPrenotazione(Settore s){
        return this.postiOccupati.get(s);
    }

   

    public boolean isTipoSelezionato() {
        return tipoSelezionato;
    }

    public boolean isPostoSelezionato() {
        return postoSelezionato;
    }

    public boolean isSettoreSelezionato() {
        return settoreSelezionato;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCognome() {
        return cognome;
    }

    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    public String getVia() {
        return via;
    }

    public void setVia(String via) {
        this.via = via;
    }

    public String getCartaCredito() {
        return cartaCredito;
    }

    public void setCartaCredito(String cartaCredito) {
        this.cartaCredito = cartaCredito;
    }
    
  
}
