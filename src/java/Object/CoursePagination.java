/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Object;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author nguye
 */
public class CoursePagination {
    int page;
    int totalPage;
    List<Course> courseList;
    
    public CoursePagination(){
        this.courseList = new ArrayList<>();
    }

    public CoursePagination(int page, int totalPage, List<Course> courseList) {
        this.page = page;
        this.totalPage = totalPage;
        this.courseList = courseList;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public List<Course> getCourseList() {
        return courseList;
    }

    public void setCourseList(List<Course> courseList) {
        this.courseList = courseList;
    }
}
