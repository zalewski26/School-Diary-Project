package com.zalewskiwojtczak;

import java.util.List;

public class TableModelCreator {
    public myAbstractTableModel getTableModel(String type, List<Person> people){
        if (type.equalsIgnoreCase("Uczeń")){
            return new StudentTableModel(people);
        }
        else if (type.equalsIgnoreCase("Nauczyciel")){
            return new TeacherTableModel(people);
        }
        else if (type.equalsIgnoreCase("Opiekun")){
            return new ParentTableModel(people);
        }
        else if (type.equalsIgnoreCase("Admin")){
            return new AdminTableModel(people);
        }
        else
            return null;
    }
}
