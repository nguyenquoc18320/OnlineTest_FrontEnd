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
public class EntityPagination<T> {
    int page;
    int totalPage;
    List<T> entityList;
    
    public EntityPagination(){
        this.entityList = new ArrayList<>();
    }

    public EntityPagination(int page, int totalPage, List<T> entityList) {
        this.page = page;
        this.totalPage = totalPage;
        this.entityList = entityList;
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

    public List<T> getEntityList() {
        return entityList;
    }

    public void setEntityList(List<T> entityList) {
        this.entityList = entityList;
    }
}
