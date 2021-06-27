package com.zalewskiwojtczak;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDataConnect extends DataConnect {
    private final String userLogin;
    private final String userPassword;
    private boolean connection = true;

    public StudentDataConnect(String loginS, String passwordS, String userLogin, String userPassword) throws Exception {
        conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/dziennik2?noAccessToProcedureBodies=true",
                loginS, passwordS);

        this.userLogin = userLogin;
        this.userPassword = userPassword;
        stmnt = (CallableStatement) conn.prepareCall("{CALL user_detail(?,?,?)}");
        stmnt.setString(1, userLogin);
        stmnt.setString(2, userPassword);
        stmnt.registerOutParameter(3, java.sql.Types.VARCHAR);
        stmnt.executeUpdate();
        String resultado = stmnt.getString(3);
        System.out.println(resultado);

        if(resultado == null || !resultado.equals("Uczen"))
        {
            connection = false;
        }
        id2 = setId();
    }

    @Override
    public boolean failed() {
        if(connection)
        {
            return false;
        }
        return true;
    }

    private String setId() throws SQLException {
        CallableStatement cs = (CallableStatement) conn.prepareCall("{CALL student_id(?,?,?)}");
        cs.setString(1, userLogin);
        cs.setString(2, userPassword);
        cs.registerOutParameter(3, java.sql.Types.VARCHAR);
        cs.executeUpdate();
        String resultado = cs.getString(3);
        return resultado;
    }

    public List<Grade> showGrades(String subject){
        if (subject.length() == 0)
            subject = "%";
        List<Grade> grades = new ArrayList<>();
        try {
            stmnt = conn.prepareCall("{CALL show_marks(?,?)}");
            stmnt.setString(1, id2);
            stmnt.setString(2, subject);
            stmnt.executeUpdate();
            query = stmnt.getResultSet();
            while(query.next())
            {
                grades.add(new Grade(query.getInt(1), query.getInt(2), query.getString(3), query.getString(4), query.getString(5), query.getDate(6), query.getString(7)));
            }
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
        return grades;
    }

    public List<Note> showNotes(){
         List<Note> notes = new ArrayList<>();
        try {
            stmnt = conn.prepareCall("{CALL show_notes(?)}");
            stmnt.setString(1, id2);
            stmnt.executeUpdate();
            query = stmnt.getResultSet();
            while(query.next())
            {
                notes.add(new Note(query.getInt(1), query.getString(2), query.getString(3), query.getString(4)));
            }
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
        return notes;
    }

    public int getBehaviour(){
        int resultado = -1;
        try {
            stmnt = conn.prepareCall("{CALL show_points(?)}");
            stmnt.setString(1, id2);
            stmnt.executeUpdate();
            query = stmnt.getResultSet();
            query.next();
            resultado = query.getInt(1);
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
        return resultado;
    }

    public double getAverage(String text){
        double resultado = 1;
        try {
            if (text.length() == 0){
                stmnt = conn.prepareCall("{CALL oblicz_srednia_ogolna(?)}");
                stmnt.setString(1, id2);
            }
            else{
                stmnt = conn.prepareCall("{CALL oblicz_srednia(?,?)}");
                stmnt.setString(1, id2);
                stmnt.setString(2, text);
            }
            stmnt.executeUpdate();
            query = stmnt.getResultSet();
            query.next();
            resultado = query.getDouble(1);
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
        return resultado;
    }
}
