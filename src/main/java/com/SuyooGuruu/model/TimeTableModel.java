package com.SuyooGuruu.model;

public class TimeTableModel {
    private Long id;
    private Long teacherId;
    private String teacherName; // For display (FirstName + LastName)
    private String day;
    private String startTime;
    private String endTime;
    private String subject;
    private String room;

    // Default constructor
    public TimeTableModel() {}

    // Constructor
    public TimeTableModel(Long id, Long teacherId, String teacherName, String day, String startTime, String endTime, String subject, String room) {
        this.id = id;
        this.teacherId = teacherId;
        this.teacherName = teacherName;
        this.day = day;
        this.startTime = startTime;
        this.endTime = endTime;
        this.subject = subject;
        this.room = room;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getTeacherId() { return teacherId; }
    public void setTeacherId(Long teacherId) { this.teacherId = teacherId; }
    public String getTeacherName() { return teacherName; }
    public void setTeacherName(String teacherName) { this.teacherName = teacherName; }
    public String getDay() { return day; }
    public void setDay(String day) { this.day = day; }
    public String getStartTime() { return startTime; }
    public void setStartTime(String startTime) { this.startTime = startTime; }
    public String getEndTime() { return endTime; }
    public void setEndTime(String endTime) { this.endTime = endTime; }
    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }
    public String getRoom() { return room; }
    public void setRoom(String room) { this.room = room; }
}