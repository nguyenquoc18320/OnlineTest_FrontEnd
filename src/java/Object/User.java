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
public class User extends BaseObject{
    private String name;
    private String gender;
    private Date dateOfBirth;
    private String email;
    private Role role;

    public User(){
        super();
    }

    public User(String name, String gender, Date dateOfBirth, String email, Role role) {
        this.name = name;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.email = email;
        this.role = role;
    }

    public User(String name, String gender, Date dateOfBirth, String email, Role role, Long id, Long createdBy, Date createdDate, Long modifiedBy, Date modifiedDate) {
        super(id, createdBy, createdDate, modifiedBy, modifiedDate);
        this.name = name;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.email = email;
        this.role = role;
    }
    
    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }  

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }
    
}
