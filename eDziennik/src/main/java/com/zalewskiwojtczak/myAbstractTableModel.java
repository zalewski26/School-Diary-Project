package com.zalewskiwojtczak;

import javax.swing.table.AbstractTableModel;
import java.util.List;

public abstract class myAbstractTableModel extends AbstractTableModel {
    protected String[] columnNames;
    protected List<?> objects;

    @Override
    public int getColumnCount() {
        return columnNames.length;
    }

    @Override
    public int getRowCount(){
        return objects.size();
    }

    @Override
    public String getColumnName(int col) {
        return columnNames[col];
    }

    @Override
    public Class getColumnClass(int c) {
        return getValueAt(0, c).getClass();
    }

    @Override
    public abstract Object getValueAt(int row, int col);
}