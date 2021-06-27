package com.zalewskiwojtczak;

import java.util.List;

public class NoteTableModel extends myAbstractTableModel {

    public NoteTableModel(List<Note> grades){
        String[] noteColumns =  { "Punkty", "Imie nauczyciela", "Nazwisko nauczyciela", "Komentarz"};
        columnNames = noteColumns;
        objects = grades;
    }

    @Override
    public Object getValueAt(int row, int col) {
        Note tempNote = (Note) objects.get(row);

        switch (col) {
            case 0:
                return tempNote.getPoints();
            case 1:
                return tempNote.getFirstName();
            case 2:
                return tempNote.getLastName();
            case 3:
                return tempNote.getComment();
            default:
                return null;
        }
    }
}
