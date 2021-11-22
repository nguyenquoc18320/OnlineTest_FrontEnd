/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Object;

import java.sql.Date;
import java.util.List;

/**
 *
 * @author nguye
 */
public class User extends BaseObject{
    private String name;
    private String gender;
    private Date dateOfBirth;
    private String email;
    private String image;
    private Role role;
    private List<Question> questions ;
    public User(){
        super();
    }

    public User(String name, String gender, Date dateOfBirth, String email) {
        this.name = name;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.email = email;
    }
    public User(String name, String gender, Date dateOfBirth, String email, String image, Role role) {
        this.name = name;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.email = email;
        this.image = image;
        this.role = role;
    }

    public User(String name, String gender, Date dateOfBirth, String email, Long id, Long createdBy, Date createdDate, Long modifiedBy, Date modifiedDate, String image) {
        super(id, createdBy, createdDate, modifiedBy, modifiedDate);
        this.name = name;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.email = email;
        this.image = image;
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

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }
    
    public List<Question> getQuestions() {
        return questions;
    }

    public void setQuestions(List<Question> questions) {
        this.questions = questions;
    }
}
