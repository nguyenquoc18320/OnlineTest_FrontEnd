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
public class Course extends BaseObject {

    private String name;
    private String description;
    private boolean status;
    private boolean blocked;
    private boolean deleted;

    private User user;

    public Course() {
        super();
    }

    public Course(String name, String description, boolean status, boolean blocked, boolean deleted, User user, Long id, Long createdBy, Date createdDate, Long modifiedBy, Date modifiedDate) {
        super(id, createdBy, createdDate, modifiedBy, modifiedDate);
        this.name = name;
        this.description = description;
        this.status = status;
        this.blocked = blocked;
        this.deleted = deleted;
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

    public boolean getStatus() {
        return status;
    }

//    public void setStatus(boolean status) {
//        this.status = status;
//    }
    public User getUser() {
        return user;
    }
    
    

//    public void setUser(User user) {
//        this.user = user;
//    }
//    

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public boolean getBlocked() {
        return blocked;
    }

    public void setBlocked(boolean blocked) {
        this.blocked = blocked;
    }

    public boolean getDeleted() {
        return deleted;
    }

    public void setDelete(boolean deleted) {
        this.deleted = deleted;
    }
}
