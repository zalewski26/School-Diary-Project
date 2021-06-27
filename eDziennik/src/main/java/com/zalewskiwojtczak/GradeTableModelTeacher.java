package com.zalewskiwojtczak;

import java.util.List;

public class GradeTableModelTeacher extends myAbstractTableModel {

    public GradeTableModelTeacher(List<Grade> grades){
        String[] gradeColumns =  { "Ocena","Legitymacja", "Imie ucznia", "Nazwisko ucznia", "Klasa" ,"Przedmiot", "Data", "Komentarz", "IDOceny"};
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
                return tempGrade.getId();
            case 2:
                return tempGrade.getFirstName();
            case 3:
                return tempGrade.getLastName();
            case 4:
                return tempGrade.getClassName();
            case 5:
                return tempGrade.getSubject();
            case 6:
                return tempGrade.getDate();
            case 7:
                return tempGrade.getComment();
            case 8:
                return tempGrade.getGradeId();
            default:
                return null;
        }
    }
}