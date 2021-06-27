package com.zalewskiwojtczak;

import javax.swing.table.AbstractTableModel;
import java.util.List;

public class GradeTableModel extends myAbstractTableModel {

    public GradeTableModel(List<Grade> grades){
        String[] gradeColumns =  { "Ocena", "Imie nauczyciela", "Nazwisko nauczyciela", "Przedmiot", "Data", "Komentarz"};
        columnNames = gradeColumns;
        objects = grades;
    }

    @Override
    public Object getValueAt(int row, int col) {
        Grade tempGrade = (Grade) objects.get(row);
        switch (col) {
            case 0:
                return tempGrade.getNote();
            case 1:
                return tempGrade.getFirstName();
            case 2:
                return tempGrade.getLastName();
            case 3:
                return tempGrade.getSubject();
            case 4:
                return tempGrade.getDate();
            case 5:
                return tempGrade.getComment();
            default:
                return null;
        }
    }
}