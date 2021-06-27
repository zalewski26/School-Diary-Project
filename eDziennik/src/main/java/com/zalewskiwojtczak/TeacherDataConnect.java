package com.zalewskiwojtczak;

import javax.swing.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TeacherDataConnect extends DataConnect {
    private final String userLogin;
    private final String userPassword;
    private boolean connection = true;

    public TeacherDataConnect(String loginT, String passwordT, String userLogin, String userPassword) throws Exception {
        conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/dziennik2?noAccessToProcedureBodies=true",
                loginT, passwordT);

        this.userLogin=userLogin;
        this.userPassword=userPassword;
        stmnt = (CallableStatement) conn.prepareCall("{CALL user_detail(?,?,?)}");
        stmnt.setString(1, userLogin);
        stmnt.setString(2, userPassword);
        stmnt.registerOutParameter(3, java.sql.Types.VARCHAR);
        stmnt.executeUpdate();
        String resultado = stmnt.getString(3);
        if(resultado == null || !resultado.equals("Nauczyciel"))
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
        CallableStatement cs = (CallableStatement) conn.prepareCall("{CALL teacher_id(?,?,?)}");
        cs.setString(1, userLogin);
        cs.setString(2, userPassword);
        cs.registerOutParameter(3, java.sql.Types.VARCHAR);
        cs.executeUpdate();
        int resultado = cs.getInt(3);
        return resultado;
    }

    public List<Grade> showMarks(String firstName, String lastName)
    {
        List<Grade> grades = new ArrayList<>();
        if (firstName.length() == 0)
            firstName = "%";
        if (lastName.length() == 0)
            lastName = "%";
        try
        {
            stmnt = conn.prepareCall("{CALL marks_teacher_view(?,?,?)}");
            stmnt.setString(1, firstName);
            stmnt.setString(2, lastName);
            stmnt.setInt(3,id1);
            stmnt.executeUpdate();
            query = stmnt.getResultSet();
            while(query.next())
            {
                Grade tempGrade = new Grade(query.getInt(1), query.getFloat(2),
                        query.getString(3),query.getString(4),query.getString(5),query.getString(6),query.getString(7),
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
    public List<Note> showNotes(String firstName, String lastName)
    {
        List<Note> notes = new ArrayList<>();
        if (firstName.length() == 0)
            firstName = "%";
        if (lastName.length() == 0)
            lastName = "%";
        try
        {
            stmnt = conn.prepareCall("{CALL notes_teacher_view(?,?,?)}");
            stmnt.setString(1, firstName);
            stmnt.setString(2, lastName);
            stmnt.setInt(3,id1);
            stmnt.executeUpdate();
            query = stmnt.getResultSet();
            while(query.next())
            {
                Note tempNote = new Note(query.getInt(1), query.getInt(2),
                        query.getString(3),query.getString(4),query.getString(5),query.getString(6),query.getString(7));
                notes.add(tempNote);
            }
        } catch (Exception ex){
            ex.printStackTrace();
            JOptionPane.showMessageDialog(null, "Niepoprawne dane", "Error", JOptionPane.ERROR_MESSAGE);
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
    public List<Person> showStudents(String firstName, String lastName)
    {
        List<Person> students = new ArrayList<>();
        if (firstName.length() == 0)
            firstName = "%";
        if (lastName.length() == 0)
            lastName = "%";
        try
        {
            stmnt = conn.prepareCall("{CALL students_teacher_view(?,?,?)}");
            stmnt.setString(1, firstName);
            stmnt.setString(2, lastName);
            stmnt.setInt(3,id1);
            stmnt.executeUpdate();
            query = stmnt.getResultSet();
            while(query.next())
            {
                Person tempStudent=new Person(query.getString(1),
                        query.getString(2),query.getString(3),query.getString(4));
                students.add(tempStudent);
            }
        } catch (Exception ex){
            ex.printStackTrace();
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
    public void addMark(String[] fields) throws Exception
    {
        try
        {
            Date date=Date.valueOf(fields[2]);
            stmnt=conn.prepareCall("{CALL dodaj_ocene(?,?,?,?,?,?)}");
            CallableStatement cs=conn.prepareCall("{CALL find_subjectID(?)}");
            CallableStatement legitymacjaCheck=conn.prepareCall("{CALL legitymacja_check(?)}");
            legitymacjaCheck.setString(1, fields[0]);
            legitymacjaCheck.executeUpdate();
            ResultSet test=legitymacjaCheck.getResultSet();
            test.next();
            int check=test.getInt(1);
            if(check>0)
            {
                cs.setString(1, fields[1]);
                cs.executeUpdate();
                query=cs.getResultSet();
                query.next();
                int subjectID=query.getInt(1);
                stmnt.setString(1, fields[0]);
                stmnt.setInt(2, id1);
                stmnt.setInt(3, subjectID);
                stmnt.setDate(4,date);
                stmnt.setFloat(5,Float.parseFloat(fields[3]));
                stmnt.setString(6, fields[4]);
                stmnt.execute();
                cs.close();
            }
            else
            {
                throw new SQLException();
            }

        } catch (Exception ex){
            throw new Exception();
        } finally {
            try{
                stmnt.close();
            } catch (Exception ex){
                ex.printStackTrace();
            }
        }
    }

    public void editMark(String[] args) throws Exception{
        try {
            Date date = Date.valueOf(args[3]);
            stmnt=conn.prepareCall("{CALL edytuj_ocene(?,?,?,?,?,?,?)}");
            CallableStatement cs = conn.prepareCall("{CALL find_subjectID(?)}");
            CallableStatement legitymacjaCheck = conn.prepareCall("{CALL legitymacja_check(?)}");
            legitymacjaCheck.setString(1, args[1]);
            legitymacjaCheck.executeUpdate();
            ResultSet test=legitymacjaCheck.getResultSet();
            test.next();
            int check=test.getInt(1);
            if(check>0)
            {
                cs.setString(1, args[2]);
                cs.executeUpdate();
                query=cs.getResultSet();
                query.next();
                int subjectID=query.getInt(1);
                stmnt.setInt(1, Integer.parseInt(args[0]));
                stmnt.setString(2, args[1]);
                stmnt.setInt(3, id1);
                stmnt.setInt(4, subjectID);
                stmnt.setDate(5,date);
                stmnt.setFloat(6,Float.parseFloat(args[4]));
                stmnt.setString(7, args[5]);
                stmnt.execute();
                cs.close();
            }
        } catch (Exception ex){
            ex.printStackTrace();
            throw new Exception();
        } finally {
            try {
                stmnt.close();
            } catch (Exception ex){
                ex.printStackTrace();
            }
        }
    }

    public void removeMark(int id){
        try{
            stmnt = conn.prepareCall("{CALL remove_mark(?)}");
            stmnt.setInt(1, id);
            stmnt.executeUpdate();

        } catch (Exception ex){
            ex.printStackTrace();
        } finally {
            try{
                stmnt.close();
            } catch (Exception ex){
                ex.printStackTrace();
            }
        }
    }

    public void removeNote(int id){
        try{
            stmnt = conn.prepareCall("{CALL remove_note(?)}");
            stmnt.setInt(1, id);
            stmnt.executeUpdate();

        } catch (Exception ex){
            ex.printStackTrace();
        } finally {
            try{
                stmnt.close();
            } catch (Exception ex){
                ex.printStackTrace();
            }
        }
    }

    public void addNote(String[] fields)
    {
        try
        {
            stmnt=conn.prepareCall("{CALL dodaj_uwage(?,?,?,?)}");
            CallableStatement legitymacjaCheck = conn.prepareCall("{CALL legitymacja_check(?)}");
            legitymacjaCheck.setString(1, fields[0]);
            legitymacjaCheck.executeUpdate();
            ResultSet test=legitymacjaCheck.getResultSet();
            test.next();
            int check=test.getInt(1);
            if(check>0)
            {
                stmnt.setString(1, fields[0]);
                stmnt.setInt(2, id1);
                stmnt.setInt(3, Integer.parseInt(fields[1]));
                stmnt.setString(4,fields[2]);
                stmnt.execute();
            }

        } catch (Exception ex){
            ex.printStackTrace();
            //JOptionPane.showMessageDialog(null, "Niepoprawne dane", "Error", JOptionPane.ERROR_MESSAGE);
        } finally {
            try{
                stmnt.close();
            } catch (Exception ex){
                ex.printStackTrace();
            }
        }
    }

    public void editNote(String[] fields) throws Exception
    {
        try
        {
            stmnt=conn.prepareCall("{CALL edytuj_uwage(?,?,?,?,?)}");
            CallableStatement legitymacjaCheck = conn.prepareCall("{CALL legitymacja_check(?)}");
            legitymacjaCheck.setString(1, fields[1]);
            legitymacjaCheck.executeUpdate();
            ResultSet test=legitymacjaCheck.getResultSet();
            test.next();
            int check=test.getInt(1);
            if(check>0)
            {
                stmnt.setInt(1, Integer.parseInt(fields[0]));
                stmnt.setString(2, fields[1]);
                stmnt.setInt(3, id1);
                stmnt.setInt(4, Integer.parseInt(fields[2]));
                stmnt.setString(5,fields[3]);
                stmnt.execute();
            }

        } catch (Exception ex){
            ex.printStackTrace();
            throw new Exception();
        } finally {
            try{
                stmnt.close();
            } catch (Exception ex){
                ex.printStackTrace();
            }
        }
    }

}