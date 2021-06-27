package com.zalewskiwojtczak;

import java.util.List;

public class GradeTableModelParent extends myAbstractTableModel{

    public GradeTableModelParent(List<Grade> grades){
        String[] gradeColumns =  { "Imie dziecka","Nazwisko dziecka","Ocena","Imie Nauczyciela", "Nazwisko Nauczyciela","Przedmiot", "Data", "Komentarz"};
        columnNames = gradeColumns;
        objects = grades;
    }

    @Override
    public Object getValueAt(int row, int col) {
        Grade tempGrade = (Grade) objects.get(row);
        switch (col) {
            case 0:
                return tempGrade.getFirstName2();
            case 1:
                return tempGrade.getLastName2();
            case 2:
                return tempGrade.getNote();
            case 3:
                return tempGrade.getFirstName();
            case 4:
                return tempGrade.getLastName();
            case 5:
                return tempGrade.getSubject();
            case 6:
                return tempGrade.getDate();
            case 7:
                return tempGrade.getComment();
            default:
                return null;
        }
    }

}