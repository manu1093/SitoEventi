/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database;



import java.sql.Time;
import java.sql.Date;


/**
 *
 * @author Manu
 */

public class Evento  {
   
    private String codice;
   
    private String nome;
   
    private Time oraInizio;
   
    private Time durata;
    
    private Date dataEvento;
   
    private String tipologia;
   
    private String descrizione;
  
    private Date inizioPeriodo;
  
    private Date finePeriodo;
   
    private String risultato;
   
    private String squadra1;
   
    private String squadra2;
 

    public Evento() {
    }

    public Evento(String codice) {
        this.codice = codice;
    }

    public Evento(String codice, String nome, Time oraInizio, Time durata, Date dataEvento, String tipologia) {
        this.codice = codice;
        this.nome = nome;
        this.oraInizio = oraInizio;
         
        this.durata = durata;
        this.dataEvento = dataEvento;
        this.tipologia = tipologia;
    }

    public Evento(String codice, String nome, Time oraInizio, Time durata, Date dataEvento, String tipologia, String risultato, String squadra1, String squadra2) {
        this.codice = codice;
        this.nome = nome;
        this.oraInizio = oraInizio;
        this.durata = durata;
        this.dataEvento = dataEvento;
        this.tipologia = tipologia;
        this.risultato = risultato;
        this.squadra1 = squadra1;
        this.squadra2 = squadra2;
    }

    public Evento(String codice, String nome, Time oraInizio, Time durata, Date dataEvento, String tipologia, String descrizione, Date inizioPeriodo, Date finePeriodo) {
        this.codice = codice;
        this.nome = nome;
        this.oraInizio = oraInizio;
        this.durata = durata;
        this.dataEvento = dataEvento;
        this.tipologia = tipologia;
        this.descrizione = descrizione;
        this.inizioPeriodo = inizioPeriodo;
        this.finePeriodo = finePeriodo;
    }

    public Evento(String codice, String nome, Time oraInizio, Time durata, Date dataEvento, String tipologia, String descrizione, Date inizioPeriodo, Date finePeriodo, String risultato, String squadra1, String squara2) {
        this.codice = codice;
        this.nome = nome;
        this.oraInizio = oraInizio;
        this.durata = durata;
        this.dataEvento = dataEvento;
        this.tipologia = tipologia;
        this.descrizione = descrizione;
        this.inizioPeriodo = inizioPeriodo;
        this.finePeriodo = finePeriodo;
        this.risultato = risultato;
        this.squadra1 = squadra1;
        this.squadra2 = squara2;
    }

    

    public String getCodice() {
        return codice;
    }

    public void setCodice(String codice) {
        this.codice = codice;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public Time getOraInizio() {
        return oraInizio;
    }

    public void setOraInizio(Time oraInizio) {
        this.oraInizio = oraInizio;
    }

    public Time getDurata() {
        return durata;
    }

    public void setDurata(Time durata) {
        this.durata = durata;
    }

    public Date getDataEvento() {
        return dataEvento;
    }

    public void setDataEvento(Date dataEvento) {
        this.dataEvento = dataEvento;
    }

    public String getTipologia() {
        return tipologia;
    }

    public void setTipologia(String tipologia) {
        this.tipologia = tipologia;
    }

    public String getDescrizione() {
        return descrizione;
    }

    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }

    public Date getInizioPeriodo() {
        return inizioPeriodo;
    }

    public void setInizioPeriodo(Date inizioPeriodo) {
        this.inizioPeriodo = inizioPeriodo;
    }

    public Date getFinePeriodo() {
        return finePeriodo;
    }

    public void setFinePeriodo(Date finePeriodo) {
        this.finePeriodo = finePeriodo;
    }

    public String getRisultato() {
        return risultato;
    }

    public void setRisultato(String risultato) {
        this.risultato = risultato;
    }

    public String getSquadra1() {
        return squadra1;
    }

    public void setSquadra1(String squadra1) {
        this.squadra1 = squadra1;
    }

    public String getSquadra2() {
        return squadra2;
    }

    public void setSquadra2(String squadra2) {
        this.squadra2 = squadra2;
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
        if (!(object instanceof Evento)) {
            return false;
        }
        Evento other = (Evento) object;
        if ((this.codice == null && other.codice != null) || (this.codice != null && !this.codice.equals(other.codice))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "database.Evento[ codice=" + codice + " ]";
    }
    
}
