package com.zalewskiwojtczak;

import java.util.List;

public class StudentTableModel extends myAbstractTableModel {

    public StudentTableModel(List<Person> students){
        String[] studentColumns =  { "id", "Imie", "Nazwisko", "Adres", "Klasa", "Pesel", "Telefon", "Email", "Login"};
        columnNames = studentColumns;
        objects = students;
    }

    @Override
    public Object getValueAt(int row, int col) {
        Person tempPerson = (Person) objects.get(row);

        switch (col) {
            case 0:
                return tempPerson.getId();
            case 1:
                return tempPerson.getFirstName();
            case 2:
                return tempPerson.getLastName();
            case 3:
                return tempPerson.getAddress();
            case 4:
                return tempPerson.getClassOrClassrooms();
            case 5:
                return tempPerson.getPesel();
            case 6:
                return tempPerson.getPhone();
            case 7:
                return tempPerson.getEmail();
            case 8:
                return tempPerson.getLogin();
            default:
                return null;
        }
    }
}
