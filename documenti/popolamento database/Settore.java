/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database;

import java.io.Serializable;

/**
 *
 * @author Manu
 */

public class Settore implements Serializable {
    
    private int numero;
    
    private Evento evento;    
    
    private String nome;
   
    private String tipo;
  
    private int capienza; 
    private double prezzo;
    
     public Settore() {
    }

    public Settore(int numero, Evento evento, String nome, String tipo, int capienza, double prezzo) {
        this.numero = numero;
        this.evento = evento;
        this.nome = nome;
        this.tipo = tipo;
        this.capienza = capienza;
        this.prezzo = prezzo;
    }

    
    public Settore(int numero, Evento evento) {
        this.numero = numero;
        this.evento = evento;
    }

    public double getPrezzo() {
        return prezzo;
    }

    public void setPrezzo(double prezzo) {
        this.prezzo = prezzo;
    }
    

    public int getNumero() {
        return numero;
    }

    public void setNumero(int numero) {
        this.numero = numero;
    }

    public Evento getEvento() {
        return evento;
    }

    public void setEvento(Evento evento) {
        this.evento = evento;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public int getCapienza() {
        return capienza;
    }

    public void setCapienza(int capienza) {
        this.capienza = capienza;
    }
    

   
    
}
