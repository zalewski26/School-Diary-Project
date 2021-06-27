package com.zalewskiwojtczak;

import java.util.List;

public class BehaviourTableModel extends myAbstractTableModel{

    public BehaviourTableModel(List<Behaviour> grades){
        String[] gradeColumns =  { "Imie dziecka","Imie nazwisko","Punkty"};
        columnNames = gradeColumns;
        objects = grades;
    }

    @Override
    public Object getValueAt(int row, int col) {
        Behaviour tempGrade = (Behaviour ) objects.get(row);
        switch (col) {
            case 0:
                return tempGrade.getStudentName();
            case 1:
                return tempGrade.getStudentSurname();
            case 2:
                return tempGrade.getPoints();
            default:
                return null;
        }
    }

}