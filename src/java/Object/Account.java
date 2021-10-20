/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Object;

/**
 *
 * @author nguye
 */
public class Account extends BaseObject{
    private String password;
    private String status;
    private User user;

    public Account(){
        super();
    }   
    

    public Account(String password, String status, User user) {
        this.password = password;
        this.status = status;
        this.user = user;
    }
   
    
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
    
    
}
