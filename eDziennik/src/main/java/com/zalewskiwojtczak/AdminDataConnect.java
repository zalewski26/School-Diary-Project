package com.zalewskiwojtczak;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminDataConnect extends DataConnect {
    private final String userLogin;
    private final String userPassword;
    private boolean connection = true;
    private List<Person> people;

    public AdminDataConnect(String loginA, String passwordA, String userlogin, String userpassword) throws Exception {
        conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/dziennik2?noAccessToProcedureBodies=true",
                loginA, passwordA);

        this.userLogin= userlogin;
        this.userPassword = userpassword;
        CallableStatement cs = (CallableStatement) conn.prepareCall("{CALL user_detail(?,?,?)}");
        cs.setString(1, userLogin);
        cs.setString(2, userPassword);
        cs.registerOutParameter(3, java.sql.Types.VARCHAR);
        cs.executeUpdate();
        String resultado = cs.getString(3);
        if(resultado == null || !resultado.equals("Administrator"))
        {
            connection=false;
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
        CallableStatement cs = (CallableStatement) conn.prepareCall("{CALL admin_id(?,?,?)}");
        cs.setString(1, userLogin);
        cs.setString(2, userPassword);
        cs.registerOutParameter(3, java.sql.Types.INTEGER);
        cs.executeUpdate();
        int resultado = cs.getInt(3);
        return resultado;
    }

    public List<Person> showAll(String type, String firstName, String lastName){
        people = new ArrayList<>();
        if (firstName.length() == 0)
            firstName = "%";
        if (lastName.length() == 0)
            lastName = "%";
        try {
            if (type.equalsIgnoreCase("Uczeń")){
                stmnt = conn.prepareCall("{CALL show_students(?,?)}");
            }
            else if (type.equalsIgnoreCase("Nauczyciel")){
                stmnt = conn.prepareCall("{CALL show_teachers(?,?)}");
            }
            else if (type.equalsIgnoreCase("Opiekun")){
                stmnt = conn.prepareCall("{CALL show_parents(?,?)}");
            }
            else if (type.equalsIgnoreCase("Admin")){
                stmnt = conn.prepareCall("{CALL show_admins(?,?)}");
            }
            stmnt.setString(1, firstName);
            stmnt.setString(2, lastName);
            query = stmnt.executeQuery();
            while (query.next()) {
                Person tempPerson = new Person(query.getString(1), query.getString(2),
                        query.getString(3), query.getString(4), query.getInt(5),
                        query.getString(6), query.getInt(7), query.getString(8), query.getString(9));
                people.add(tempPerson);
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
        return people;
    }

    public void createUser(String[] args) throws Exception{
        CallableStatement loginCheck = conn.prepareCall("{CALL login_check(?)}");
        if (args[0].equals("Uczeń") || args[0].equals("Nauczyciel")){
            loginCheck.setString(1, args[8]);
        }
        else{
            loginCheck.setString(1, args[6]);
        }
        loginCheck.executeUpdate();
        ResultSet test=loginCheck.getResultSet();
        test.next();
        System.out.println(test.getInt(1));
        if(test.getInt(1) > 0){
            throw new Exception();
        }
        for (int i = 0; i < args.length; i++){
            if (i != 5 && args[i].length() == 0){
                throw new Exception();
            }
        }
        try{
            /*String PESEL=args[6];
            String phone=args[7];
            int[] digits = new int[11];
            if(phone.length()!=9 && PESEL.length()!=11)
            {
                throw new Exception();
            }
            for(int i=0;i<phone.length();i++)
            {
                char c=phone.charAt(i);
                if(!Character.isDigit(c))
                {
                    throw new Exception();
                }
            }
            for(int i=0;i<11;i++){
                digits[i] = Integer.parseInt(PESEL.substring(i, i + 1));
            }
            int[] weights = {1,3,7,9,1,3,7,9,1,3};
            int check = 0;
            for(int i=0;i<10;i++){
                check += weights[i]*digits[i];
            }
            int lastNumber = check % 10;
            int controlNumber = 10 - lastNumber;*/
            if (/*controlNumber == digits[10]*/true) {
                if (args[0].equals("Uczeń") || args[0].equals("Nauczyciel")){
                    if (args[5].length() == 0){
                        throw new Exception();
                    }
                    if (args[0].equals("Uczeń")){
                        stmnt = conn.prepareCall("{CALL dodaj_ucznia(?,?,?,?,?,?,?,?,?,?)}");
                    }
                    else{
                        stmnt = conn.prepareCall("{CALL dodaj_nauczyciela(?,?,?,?,?,?,?,?,?,?)}");
                    }

                    stmnt.setString(1, args[1]);
                    stmnt.setString(2, args[2]);
                    stmnt.setString(3, args[3]);
                    stmnt.setInt(4, Integer.parseInt(args[4]));
                    stmnt.setInt(5, Integer.parseInt(args[5]));
                    stmnt.setString(6, args[6]);
                    stmnt.setString(7, args[7]);
                    stmnt.setString(8, args[8]);
                    stmnt.setString(9, args[9]);
                    stmnt.setString(10, args[10]);
                    stmnt.executeUpdate();
                    if (args[0].equals("Uczeń")){
                        stmnt = conn.prepareCall("{CALL create_behaviour(?)}");
                        stmnt.setString(1, args[1]);
                        stmnt.executeUpdate();
                    }
                }
                else if (args[0].equals("Opiekun") || args[0].equals("Admin")){
                    if (args[0].equals("Opiekun")){
                        stmnt = conn.prepareCall("{CALL dodaj_opiekuna(?,?,?,?,?,?,?,?)}");
                    }
                    else{
                        stmnt = conn.prepareCall("{CALL dodaj_administratora(?,?,?,?,?,?,?,?)}");
                    }
                    //stmnt.setString(1, args[1]);
                    stmnt.setString(1, args[2]);
                    stmnt.setString(2, args[3]);
                    stmnt.setInt(3, Integer.parseInt(args[4]));
                    stmnt.setString(4, args[6]);
                    stmnt.setString(5, args[7]);
                    stmnt.setString(6, args[8]);
                    stmnt.setString(7, args[9]);
                    stmnt.setString(8, args[10]);
                    stmnt.executeUpdate();
                }
                else
                {
                    throw new Exception();
                }
            }
            else
            {
                throw new Exception();
            }
        } catch (Exception ex ){
            ex.printStackTrace();
            throw new Exception();
        }

    }

    public void editUser(String type, String currentID, String id, String firstname, String lastname, String address,
                         String class_, String pesel, String phone, String mail) throws Exception{
        try {
            /*String PESEL=pesel;
            int[] digits = new int[11];
            if(phone.length()!=9 || PESEL.length()!=11)
            {
                System.out.println("Siema");
                throw new Exception();
            }
            for(int i=0;i<phone.length();i++)
            {
                char c=phone.charAt(i);
                if(!Character.isDigit(c))
                {
                    throw new Exception();
                }
            }
            for(int i=0;i<11;i++){
                digits[i] = Integer.parseInt(PESEL.substring(i, i + 1));
            }
            int[] weights = {1,3,7,9,1,3,7,9,1,3};
            int check = 0;
            for(int i=0;i<10;i++){
                check += weights[i]*digits[i];
            }
            int lastNumber = check % 10;
            int controlNumber = 10 - lastNumber;*/
            if (/*controlNumber == digits[10]*/true)
            {
                if (type.equals("Uczeń") || type.equals("Nauczyciel")) {
                    if (type.equals("Uczeń")){
                        stmnt = conn.prepareCall("{CALL edit_student(?,?,?,?,?,?,?,?,?)}");
                    }
                    else{
                        stmnt = conn.prepareCall("{CALL edit_teacher(?,?,?,?,?,?,?,?,?)}");
                    }
                    stmnt.setString(1, currentID);
                    stmnt.setString(2, id);
                    stmnt.setString(3, firstname);
                    stmnt.setString(4, lastname);
                    stmnt.setInt(5, Integer.parseInt(address));
                    stmnt.setInt(6, Integer.parseInt(class_));
                    stmnt.setString(7, pesel);
                    stmnt.setString(8, phone);
                    stmnt.setString(9, mail);
                    stmnt.executeUpdate();
                }
                else{
                    if (type.equals("Opiekun")){
                        stmnt = conn.prepareCall("{CALL edit_parent(?,?,?,?,?,?,?,?)}");
                    }
                    else{
                        stmnt = conn.prepareCall("{CALL edit_admin(?,?,?,?,?,?,?,?)}");
                    }
                    stmnt.setString(1, currentID);
                    stmnt.setString(2, id);
                    stmnt.setString(3, firstname);
                    stmnt.setString(4, lastname);
                    stmnt.setInt(5, Integer.parseInt(address));
                    stmnt.setString(6, pesel);
                    stmnt.setString(7, phone);
                    stmnt.setString(8, mail);
                    stmnt.executeUpdate();
                }
            }
            else
            {
                throw new Exception();
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

    public void removeUser(String type, String id){
        try{
            if (type.equals("Uczeń")){
                stmnt = conn.prepareCall("{CALL remove_student(?)}");
            }
            else if (type.equals("Nauczyciel")){
                stmnt = conn.prepareCall("{CALL remove_teacher(?)}");
            }
            else if (type.equals("Opiekun")){
                stmnt = conn.prepareCall("{CALL remove_parent(?)}");
            }
            else{
                stmnt = conn.prepareCall("{CALL remove_admin(?)}");
            }
            stmnt.setString(1, id);
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
}

