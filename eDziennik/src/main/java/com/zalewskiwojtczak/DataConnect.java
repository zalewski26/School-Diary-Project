package com.zalewskiwojtczak;

import java.sql.*;

public abstract class DataConnect {
    protected int id1;
    protected String id2;
    protected static Connection conn;
    protected CallableStatement stmnt;
    protected ResultSet query;
    public abstract boolean failed();

    public String getName(String type, int which){
        try{
            switch (type){
                case "Uczeń":
                    stmnt = conn.prepareCall("SELECT Imie, Nazwisko FROM Uczen WHERE nrLegitymacji = ?");
                    stmnt.setString(1, id2);
                    break;
                case "Nauczyciel":
                    stmnt = conn.prepareCall("SELECT Imie, Nazwisko FROM Nauczyciel WHERE ID_Nauczyciela = ?");
                    stmnt.setInt(1, id1);
                    break;
                case "Opiekun":
                    stmnt = conn.prepareCall("SELECT Imie, Nazwisko FROM Opiekun WHERE ID_Opiekuna = ?");
                    stmnt.setInt(1, id1);
                    break;
                case "Admin":
                    stmnt = conn.prepareCall("SELECT Imie, Nazwisko FROM Administrator WHERE ID_Administratora = ?");
                    stmnt.setInt(1, id1);
                    break;
            }
            stmnt.executeQuery();
            query = stmnt.getResultSet();
            query.next();
            if (which == 1)
                return query.getString(1);
            else
                return query.getString(2);
        } catch (Exception ex){
            ex.printStackTrace();
        } finally {
            try{
                query.close();
                stmnt.close();
            } catch (Exception ex){
                ex.printStackTrace();
            }
        }
        return null;
    }
}

/*
private final static String qStudent = "SELECT nrLegitymacji AS a, Imie AS b, Nazwisko AS c, ID_Adresu AS d, ID_Klasy AS e, PESEL AS f, nrTelefonu AS g, Email AS h FROM Uczen;";
    private final static String qTeacher = "SELECT ID_Nauczyciela AS a, Imie AS b, Nazwisko AS c, ID_Adresu AS d, nrGabinetu AS e, PESEL AS f, nrTelefonu AS g, Email AS h FROM Nauczyciel;";
    private final static String qParent = "SELECT ID_Opiekuna AS a, Imie AS b, Nazwisko AS c, ID_Adresu AS d, 0 AS e, PESEL AS f, nrTelefonu AS g, Email AS h FROM Opiekun;";

    public dziennikDAO() throws Exception{
        conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/dziennik",
                "admin", "123");
        System.out.println("Successfully connected!");
    }

    public static List<Person> showAll(String type) throws Exception {
        List<Person> list = new ArrayList<>();

        Statement stmt = null;
        ResultSet query = null;

        try {
            stmt = conn.createStatement();
            if (type.equalsIgnoreCase("UCZEN"))
                query = stmt.executeQuery(qStudent);
            else if (type.equalsIgnoreCase("NAUCZYCIEL")){
                query = stmt.executeQuery(qTeacher);
            }
            else if (type.equalsIgnoreCase("OPIEKUN")){
                query = stmt.executeQuery(qParent);
            }
            else {
                query = stmt.executeQuery("SELECT 0");
                return null;
            }

            while (query.next()) {
                Person tempPerson = new Person(query.getString("a"), query.getString("b"),
                        query.getString("c"), query.getInt("d"), query.getInt("e"),
                        query.getString("f"), query.getInt("g"), query.getString("h"));
                list.add(tempPerson);
            }

            return list;
        }
        finally {
            try{
                query.close();
                stmt.close();
            } catch (Exception ex){
                ex.printStackTrace();
            }
        }
    }
 */