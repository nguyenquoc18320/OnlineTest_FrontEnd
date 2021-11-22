/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Object;

/**
 *
 * @author PhanSu
 */
public class Answer {
    private User user;
    
    private Question question;
    
    private int attemp;

    private String selection;
    
    public Answer() {

    }
   
    public Answer(User user, Question question, int attemp, String selection) {
        this.user = user;
        this.question = question;
        this.attemp = attemp;
        this.selection = selection;

    }

    public Answer(int attemp, String selection) {
        this.attemp = attemp;
        this.selection = selection;

    }
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Question getQuestion() {
        return question;
    }

    public void setQuestion(Question question) {
        this.question = question;
    }

    public int getAttemp() {
        return attemp;
    }

    public void setAttemp(int attemp) {
        this.attemp = attemp;
    }

    public String getSelection() {
        return selection;
    }

    public void setSelection(String selection) {
        this.selection = selection;
    }
}
