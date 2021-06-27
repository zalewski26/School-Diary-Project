package com.zalewskiwojtczak;

import java.util.List;

public class NoteTableModelParent extends myAbstractTableModel{
    public NoteTableModelParent(List<Note> grades){
        String[] gradeColumns =  {"Imie dziecka","Nazwisko dziecka","Punkty","Imie Nauczyciela","Nazwisko Nauczyciela","Komentarz"};
        columnNames = gradeColumns;
        objects = grades;
    }

    @Override
    public Object getValueAt(int row, int col) {
        Note tempGrade = (Note) objects.get(row);
        switch (col) {
            case 0:
                return tempGrade.getFirstName2();
            case 1:
                return tempGrade.getLastName2();
            case 2:
                return tempGrade.getPoints();
            case 3:
                return tempGrade.getFirstName();
            case 4:
                return tempGrade.getLastName();
            case 5:
                return tempGrade.getComment();
            default:
                return null;
        }
    }

}