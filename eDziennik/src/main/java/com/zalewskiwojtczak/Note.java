package com.zalewskiwojtczak;

public class Note {
    private int points;
    private int idUwagi;
    private String id;
    private String firstname;
    private String lastname;
    private String firstname2;
    private String lastname2;
    private String className;
    private String comment;

    public Note(int points, String firstname, String lastname, String comment) {
        this.points = points;
        this.firstname = firstname;
        this.lastname = lastname;
        this.comment = comment;
    }

    public Note(int idUwagi, int points, String id, String firstame, String lastname, String className, String comment) {
        this.idUwagi = idUwagi;
        this.points = points;
        this.id = id;
        this.firstname = firstame;
        this.lastname = lastname;
        this.className=className;
        this.comment = comment;
    }

    public Note(String firstname2, String lastname2, int points, String firstname,
                   String lastname, String comment)
    {
        this.points = points;
        this.firstname = firstname;
        this.lastname = lastname;
        this.firstname2 = firstname2;
        this.lastname2 = lastname2;
        this.comment = comment;
    }

    public int getPoints() {
        return points;
    }

    public String getId(){
        return id;
    }

    public int getIdUwagi(){
        return idUwagi;
    }

    public String getFirstName() {
        return firstname;
    }

    public String getLastName() {
        return lastname;
    }

    public String getFirstName2() {
        return firstname2;
    }

    public String getLastName2() {
        return lastname2;
    }

    public String getClassName(){
        return className;
    }

    public String getComment() {
        return comment;
    }
}

