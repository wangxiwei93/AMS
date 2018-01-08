package com.routon.plcloud.admin.order.action;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.apache.commons.lang.math.NumberUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.routon.plcloud.admin.order.service.OrderService;
import com.routon.plcloud.admin.privilege.model.TreeBean;
import com.routon.plcloud.common.PagingBean;
import com.routon.plcloud.common.UserProfile;
import com.routon.plcloud.common.model.Company;
import com.routon.plcloud.common.model.Order;
import com.routon.plcloud.common.model.Project;

import net.sf.json.JSONArray;

/**
 * 
 * @author wangxiwei
 *
 */
@Controller
@SessionAttributes(value = { "userPrivilege", "userProfile" })
public class OrderController {
	
	
	@Autowired
	private TaskService taskService;
	
	@Autowired
	private OrderService orderService;
	
	@RequestMapping(value = "/order/show")
	public String list(HttpServletRequest request, @ModelAttribute("userProfile") UserProfile user, Model model,
			String orderNum, String projectid, String treeNodeTid, String companyid){
		
		Company company = null;
		Project project = null;
		
		int page = NumberUtils.toInt(request.getParameter("page"), 1);
		int pageSize = NumberUtils.toInt(request.getParameter("pageSize"), 10);
		int startIndex = (page - 1) * pageSize;	
		
		String username = user.getCurrentUserRealName();
		
		List<Task> taskQuery = taskService.createTaskQuery().taskCandidateOrAssigned(username).list();
		
		List<TreeBean> menuTreeBeansResult = orderService.getMenuTrees();
		
		PagingBean<Order> pageBean = orderService.queryALL(/*startIndex, pageSize, */orderNum, startIndex, pageSize, projectid);
		
		if(companyid != null){
			company = orderService.queryCompanyById(companyid);
		}
		if(projectid != null){
			project = orderService.queryProjectById(projectid);
		}		
		
		List<String> softwareERPcodeList = orderService.querySoftwareErpCodeAll();
		
		int maxpage = (int) Math.ceil(pageBean.getTotalCount()
				/ (double) pageSize);
		if (pageBean.getTotalCount() == 0) {
			maxpage = 0;
		}
		
		model.addAttribute("List", taskQuery);
		model.addAttribute("menuTreeBeans", JSONArray.fromObject(menuTreeBeansResult).toString());
		model.addAttribute("pageList", pageBean);
		model.addAttribute("maxpage", maxpage);
		model.addAttribute("page", page);
		model.addAttribute("treeNodeTid", treeNodeTid);
		model.addAttribute("company", company);
		model.addAttribute("project", project);
		model.addAttribute("softwareERPcodeList", softwareERPcodeList);
		return "order/list";
	}
	
	@RequestMapping(value = "/order/save")
	public String save(HttpServletRequest request, @ModelAttribute("userProfile") UserProfile user, Model model,
			Order order, String orderActiveStatus, String startTimeByContract, String startTimeByActive, String month_1, String month_2){
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");    
		if(orderActiveStatus == "1" || orderActiveStatus.equals("1")){
			if(startTimeByContract != null){
				order.setStarttime(startTimeByContract);
				try {
				  if(month_1 != null){
					Date str = sdf.parse(startTimeByContract);
					GregorianCalendar gc = new GregorianCalendar(); 
					gc.setTime(str);
					gc.add(2, Integer.parseInt(month_1));
					String endtime = sdf.format(gc.getTime());
					order.setEndtime(endtime);
					order.setMonth(Integer.parseInt(month_1));
					order.setCreatetime(new Date());
				   }
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}
		} else if(orderActiveStatus == "2" || orderActiveStatus.equals("2")){
			if(startTimeByActive != null){
				order.setTacitstarttime(startTimeByActive);
				if(month_2 != null){
					order.setMonth(Integer.parseInt(month_2));
					order.setCreatetime(new Date());
				}
			}
		}
		orderService.save(order);
		return "common/jsonTextHtml";
		
	}
	
	@RequestMapping(value = "/order/querySoftwareNameByERPcode", produces="text/html;charset=UTF-8;")
	public @ResponseBody String querySoftwareNameByERPcode(HttpServletRequest request, String erpCode) throws UnsupportedEncodingException{
		
		String result = orderService.querySoftwareNameByERPcode(erpCode);
		return result;
		
	}
}
