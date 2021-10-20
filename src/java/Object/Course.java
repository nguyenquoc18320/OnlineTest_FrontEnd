/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Object;

import java.util.Date;

/**
 *
 * @author nguye
 */
public class Course extends BaseObject{
    private String name;
    private String description;
    private boolean status;
    
    private User user;

    public Course(){
        super();
    }

    public Course(String name, String description, boolean status, User user, Long id, Long createdBy, Date createdDate, Long modifiedBy, Date modifiedDate) {
        super(id, createdBy, createdDate, modifiedBy, modifiedDate);
        this.name = name;
        this.description = description;
        this.status = status;
        this.user = user;
    }

    public Course(String name, String description, boolean status, User user) {
        super();
        this.name = name;
        this.description = description;
        this.status = status;
        this.user = user;
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

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
    
    
}
