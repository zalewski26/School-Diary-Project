package com.zalewskiwojtczak;

import javax.swing.*;
import java.sql.CallableStatement;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ParentDataConnect extends DataConnect {
    private final String userLogin;
    private final String userPassword;
    private boolean connection = true;

    public ParentDataConnect(String loginP, String passwordP, String userLogin, String userPassword) throws Exception {
        conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/dziennik2?noAccessToProcedureBodies=true",
                loginP, passwordP);

        this.userLogin=userLogin;
        this.userPassword=userPassword;
        stmnt = (CallableStatement) conn.prepareCall("{CALL user_detail(?,?,?)}");
        stmnt.setString(1, userLogin);
        stmnt.setString(2, userPassword);
        stmnt.registerOutParameter(3, java.sql.Types.VARCHAR);
        stmnt.executeUpdate();
        String resultado = stmnt.getString(3);
        if(resultado == null || !resultado.equals("Opiekun"))
        {
            connection = false;
        }
        id1 = setId();
    }

    @Override
    public boolean failed() {
        if(connection)
        {
            return false;
        }
        return true;
    }

    private int setId() throws SQLException {
        CallableStatement cs = (CallableStatement) conn.prepareCall("{CALL parent_id(?,?,?)}");
        cs.setString(1, userLogin);
        cs.setString(2, userPassword);
        cs.registerOutParameter(3, java.sql.Types.INTEGER);
        cs.executeUpdate();
        int resultado = cs.getInt(3);
        return resultado;
    }
    public List<Grade> showGrades(String firstName, String lastName) {
        List<Grade> grades = new ArrayList<>();
        if (firstName.length() == 0)
            firstName = "%";
        if (lastName.length() == 0)
            lastName = "%";
        try
        {
            stmnt = conn.prepareCall("{CALL parent_grades(?,?,?)}");
            stmnt.setString(1, firstName);
            stmnt.setString(2, lastName);
            stmnt.setInt(3,id1);
            stmnt.executeUpdate();
            query = stmnt.getResultSet();
            while(query.next())
            {
                Grade tempGrade = new Grade(query.getInt(1), query.getString(2),query.getString(3),
                        query.getInt(4),query.getString(5),query.getString(6),query.getString(7),
                        query.getDate(8),query.getString(9));
                grades.add(tempGrade);
            }
        } catch (Exception ex){
            JOptionPane.showMessageDialog(null, "Niepoprawne dane", "Error", JOptionPane.ERROR_MESSAGE);
        } finally {
            try{
                query.close();
                stmnt.close();
            } catch (Exception ex){

            }
        }

        return grades;
    }

    public List<Person> showStudents()
    {
        List<Person> students = new ArrayList<>();
        try
        {
            stmnt = conn.prepareCall("{CALL parent_students(?)}");
            stmnt.setInt(1,id1);
            stmnt.executeUpdate();
            query = stmnt.getResultSet();
            while(query.next())
            {
                Person tempStudent = new Person(query.getString(1),
                        query.getString(2),query.getString(3),query.getString(4));
                students.add(tempStudent);
            }
        } catch (Exception ex){
            JOptionPane.showMessageDialog(null, "Niepoprawne dane", "Error", JOptionPane.ERROR_MESSAGE);
        } finally {
            try{
                query.close();
                stmnt.close();
            } catch (Exception ex){
                ex.printStackTrace();
            }
        }
        return students;
    }

    public List<Note> showNotes(String firstName, String lastName) {
        List<Note> notes = new ArrayList<>();
        if (firstName.length() == 0)
            firstName = "%";
        if (lastName.length() == 0)
            lastName = "%";
        try
        {
            stmnt = conn.prepareCall("{CALL parent_notes(?,?,?)}");
            stmnt.setString(1, firstName);
            stmnt.setString(2, lastName);
            stmnt.setInt(3,id1);
            stmnt.executeUpdate();
            query = stmnt.getResultSet();
            while(query.next())
            {
                Note tempGrade=new Note(query.getString(1),query.getString(2),
                        query.getInt(3),query.getString(4),query.getString(5),query.getString(6));
                notes.add(tempGrade);
            }
        } catch (Exception ex){
            JOptionPane.showMessageDialog(null, "Niepoprawne dane", "Error", JOptionPane.ERROR_MESSAGE);
        } finally {
            try{
                query.close();
                stmnt.close();
            } catch (Exception ex){

            }
        }
        return notes;
    }

    public List<Behaviour> showBehaviour() {
        List<Behaviour> behaviours = new ArrayList<Behaviour>();
        try
        {
            stmnt = conn.prepareCall("{CALL parent_behaviour(?)}");
            stmnt.setInt(1,id1);
            stmnt.executeUpdate();
            query = stmnt.getResultSet();
            while(query.next())
            {
                Behaviour tempGrade = new Behaviour(query.getString(1),query.getString(2),
                        query.getInt(3));
                behaviours.add(tempGrade);
            }
        } catch (Exception ex){
            JOptionPane.showMessageDialog(null, "Niepoprawne dane", "Error", JOptionPane.ERROR_MESSAGE);
        } finally {
            try{
                query.close();
                stmnt.close();
            } catch (Exception ex){

            }
        }
        return behaviours;
    }
}