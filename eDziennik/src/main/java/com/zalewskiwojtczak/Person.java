package com.zalewskiwojtczak;

public class Person {
    private String id;
    private String firstname;
    private String lastname;
    private String address;
    private int classOrClassroom;
    private String className;
    private String pesel;
    private int phone;
    private String email;
    private String login;

    public Person(String id, String firstname, String lastname, String address, int classOrClassroom,
                   String pesel, int phone, String email, String login){
        this.id = id;
        this.firstname = firstname;
        this.lastname = lastname;
        this.address = address;
        this.classOrClassroom = classOrClassroom;
        this.pesel = pesel;
        this.phone = phone;
        this.email = email;
        this.login = login;
    }

    public Person(String id, String firstame, String lastname, String className)
    {
        this.id = id;
        this.firstname = firstame;
        this.lastname = lastname;
        this.className = className;
    }

    public String getId() {
        return id;
    }

    public String getFirstName() {
        return firstname;
    }

    public String getLastName() {
        return lastname;
    }

    public String getAddress() {
        return address;
    }

    public int getClassOrClassrooms() {
        return classOrClassroom;
    }

    public String getClassName(){
        return className;
    }

    public String getPesel() {
        return pesel;
    }

    public int getPhone() {
        return phone;
    }

    public String getEmail() {
        return email;
    }

    public String getLogin(){
        return login;
    }
}
