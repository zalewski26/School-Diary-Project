package com.zalewskiwojtczak;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.List;

public class StudentPanel extends JPanel {
    private StudentDataConnect connector1;
    private final JTable table;

    public StudentPanel(DataConnect connector) {
        connector1 = (StudentDataConnect) connector;
        setLayout(new BorderLayout());
        JPanel panel = new JPanel();
        add(panel, BorderLayout.NORTH);

        JLabel label = new JLabel("Przedmiot:");
        final JTextField textField = new JTextField(10);
        JButton button1 = new JButton("Oceny");
        JButton buttonAvg = new JButton("Średnia");
        JButton button2 = new JButton("Uwagi");
        JButton button3 = new JButton("Zachowanie");

        panel.add(label);
        panel.add(textField);
        panel.add(button1);
        panel.add(buttonAvg);
        panel.add(button2);
        panel.add(button3);

        JScrollPane scrollPane = new JScrollPane();
        add(scrollPane, BorderLayout.CENTER);
        table = new JTable();
        scrollPane.add(table);
        scrollPane.setViewportView(table);

        button1.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent actionEvent) {
                try {
                    List<Grade> grades = null;
                    if ((grades = connector1.showGrades(textField.getText())) == null) {
                        throw new Exception();
                    }
                    GradeTableModel model = new GradeTableModel(grades);
                    table.setModel(model);

                } catch (Exception exc) {
                    exc.printStackTrace();
                    JOptionPane.showMessageDialog(StudentPanel.this, "Error: " + exc, "Error", JOptionPane.ERROR_MESSAGE);
                }
            }
        });

        buttonAvg.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent actionEvent) {
                JOptionPane.showMessageDialog(StudentPanel.this, connector1.getAverage(textField.getText()), "Średnia", JOptionPane.INFORMATION_MESSAGE);
            }
        });

        button2.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent actionEvent) {
                try {
                    List<Note> notes = null;
                    if ((notes = connector1.showNotes()) == null) {
                        throw new Exception();
                    }
                    NoteTableModel model = new NoteTableModel(notes);
                    table.setModel(model);

                } catch (Exception exc) {
                    JOptionPane.showMessageDialog(StudentPanel.this, "Error: " + exc, "Error", JOptionPane.ERROR_MESSAGE);
                }
            }
        });

        button3.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent actionEvent) {
                JOptionPane.showMessageDialog(StudentPanel.this, "Punkty: " + connector1.getBehaviour(), "Zachowanie", JOptionPane.INFORMATION_MESSAGE);
            }
        });
    }
}
