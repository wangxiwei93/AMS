package com.routon.plcloud.admin.order.service;

import java.util.List;

import com.routon.plcloud.admin.privilege.model.TreeBean;
import com.routon.plcloud.common.PagingBean;
import com.routon.plcloud.common.model.Company;
import com.routon.plcloud.common.model.Order;
import com.routon.plcloud.common.model.Project;

/**
 * 
 * @author wangxiwei
 *
 */
public interface OrderService {

	public List<TreeBean> getMenuTrees();
	
	public PagingBean<Order> queryALL(String orderNum, int startIndex, int pageSize, String projectid);
	
	public Company queryCompanyById(String companyId);
	
	public Project queryProjectById(String projectId);
	
	public List<String> querySoftwareErpCodeAll();
	
	public String querySoftwareNameByERPcode(String erpCode);
	
	public long save(Order order);
}
