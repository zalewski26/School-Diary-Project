package com.zalewskiwojtczak;

import java.util.Date;

public class Grade {
    private float note;
    private int gradeId;
    private String id; //
    private String firstname;
    private String lastname;
    private String firstname2;
    private String lastname2;
    private String className; //
    private String subject;
    private Date date;
    private String comment;

    Grade(int gradeId, float note, String firstname, String lastname, String subject, Date date, String comment) {
        this.gradeId = gradeId;
        this.note = note;
        this.firstname = firstname;
        this.lastname = lastname;
        this.subject = subject;
        this.date = date;
        this.comment = comment;
    }

    Grade(int gradeId, float note, String id, String firstname, String lastname, String className, String subject, Date date, String comment) {
        this.gradeId = gradeId;
        this.note = note;
        this.id = id;
        this.firstname = firstname;
        this.lastname = lastname;
        this.className = className;
        this.subject = subject;
        this.date = date;
        this.comment = comment;
    }

    Grade( int gradeId, String firstname2,String lastname2, float note,
                    String firstname, String lastname, String subject, Date date, String comment)
    {
        this.gradeId = gradeId;
        this.note = note;
        this.firstname = firstname;
        this.lastname = lastname;
        this.firstname2 = firstname2;
        this.lastname2 = lastname2;
        this.subject = subject;
        this.date = date;
        this.comment = comment;
    }

    public int getGradeId(){
        return gradeId;
    }

    public float getNote(){
        return note;
    }

    public String getId(){
        return id;
    }

    public String getFirstName(){
        return firstname;
    }

    public String getLastName(){
        return lastname;
    }

    public String getFirstName2(){
        return firstname2;
    }

    public String getLastName2(){
        return lastname2;
    }

    public String getSubject(){
        return subject;
    }

    public String getClassName(){
        return className;
    }

    public Date getDate(){
        return date;
    }

    public String getComment(){
        return comment;
    }
}

