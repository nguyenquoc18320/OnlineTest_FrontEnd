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
 * @author PhanSu
 */
public class Question extends BaseObject{

    private int questionnumber;

    private String correctanswer ;
    
    private String content;

    private String optionA;

    private String optionB;

    private String optionC;

    private String optionD;

    private String optionE;

    private String optionF;

    private String optionG;

    private String optionH;

    private String optionI;

    private String optionJ;

    private Test test;
	
    private List<User> users;
    public Question() {
        super();
    }
    
    public Question(Long id, Long createdBy, Date createdDate, Long modifiedBy, Date modifiedDate, int questionnumber, String correctanswer, String content, String optionA, String optionB, String optionC, String optionD, String optionE, String optionF, String optionG, String optionH, String optionI, String optionJ, Test test) {
            super(id, createdBy, createdDate, modifiedBy, modifiedDate);
            this.questionnumber = questionnumber;
            this.correctanswer = correctanswer;
            this.content = content;
            this.optionA = optionA;
            this.optionB = optionB;
            this.optionC = optionC;
            this.optionD = optionD;
            this.optionE = optionE;
            this.optionF = optionF;
            this.optionG = optionG;
            this.optionH = optionH;
            this.optionI = optionI;
            this.optionJ = optionJ;
            this.test = test;
    }
    public Question(int questionnumber, String correctanswer, String content, String optionA, String optionB, String optionC, String optionD, String optionE, String optionF, String optionG, String optionH, String optionI, String optionJ, Test test) {
            super();
            this.questionnumber = questionnumber;
            this.correctanswer = correctanswer;
            this.content = content;
            this.optionA = optionA;
            this.optionB = optionB;
            this.optionC = optionC;
            this.optionD = optionD;
            this.optionE = optionE;
            this.optionF = optionF;
            this.optionG = optionG;
            this.optionH = optionH;
            this.optionI = optionI;
            this.optionJ = optionJ;
            this.test = test;
    }
	
    public int getQuestionnumber() {
            return questionnumber;
    }
    public void setQuestionnumber(int questionnumber) {
            this.questionnumber = questionnumber;
    }
    public String getCorrectanswer() {
        return correctanswer;
    }

    public void setCorrectanswer(String correctanswer) {
        this.correctanswer = correctanswer;
    }

    public String getContent() {
            return content;
    }
    public void setContent(String content) {
            this.content = content;
    }
    public String getOptionA() {
            return optionA;
    }
    public void setOptionA(String optionA) {
            this.optionA = optionA;
    }
    public String getOptionB() {
            return optionB;
    }
    public void setOptionB(String optionB) {
            this.optionB = optionB;
    }
    public String getOptionC() {
            return optionC;
    }
    public void setOptionC(String optionC) {
            this.optionC = optionC;
    }
    public String getOptionD() {
            return optionD;
    }
    public void setOptionD(String optionD) {
            this.optionD = optionD;
    }
    public String getOptionE() {
            return optionE;
    }
    public void setOptionE(String optionE) {
            this.optionE = optionE;
    }
    public String getOptionF() {
            return optionF;
    }
    public void setOptionF(String optionF) {
            this.optionF = optionF;
    }
    public String getOptionG() {
            return optionG;
    }
    public void setOptionG(String optionG) {
            this.optionG = optionG;
    }
    public String getOptionH() {
            return optionH;
    }
    public void setOptionH(String optionH) {
            this.optionH = optionH;
    }
    public String getOptionI() {
            return optionI;
    }
    public void setOptionI(String optionI) {
            this.optionI = optionI;
    }
    public String getOptionJ() {
            return optionJ;
    }
    public void setOptionJ(String optionJ) {
            this.optionJ = optionJ;
    }
    public Test getTest() {
            return test;
    }
//    public void setTest(Test test) {
//            this.test = test;
//    }
    public List<User> getUsers() {
        return users;
    }

    public void setUsers(List<User> users) {
        this.users = users;
    }
}
