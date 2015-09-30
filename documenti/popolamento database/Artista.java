/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database;




public class Artista  {
   
    private String cf;
 
    private String nome;
   
    private String cognome;
   


    public Artista() {
    }

    public Artista(String cf) {
        this.cf = cf;
    }

    public Artista(String cf, String nome, String cognome) {
        this.cf = cf;
        this.nome = nome;
        this.cognome = cognome;
    }

    public String getCf() {
        return cf;
    }

    public void setCf(String cf) {
        this.cf = cf;
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

    
    @Override
    public int hashCode() {
        int hash = 0;
        hash += (cf != null ? cf.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Artista)) {
            return false;
        }
        Artista other = (Artista) object;
        if ((this.cf == null && other.cf != null) || (this.cf != null && !this.cf.equals(other.cf))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "database.Artista[ cf=" + cf + " ]";
    }
    
}
