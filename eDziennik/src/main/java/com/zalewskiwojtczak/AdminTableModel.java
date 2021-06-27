package com.zalewskiwojtczak;

import java.util.List;

public class AdminTableModel extends myAbstractTableModel {

    public AdminTableModel(List<Person> students){
        String[] studentColumns =  { "id", "Imie", "Nazwisko", "Adres", "Pesel", "Telefon", "Email", "Login"};
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
                return tempPerson.getPesel();
            case 5:
                return tempPerson.getPhone();
            case 6:
                return tempPerson.getEmail();
            case 7:
                return tempPerson.getLogin();
            default:
                return null;
        }
    }
}
