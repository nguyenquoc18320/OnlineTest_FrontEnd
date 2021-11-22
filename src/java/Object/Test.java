/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Object;
import java.sql.Date;
/**
 *
 * @author PhanSu
 */
public class Test extends BaseObject{
    private String name;
    private String description;
    private int duration;
    private int attemptnumber;
    private Course course;
        
    public Test(){
        super();
    }
    
    public Test(String name, String description, int duration, int attemptnumber, Course course, Long id, Long createdBy, Date createdDate, Long modifiedBy, Date modifiedDate){
        super(id, createdBy, createdDate, modifiedBy, modifiedDate);
        this.name = name;
        this.description = description;
        this.duration = duration;
        this.attemptnumber = attemptnumber;
        this.course = course;
        
    }
    
    public Test(String name, String description, int duration, int attemptnumber, Course course){
        super();
        this.name = name;
        this.description = description;
        this.duration = duration;
        this.attemptnumber = attemptnumber;
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

    public int getAttemptnumber() {
        return attemptnumber;
    }

    public void setAttemptnumber(int attemptnumber) {
        this.attemptnumber = attemptnumber;
    }

    public Course getCourse() {
        return course;
    }
//
//    public void setCourse(Course course) {
//        this.course = course;
//    }
	
}
