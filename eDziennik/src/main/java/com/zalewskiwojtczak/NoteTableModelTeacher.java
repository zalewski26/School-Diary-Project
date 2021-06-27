package com.zalewskiwojtczak;

import java.util.List;

public class NoteTableModelTeacher extends myAbstractTableModel {

    public NoteTableModelTeacher(List<Note> notes){
        String[] noteColumns =  { "Punkty","Legitymacja","Imię","Nazwisko","Klasa","Komentarz", "IDUwagi"};
        columnNames = noteColumns;
        objects = notes;
    }

    @Override
    public Object getValueAt(int row, int col) {
        Note tempNote = (Note) objects.get(row);
        switch (col) {
            case 0:
                return tempNote.getPoints();
            case 1:
                return tempNote.getId();
            case 2:
                return tempNote.getFirstName();
            case 3:
                return tempNote.getLastName();
            case 4:
                return tempNote.getClassName();
            case 5:
                return tempNote.getComment();
            case 6:
                return tempNote.getIdUwagi();
            default:
                return null;
        }
    }
}
