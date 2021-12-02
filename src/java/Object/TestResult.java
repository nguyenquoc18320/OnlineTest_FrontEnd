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
public class TestResult {
    private User user;
    private Test test;
    private float score;
    private int attempt;
    private Date startTime;
    private Date endTime;

    public TestResult(User user, Test test, float score, int attempt, Date startTime, Date endTime) {
        this.user = user;
        this.test = test;
        this.score = score;
        this.attempt = attempt;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public TestResult() {
    }
    
    

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Test getTest() {
        return test;
    }

    public void setTest(Test test) {
        this.test = test;
    }

    public float getScore() {
        return score;
    }

    public void setScore(float score) {
        this.score = score;
    }

    public int getAttempt() {
        return attempt;
    }

    public void setAttempt(int attempt) {
        this.attempt = attempt;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }
    
    
}
