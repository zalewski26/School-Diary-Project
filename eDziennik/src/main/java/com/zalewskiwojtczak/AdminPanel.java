package com.zalewskiwojtczak;

import javax.swing.*;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import java.awt.*;
import java.util.List;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class AdminPanel extends JPanel {
    private final AdminDataConnect connector;
    private String type;
    private int removeOption = -1;
    private final JTable table;
    private myAbstractTableModel model;
    JTextField lastnameField;
    JTextField firstnameField;

    public AdminPanel(DataConnect dataConnector){
        this.connector = (AdminDataConnect) dataConnector;
        setLayout(new BorderLayout());

        JPanel panelUp = new JPanel();
        JButton[] buttons = {new JButton("Uczniowie"), new JButton("Nauczyciele"), new JButton("Opiekunowie"), new JButton("Administratorzy")};
        panelUp.add(new JLabel("Imię"));
        firstnameField = new JTextField(10);
        panelUp.add(firstnameField);
        panelUp.add(new JLabel("Nazwisko"));
        lastnameField = new JTextField(10);
        panelUp.add(lastnameField);
        panelUp.add(buttons[0]);
        panelUp.add(buttons[1]);
        panelUp.add(buttons[2]);
        panelUp.add(buttons[3]);
        add(panelUp, BorderLayout.NORTH);

        JPanel panelDown = new JPanel();
        JButton addUser = new JButton("Dodaj użytkownika");
        JButton backup = new JButton("Backup");
        panelDown.add(backup);
        panelDown.add(addUser);
        add(panelDown, BorderLayout.SOUTH);

        JScrollPane scrollPane = new JScrollPane();
        add(scrollPane, BorderLayout.CENTER);
        table = new JTable();
        scrollPane.add(table);
        scrollPane.setViewportView(table);

        buttons[0].addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                type = "Uczeń";
                performAction(type);
            }
        });
        buttons[1].addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                type = "Nauczyciel";
                performAction(type);
            }
        });
        buttons[2].addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                type = "Opiekun";
                performAction(type);
            }
        });
        buttons[3].addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                type = "Admin";
                performAction(type);
            }
        });

        backup.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent actionEvent) {
                try{
                    Object[] options = {"Wykonaj backup", "Wczytaj backup", "Wróć"};
                    int option = JOptionPane.showOptionDialog(null, "Wybierz opcję", "Backup", JOptionPane.YES_NO_CANCEL_OPTION,
                            JOptionPane.PLAIN_MESSAGE, null, options , null);
                    if (option == JOptionPane.YES_OPTION){
                        String result = JOptionPane.showInputDialog(AdminPanel.this, "Podaj ścieżkę i nazwę pliku", "Tworzenie kopii zapasowej", JOptionPane.PLAIN_MESSAGE);
                        String command = "mysqldump -u admin -padmin dziennik2 > " + result;
                        Runtime.getRuntime().exec(new String[] {"/bin/bash", "-c", command });
                        JOptionPane.showMessageDialog(AdminPanel.this, "Utworzono pomyślnie!", "Backup", JOptionPane.INFORMATION_MESSAGE);
                    }
                    else if (option == JOptionPane.NO_OPTION){
                        String result = JOptionPane.showInputDialog(AdminPanel.this, "Podaj ścieżkę i nazwę pliku", "Wczytywanie kopii zapasowej", JOptionPane.PLAIN_MESSAGE);
                        String command = "mysql -u admin -padmin dziennik2 < " + result;
                        Runtime.getRuntime().exec(new String[] {"/bin/bash", "-c", command });
                        JOptionPane.showMessageDialog(AdminPanel.this, "Wczytano pomyślnie!", "Backup", JOptionPane.INFORMATION_MESSAGE);
                        performAction(type);
                    }
                } catch (Exception ex){
                    JOptionPane.showMessageDialog(AdminPanel.this, "Nieudany backup", "Błąd", JOptionPane.ERROR_MESSAGE);
                }
            }
        });

        addUser.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                try {
                    JPanel addPanel = new JPanel();
                    addPanel.setLayout(new GridLayout(0, 1));
                    JTextField[] fields = { new JTextField(10), new JTextField(10), new JTextField(10), new JTextField(10),
                            new JTextField(10), new JTextField(10), new JTextField(10), new JTextField(10),
                            new JTextField(10), new JTextField(10), new JTextField(10)};
                    JLabel[] labels = { new JLabel("rodzaj użytkownika"), new JLabel("id"), new JLabel("imie"), new JLabel("nazwisko"),
                            new JLabel("adres"), new JLabel("klasa/gabinet/-"), new JLabel("pesel"), new JLabel("numer telefonu"),
                            new JLabel("email"), new JLabel("login"), new JLabel("hasło")};
                    for (int i = 0; i < 11; i++){
                        addPanel.add(labels[i]);
                        addPanel.add(fields[i]);
                    }
                    int result = JOptionPane.showConfirmDialog(null, addPanel, "Dodaj użytkownika", JOptionPane.OK_CANCEL_OPTION);
                    if (result == JOptionPane.OK_OPTION){
                        try{
                            String[] args = {fields[0].getText(), fields[1].getText(), fields[2].getText(), fields[3].getText(), fields[4].getText(),
                                    fields[5].getText(), fields[6].getText(), fields[7].getText(), fields[8].getText(), fields[9].getText(), fields[10].getText()};
                            connector.createUser(args);
                            JOptionPane.showMessageDialog(AdminPanel.this, "Dodano użytkownika",
                                    fields[2].getText() + " " + fields[3].getText(), JOptionPane.INFORMATION_MESSAGE);
                        } catch (Exception ex){
                            ex.printStackTrace();
                            JOptionPane.showMessageDialog(AdminPanel.this, "Nieprawidłowe dane", "Błąd", JOptionPane.ERROR_MESSAGE);
                        }
                    }
                } catch (Exception exc) {
                    JOptionPane.showMessageDialog(AdminPanel.this, "Error: " + exc, "Error", JOptionPane.ERROR_MESSAGE);
                }
            }
        });

        table.getSelectionModel().addListSelectionListener(new ListSelectionListener(){
            public void valueChanged(ListSelectionEvent event) {
                if (!event.getValueIsAdjusting() && table.getSelectedRow() != -1){
                    int option = JOptionPane.showConfirmDialog(AdminPanel.this, "Czy chcesz edytować/usunąć użytkownika?",
                            table.getValueAt(table.getSelectedRow(), 1) + " " + table.getValueAt(table.getSelectedRow(), 2), JOptionPane.OK_CANCEL_OPTION);
                    if (option == JOptionPane.OK_OPTION){
                        JPanel addPanel = new JPanel();
                        addPanel.setLayout(new GridLayout(0, 1));
                        JTextField[] fields = new JTextField[8];
                        if (type.equals("Uczeń") || type.equals("Nauczyciel")) {
                            fields[0] = new JTextField(String.valueOf(table.getValueAt(table.getSelectedRow(), 0)));
                            fields[1] = new JTextField(String.valueOf(table.getValueAt(table.getSelectedRow(), 1)));
                            fields[2] = new JTextField(String.valueOf(table.getValueAt(table.getSelectedRow(), 2)));
                            fields[3] = new JTextField(String.valueOf(table.getValueAt(table.getSelectedRow(), 3)));
                            fields[4] = new JTextField(String.valueOf(table.getValueAt(table.getSelectedRow(), 4)));
                            fields[5] = new JTextField(String.valueOf(table.getValueAt(table.getSelectedRow(), 5)));
                            fields[6] = new JTextField(String.valueOf(table.getValueAt(table.getSelectedRow(), 6)));
                            fields[7] = new JTextField(String.valueOf(table.getValueAt(table.getSelectedRow(), 7)));
                        }
                        else{
                            fields[0] = new JTextField(String.valueOf(table.getValueAt(table.getSelectedRow(), 0)));
                            fields[1] = new JTextField(String.valueOf(table.getValueAt(table.getSelectedRow(), 1)));
                            fields[2] = new JTextField(String.valueOf(table.getValueAt(table.getSelectedRow(), 2)));
                            fields[3] = new JTextField(String.valueOf(table.getValueAt(table.getSelectedRow(), 3)));
                            fields[4] = new JTextField(0);
                            fields[5] = new JTextField(String.valueOf(table.getValueAt(table.getSelectedRow(), 4)));
                            fields[6] = new JTextField(String.valueOf(table.getValueAt(table.getSelectedRow(), 5)));
                            fields[7] = new JTextField(String.valueOf(table.getValueAt(table.getSelectedRow(), 6)));
                        }
                        JLabel[] labels = { new JLabel("id"), new JLabel("imie"), new JLabel("nazwisko"),
                                new JLabel("adres"), new JLabel("klasa/gabinet/-"), new JLabel("pesel"), new JLabel("numer telefonu"), new JLabel("email")};
                        for (int i = 0; i < 8; i++){
                            if ((type.equals("Opiekun") || type.equals("Admin")) && i == 4)
                                continue;
                            addPanel.add(labels[i]);
                            addPanel.add(fields[i]);
                        }
                        addPanel.add(Box.createVerticalStrut(5));
                        Object[] options = {"Zatwierdź", "Usuń użytkownika", "Wróć"};
                        int result = JOptionPane.showOptionDialog(null, addPanel, type, JOptionPane.YES_NO_CANCEL_OPTION,
                                JOptionPane.PLAIN_MESSAGE, null, options , null);
                        if (result == JOptionPane.YES_OPTION){
                            try {
                                connector.editUser(type, String.valueOf(table.getValueAt(table.getSelectedRow(), 0)),
                                        fields[0].getText(), fields[1].getText(), fields[2].getText(), fields[3].getText(),
                                        fields[4].getText(), fields[5].getText(), fields[6].getText(), fields[7].getText());
                                JOptionPane.showMessageDialog(AdminPanel.this, "Edytowano użytkownika",
                                        table.getValueAt(table.getSelectedRow(), 1) + " " + table.getValueAt(table.getSelectedRow(), 2), JOptionPane.INFORMATION_MESSAGE);
                            } catch (Exception ex){
                                JOptionPane.showMessageDialog(AdminPanel.this, "Nieprawidłowe dane", "Błąd", JOptionPane.ERROR_MESSAGE);
                            }
                        }
                        else if (result == JOptionPane.NO_OPTION){
                            int opt = JOptionPane.showConfirmDialog(AdminPanel.this, "Na pewno usunąć użytkownika?",
                                    table.getValueAt(table.getSelectedRow(), 1) + " " + table.getValueAt(table.getSelectedRow(), 2), JOptionPane.OK_CANCEL_OPTION);
                            if (opt == JOptionPane.OK_OPTION){
                                connector.removeUser(type, String.valueOf(table.getValueAt(table.getSelectedRow(), 0)));
                                JOptionPane.showMessageDialog(AdminPanel.this, "Usunięto użytkownika",
                                        table.getValueAt(table.getSelectedRow(), 1) + " " + table.getValueAt(table.getSelectedRow(), 2), JOptionPane.INFORMATION_MESSAGE);
                            }
                        }
                        performAction(type);
                    }
                }
            }
        });
    }

    private void performAction(String type){
        try {
            List<Person> people = null;
            people = connector.showAll(type, firstnameField.getText(), lastnameField.getText());
            TableModelCreator creator = new TableModelCreator();
            model = creator.getTableModel(type, people);
            table.setModel(model);

        } catch (Exception exc) {
            JOptionPane.showMessageDialog(AdminPanel.this, "Error: " + exc, "Error", JOptionPane.ERROR_MESSAGE);
        }
    }
}
