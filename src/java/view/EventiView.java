/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package view;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import database.*;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;
/**
 *
 * @author Manu
 */
@ManagedBean (name="home")
@SessionScoped 
public class EventiView implements Serializable{
    private Date data;  
    private String tipologia;
    private ArrayList <Evento> eventi;
    private Evento selezionato;
    private Database d;
    private ArrayList <Artista> artisti;
   
    
    public EventiView() {
        this.eventi=new ArrayList<>();
        d=Database.getInstance();
    }
    public Evento getSelezionato() {
        return selezionato;
    }
      public Date getData() {
        return data;
    }

    public void setData(Date data) {
        this.data = data;
    }

    public String getTipologia() {
        return tipologia;
    }

    public void setTipologia(String tipo) {
        this.tipologia = tipo;
    }
     public void eventiDiOggi(){    
         GregorianCalendar gc=new GregorianCalendar();
         System.out.println(gc.getTime());
       eventi=d.cercaEventi(new GregorianCalendar().getTime(),null);
       //  System.out.println(eventi);
       // this.eventi=d.cercaEventi(null, null);
        
    }
    
    private void aggiorna(Evento sel){
        for(Evento e:this.eventi)
            if(e.getCodice().equals(sel.getCodice())) {           
                this.selezionato=e;
            }
    }
    public String selezionaEvento(Evento e){
        this.aggiorna(e);       
        return "descrizione";        
    }
    public String acquistaBiglietto(Evento e){
      this.aggiorna(e);
        return "biglietto";        
    }
    public ArrayList<String> tipologieEventi(){
        ArrayList <String> l=d.tipologieEvento(); 
        
        return l;       
    }
    public void cercaEventi(){
       eventi= d.cercaEventi(data, tipologia);
       
    }
    public String infoEvento(){
        if(selezionato.getTipologia().equals("partita di pallacanestro") || selezionato.getTipologia().equals("partita di pallavolo") ||  selezionato.getTipologia().equals("altro evento sportivo")){
                    String s;
                    s = "squadra1: "+this.selezionato.getSquadra1()+" <br/> "+"squadra2: "+this.selezionato.getSquadra2()+" <br/> ";
                    if (this.selezionato.getRisultato()!=null)
                            s=s+"risultato: ancora da disputare";
                    return s;
        }
        else
        {
            String s="descrizione: "+this.selezionato.getDescrizione()+"<br/>"+"data inizio repliche"+this.selezionato.getInizioPeriodo().toString()+"<br/>data fine repliche"+this.selezionato.getFinePeriodo();
            int i=0;
            s=s+"<br><br><table><tr><td>Nome</td><td>Cognome</td></tr>";
            try{
            while (this.getArtisti(this.selezionato).get(i).getCf()!=null)
            {
                s=s+"<tr><td>"+this.getArtisti(this.selezionato).get(i).getNome()+"</td><td>"+this.getArtisti(this.selezionato).get(i).getCognome()+"</td></tr>";
                i++;
            }
            
            }
            catch(Exception e){
            }
            s=s+"</table>";
            return s;
        }    
    }
    public boolean isSpettaccolo(){
        return !(selezionato.getTipologia().equals("partita di pallacanestro") || selezionato.getTipologia().equals("partita di pallavolo") ||  selezionato.getTipologia().equals("altro evento sportivo"));                    
    }
    private ArrayList<Artista> getArtisti(Evento e){
        return d.cercaAttori(e);
    }

    public ArrayList<Evento> getEventi() {
        return eventi;        
    }

    public boolean trovatoEventi(){
        return !eventi.isEmpty();
    }
    
    
}
