/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database;

import java.io.InputStream;
import java.io.Reader;
import java.math.BigDecimal;
import java.net.URL;
import java.sql.Array;
import java.sql.Blob;
import java.sql.Clob;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.sql.Date;
import java.sql.NClob;
import java.sql.ParameterMetaData;
import java.sql.Ref;
import java.sql.ResultSetMetaData;
import java.sql.RowId;
import java.sql.SQLWarning;
import java.sql.SQLXML;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Manu
 */
public class Database extends Connection{
        private static Database db;
        private Database(){
            super("org.postgresql.Driver","jdbc:postgresql://dbserver.scienze.univr.it/dblab54","userlab54","cinquantaquattroSH");
            
        }
      public static Database getInstance(){
          if(db==null)
              db=new Database();
          return db;
      }
    
        public ArrayList<Evento> cercaEventi (java.util.Date data,String tipo)  {
             ResultSet s = null;
             PreparedStatement p;
             ArrayList <Evento> l=new ArrayList<>();
              try {
            if(data!=null && tipo!=null) {
               
                 p=this.conn.prepareStatement("select * from Evento where tipologia = ? and (data_evento = ? or ( inizio_periodo <= ? and fine_periodo>=? )) order by data_evento,tipologia ;");
                 p.setString(1, tipo);
                 p.setDate(2, new Date(data.getTime()));
                 p.setDate(3, new Date(data.getTime()));
                 p.setDate(4, new Date(data.getTime()));
                 s=p.executeQuery();
            }
            else if(data!=null){
                
               p=this.conn.prepareStatement("select * from Evento where (data_evento = ? or ( inizio_periodo <= ? and fine_periodo>=? )) order by data_evento,tipologia ;");
                 p.setDate(1, new Date(data.getTime()));  
                  p.setDate(2, new Date(data.getTime()));
                 p.setDate(3, new Date(data.getTime()));
                 s=p.executeQuery();
            }else
            if(tipo!=null){
                 p=this.conn.prepareStatement("select * from Evento where tipologia = ? order by data_evento,tipologia ;");
                 p.setString(1, tipo);
                 s=p.executeQuery();
            } else
                s=this.getRsQuery("select * from evento order by data_evento,tipologia;");
              
          
            
         
              while(s.next()){
                  
                  l.add(new Evento(s.getString("codice"), s.getString("nome"),s.getTime("ora_inizio"),s.getTime("durata"),s.getDate("data_Evento"),s.getString("tipologia"), s.getString("descrizione"),s.getDate("inizio_periodo"), s.getDate("fine_periodo"),s.getString("risultato"), s.getString("squadra1"),s.getString("squadra2")));
              }
          } catch (SQLException ex) {
              Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
          }
            
          return l;  
            
        }
        
        public ArrayList<Artista> cercaAttori (Evento evento)  {//codice spettacolo
             ResultSet s = null;
             PreparedStatement p;
             ArrayList<Artista> l=new ArrayList<Artista>();
              try {
            if(evento!=null){
                 p=this.conn.prepareStatement("select artista from partecipanti where evento = ? ;");
                 p.setString(1, evento.getCodice());
                 s=p.executeQuery();
            }
             while(s.next()){
                 System.out.println(s.getString("artista"));
                  l.add(completaArtista(new Artista(s.getString("artista"))));
              }
          } catch (SQLException ex) {
              Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
          }
            
          return l;  
            
        }
        private Artista completaArtista (Artista a)
        {
            ResultSet s = null;
            PreparedStatement p;
              try {
            if(a.getCf()!=null)
                {
                    p=this.conn.prepareStatement("select * from artista where cf = ? ;");
                    p.setString(1, a.getCf());
                    s=p.executeQuery();
                }
            s.next();
                  a=new Artista(s.getString("cf"), s.getString("nome"), s.getString("cognome"));
              }
          catch (SQLException ex) 
          {
              Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
          }
            
          return a;  
            
        }
        
        
        
        public ArrayList<String> tipologieEvento(){
            ArrayList <String> s=new ArrayList<>();
            ResultSet r=this.getRsQuery("select distinct tipologia from evento;");
          try {
              while(r.next())
                  s.add(r.getString("tipologia"));
          } catch (SQLException ex) {
              Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
          }
          return s;
        }
        
        public ArrayList<String> tipiSettoriEvento(Evento e){
            ArrayList <String> l=new ArrayList<>();
          try {
              PreparedStatement pr=this.conn.prepareStatement(""
                      + "select distinct tipo "
                      + " from (select tipo,settore.numero "
                      + " from settore,evento "
                      + " where evento=codice and codice=? "
                      + " except select tipo,settore.numero "
                      + " from settore,evento,biglietto "
                      + " where settore.evento=evento.codice and biglietto.evento=evento.codice and settore.numero=biglietto.settore and evento.codice=? "
                      + " group by settore.numero,settore.tipo,settore.capienza "
                      + " having count(*)=settore.capienza) as foo; "); 
              pr.setString(1, e.getCodice());
              pr.setString(2, e.getCodice());
              ResultSet r=pr.executeQuery();
              while(r.next())
                  l.add(r.getString("tipo"));
          } catch (SQLException ex) {
              Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
          }
            return l;
          
        }
        public ArrayList<Settore> settoriEvento(Evento e,String tipo){
          ArrayList<Settore> l=new ArrayList<>();  
          try {
              PreparedStatement p= this.conn.prepareStatement(""
                     
                      + "select tipo,settore.numero,capienza,settore.nome,settore.prezzo "
                      + " from settore,evento "
                      + " where evento=codice and codice=? and tipo=?"
                      + " except select tipo,settore.numero,capienza,settore.nome,settore.prezzo "
                      + " from settore,evento,biglietto "
                      + " where settore.evento=evento.codice and biglietto.evento=evento.codice and settore.numero=biglietto.settore and evento.codice=? and tipo=? "
                      + " group by settore.numero,settore.tipo,settore.capienza,settore.nome,settore.prezzo "
                      + " having count(*)=settore.capienza; "); 
              p.setString(1, e.getCodice());
              p.setString(2, tipo);
              p.setString(3, e.getCodice());
              p.setString(4, tipo);
              ResultSet s=p.executeQuery();
              while(s.next()){
                  l.add(new Settore(s.getInt("numero"),e,s.getString("nome"),tipo,s.getInt("capienza"),s.getDouble("prezzo")));
              }
          } catch (SQLException ex) {
              System.out.println(ex);
          }
          return l;
        }
        public ArrayList<Integer> postiLiberiSettore(Evento e,Settore s){
           
            ArrayList<Integer> l=new ArrayList<>();
            ArrayList<Integer> h=new ArrayList<>();
          
              PreparedStatement p;
          try {
              p = this.conn.prepareStatement("select numero_posto " +
                      "from biglietto,evento "
                      + "where evento=? and settore=? and evento=evento.codice;");
         
              p.setString(1,e.getCodice());
              p.setInt(2, s.getNumero());
              ResultSet ss= p.executeQuery();
              while(ss.next())
                l.add(ss.getInt(1));
              p=this.conn.prepareStatement("select capienza " +
                      "from settore "
                      +"where evento=? and numero=? ;");
              p.setString(1,e.getCodice());
              p.setInt(2, s.getNumero());
              ss=p.executeQuery();
              ss.next();
              for(int i=0;i<=ss.getInt(1);i++)
                  h.add(i);
              for(Integer i:l)
                  h.remove(i);
           return h;  
         } catch (SQLException ex) {
              Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
          }
           return h;  
        }
        public HashMap<Settore,Integer> statoPrenotazione(Evento e){
            HashMap <Settore,Integer> m=new HashMap<>();
          try {
              PreparedStatement p=this.conn.prepareStatement("select numero,settore.nome,tipo,capienza,settore.prezzo,count(*) as posti_occupati " +
                      "from settore,evento,biglietto " +
                      "where settore.evento=evento.codice and biglietto.evento=evento.codice and settore.numero=biglietto.settore and evento.codice=? " +
                      "group by settore.numero,settore.numero,settore.capienza,settore.nome,tipo,settore.prezzo " +
                      "union " +
                      "select numero,nome,tipo,capienza,s.prezzo,0 " +
                      "from settore s " +
                      "where evento=? and not " +
                      "exists(select count(*) " +
                      "from settore s1,evento,biglietto " +
                      "where s1.evento=evento.codice and biglietto.evento=evento.codice and s1.numero=biglietto.settore and evento.codice=? and s.numero=s1.numero " +
                      "group by s1.numero);");
              for(int i=1;i<4;i++){
                  p.setString(i, e.getCodice());
              }
            //  System.out.println("p = " + p);
              ResultSet s=p.executeQuery();
              while(s.next())
                  m.put(new Settore(s.getInt("numero"), e,s.getString("nome"), s.getString("tipo"), s.getInt("capienza"),s.getDouble("prezzo")), s.getInt("posti_occupati"));
          } catch (SQLException ex) {
              Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
          }
            return m;
        }
        private String genCodiceBiglietto(){
            String r="";
           char c[]=new char[36];
           
           
           int i;
           char k='0';
           for(i=0;i<10;i++){
               c[i]=k;
               k++;
               
             //  System.out.println(c[i]);
           }
           k='a';
           for(i=i;i<36;i++){
               c[i]=k;
               k++;
             //  System.out.println(c[i]);
           }
          for(i=0;i<8;i++){
              r+=c[(int)(Math.random()*35)];
          }
         return r;
        }
        void riempiSettore(Evento e,int settore) {
            
          try {
              for(int i=0;i<50;i++){
              if(i==15 || i==38)
                  i++;
              PreparedStatement p=this.conn.prepareStatement("insert into biglietto values(?,?,?,?,?,?)");
              p.setString(1,this.genCodiceBiglietto());
              p.setDate(2,new Date(new GregorianCalendar().getTimeInMillis()));
              p.setDouble(3,30.5);
              p.setString(4, e.getCodice());
              p.setInt(5,settore);
              p.setInt(6,i);
              p.execute();
              }
         
          } catch (SQLException ex) {
              Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
          }
            
        }
        private int random(int Min,int Max){
            return Min + (int)(Math.random() * ((Max - Min) + 1));
        }
        void inserisciSettoriEvento(Evento e,int numeroSettori,int minRange,int maxRange){
            ArrayList <String> l=new ArrayList<>();
            l.add("milano");l.add("roma");l.add("venezia");l.add("trento");l.add("trieste");
            l.add("collodi");l.add("pascal");l.add("Macchiavelli");l.add("Foscolo");l.add("Manzoni");
             ArrayList <String> t=new ArrayList<>();
             t.add("posti in piedi");t.add("posti numerati");t.add("posti non numerati");
           
             int r1=minRange+(maxRange-minRange)/3;
             int r2=minRange+2*(maxRange-minRange)/3;
             
            try {
                PreparedStatement c=conn.prepareStatement("insert into settore values(?,?,?,?,?,?)");
                for(int i=1;i<=numeroSettori;i++){
                    c.setInt(1, i);
                    c.setString(2, e.getCodice());
                    int r=random(0,l.size());
                    c.setString(3, l.get(r));
                    l.remove(r);
                    r=random(0,t.size());
                    c.setString(4,t.get(r));
                    c.setInt(5,random(50,300));
                    if(t.get(r).equals("posti in piedi")) 
                         c.setDouble(6,random(minRange,r1));
                    if(t.get(r).equals("posti numerati")) 
                         c.setDouble(6,random(r2,maxRange));
                    if(t.get(r).equals("posti non numerati")) 
                         c.setDouble(6,random(r1,r2));
                    c.execute();
                }
                    
            } catch (SQLException ex) {
                Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            }
            
        }
        public void acqustaBiglietto(Biglietto b){
          try {
              
              PreparedStatement c=this.conn.prepareStatement("insert into biglietto values(?,?,?,?,?);");
              c.setString(1,this.genCodiceBiglietto());
              c.setDate(2, new Date(new GregorianCalendar().getTimeInMillis()));              
              c.setString(3,b.getEvento().getCodice());
              c.setInt(4, b.getSettore().getNumero());
              if(b.getNumeroPosto()!=0)
                c.setInt(5, b.getNumeroPosto());
              else
                 c.setNull(5,java.sql.Types.INTEGER);
              c.execute();
             
             
          } catch (SQLException ex) {
              Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
          }
        }
        
    public static void main(String[] args) {
        //new Database().riempiSettore(new Evento("as123432"), 2);
       //System.out.println(new Database().getSettori(new Evento("as123432"),"posti in piedi"));
      //  System.out.println(new Database().getPostiLiberiSettore(new Evento("as123432"),0));       
    }
    
}
