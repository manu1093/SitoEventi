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
        
    public static void main(String[] args) {
        //new Database().riempiSettore(new Evento("as123432"), 2);
       //System.out.println(new Database().getSettori(new Evento("as123432"),"posti in piedi"));
      //  System.out.println(new Database().getPostiLiberiSettore(new Evento("as123432"),0));       
    }
    
}
