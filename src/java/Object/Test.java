/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Object;

import java.util.Date;

/**
 *
 * @author PhanSu
 */
public class Test extends BaseObject{
    private String name;
    private String description;
    private int duration;
    private boolean status;
    private Date start;
    private Date end;
    private int attemptnumber;
    private boolean deleted;
    private Course course;
        
    public Test(){
        super();
    }
    
    public Test(String name, String description, int duration, Date start, Date end, boolean status, int attemptnumber, boolean deleted, Course course, Long id, Long createdBy, Date createdDate, Long modifiedBy, Date modifiedDate){
        super(id, createdBy, createdDate, modifiedBy, modifiedDate);
        this.name = name;
        this.description = description;
        this.duration = duration;
        this.start = start;
        this.end = end;
        this.status = status;
        this.attemptnumber = attemptnumber;
        this.deleted = deleted;
        this.course = course;
        
    }
    
    public Test(String name, String description, int duration, Date start, Date end, boolean status, int attemptnumber, boolean deleted, Course course){
        super();
        this.name = name;
        this.description = description;
        this.duration = duration;
        this.start = start;
        this.end = end;
        this.status = status;
        this.attemptnumber = attemptnumber;
        this.deleted = deleted;
        this.course = course;
        
    }
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }
    
    
    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public int getAttemptnumber() {
        return attemptnumber;
    }

    public void setAttemptnumber(int attemptnumber) {
        this.attemptnumber = attemptnumber;
    }
    
    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }
    
    public Course getCourse() {
        return course;
    }

    public Date getStart() {
        return start;
    }

    public void setStart(Date start) {
        this.start = start;
    }

    public Date getEnd() {
        return end;
    }

    public void setEnd(Date end) {
        this.end = end;
    }
	
    
}
