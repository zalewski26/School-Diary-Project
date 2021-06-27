package com.zalewskiwojtczak;

import java.util.List;

public class StudentTableModelTeacher extends myAbstractTableModel {

    public StudentTableModelTeacher(List<Person> students){
        String[] studentColumns =  {"Legitymacja","Imię","Nazwisko","Klasa"};
        columnNames = studentColumns;
        objects = students;
    }

    @Override
    public Object getValueAt(int row, int col) {
        Person tempStudent = (Person) objects.get(row);
        switch (col) {
            case 0:
                return tempStudent.getId();
            case 1:
                return tempStudent.getFirstName();
            case 2:
                return tempStudent.getLastName();
            case 3:
                return tempStudent.getClassName();
            default:
                return null;
        }
    }
}