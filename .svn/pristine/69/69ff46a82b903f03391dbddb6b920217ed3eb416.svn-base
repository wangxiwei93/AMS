package com.routon.plcloud.admin.order.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.routon.plcloud.admin.order.service.ProjectService;
import com.routon.plcloud.admin.privilege.model.TreeBean;
import com.routon.plcloud.common.PagingBean;
import com.routon.plcloud.common.PmaxException;
import com.routon.plcloud.common.UserProfile;
import com.routon.plcloud.common.constant.CVal;
import com.routon.plcloud.common.model.Company;
import com.routon.plcloud.common.model.Group;
import com.routon.plcloud.common.model.HardwareProduct;
import com.routon.plcloud.common.model.Project;
import com.routon.plcloud.common.model.ProjectCompany;
import com.routon.plcloud.common.persistence.CompanyMapper;
import com.routon.plcloud.common.persistence.HardwareProductMapper;
import com.routon.plcloud.common.persistence.ProjectCompanyMapper;
import com.routon.plcloud.common.persistence.ProjectMapper;
import com.routon.plcloud.common.service.MessageServiceImpl;
import com.routon.plcloud.common.utils.JsonMsgBean;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 
 * @author wangzhuo
 *
 */
@Controller
@SessionAttributes(value = { "userPrivilege", "userProfile" })
public class ProjectController {
	
	private Logger logger = LoggerFactory.getLogger(ProjectController.class);
	
	private final String RMPATH = "/project/";
	
	@Resource(name = "projectServiceImpl")
	private ProjectService projectService;
	
	 @Autowired
	 private CompanyMapper companyMapper;
	 
	 @Autowired
	 private ProjectMapper projectMapper;
	 
	 @Autowired
	 private ProjectCompanyMapper projectCompanyMapper;
	
	@Resource(name = "messageServiceImpl")
	protected MessageServiceImpl messageService;
	
	@RequestMapping(value = RMPATH + "list")
	public String list(HttpServletRequest request, Company queryCondition, Project queryCondition1,Long id,
			@ModelAttribute("userProfile")
			UserProfile user, Model model, HttpSession session) {

		Long loginUserId = user.getCurrentUserId();	
		//公司树状图展示
		List<TreeBean> companyTreeBeans = projectService.getCompanyTreeByUserId(loginUserId, queryCondition, null);	
		
		int page = NumberUtils.toInt(request.getParameter("page"), 1);
		int pageSize = NumberUtils.toInt(request.getParameter("pageSize"), 10);
		int startIndex = (page - 1) * pageSize;		
		
		//PagingBean<HardwareProduct> hardwarelist = hardwareService.quryAll(startIndex, pageSize, productName);
		//PagingBean<Company> pagingBean = companyService.paging(
		//startIndex, pageSize, request.getParameter("sort"),
		//request.getParameter("dir"), queryCondition, null, null, loginUserId,request.getParameter("exportflag") != null&&request.getParameter("exportflag").equals("true")?true:false);
		PagingBean<Project> pagingBean = projectService.paging(startIndex, pageSize, request.getParameter("sort"), request.getParameter("dir"), queryCondition1,
				null, null, id, loginUserId, request.getParameter("exportflag") != null&&request.getParameter("exportflag").equals("true")?true:false);
		if (StringUtils.isNotBlank(queryCondition1.getProjectname())) {
			model.addAttribute("projectname", queryCondition1.getProjectname());
		}
		
		int maxpage = (int)Math.ceil(pagingBean.getTotalCount()/(double)pageSize);
		if (pagingBean.getTotalCount() == 0) {
			maxpage = 0;
		}
			
		model.addAttribute("maxpage", maxpage);
		model.addAttribute("page", page);
		model.addAttribute("groupTreeBeans", JSONArray.fromObject(companyTreeBeans).toString());
		model.addAttribute("pageList",pagingBean);	
		return "project/list";
	}
	
	@RequestMapping(value = "project/save", method = RequestMethod.POST)
	public String addProject(Project project, @ModelAttribute("userProfile") UserProfile optUser, Model model) {
		JsonMsgBean jsonMsg = null;
		do {
			try {
				Long id = null;
				if(project.getId()!=null&&project.getId()>0){
					String sql = "select p.* from projectcompany p where p.projectid = " +project.getId() ;
					List<ProjectCompany> tem_projectcompany = 	projectCompanyMapper.selectBySql(sql);		
					id = projectService.edit(project , (int)tem_projectcompany.get(0).getCompanyid() , optUser);
				}else {
					id = projectService.add(project, project.getCompanyid() , optUser);
				}
				
				if(id>0){
					project.setId(id);
					jsonMsg = new JsonMsgBean(0, CVal.Success, JSONObject.fromObject(project).toString());			
				}
				else if(id==-2){
					jsonMsg = new JsonMsgBean(0, CVal.Fail, "分组名已经存在!");			
				}
				else {
					jsonMsg = new JsonMsgBean(0, CVal.Fail, "保存分组失败!");
				}
	
			} 
			catch (Exception e) {
				logger.error("保存失败，请稍候重试!", e);
				jsonMsg = new JsonMsgBean(0, CVal.Exception, "保存失败，请稍候重试!");
				
			}
		}
		while(false);

		model.addAttribute("jsonMsg", jsonMsg);	
		return "common/jsonTextHtml";	
	}
	
	
	
	@RequestMapping(value = "/project/projectshow")
	@ResponseBody public JsonMsgBean ProjectShow(Integer id){
		JsonMsgBean jsonMsg = null;
		
		
		Project project = projectMapper.selectById(id);
		String sql = "select * from company a left join projectcompany b on a.id = b.companyid left join "
				+ "project c on b.projectid = c.id where c.id = "+ id ;
		List<Company> tem_company = companyMapper.selectBySql(sql);
		Company company = tem_company.get(0);
		
		jsonMsg = new JsonMsgBean(project, company);
		
		return jsonMsg;
	}
	
	@RequestMapping(value = "/project/companyshow")
	@ResponseBody public Company CompanyShow(Integer id){
		Company company = companyMapper.selectById1(id);
		return company;
	}
	
	@RequestMapping(value = "project/disableProject", method = RequestMethod.POST)
	public String disableProject(String id, Model model){
		JsonMsgBean jsonMsg = null;
		try {
			String projectID_array[] = id.split(",");
			String disableProjectIds = "";
			for(String projectId : projectID_array){
				if(disableProjectIds.equals(""))
				{
					disableProjectIds += projectId;
				}
				else{
					disableProjectIds += ",";
					disableProjectIds += projectId;
				}
			}
			projectService.disableProject(disableProjectIds);
			this.logger.info("成功禁用了以下项目：{}", disableProjectIds);
			jsonMsg = new JsonMsgBean(0, CVal.Success, "");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			logger.error("禁用以下项目\"{" + id + "}\"时异常", e);
			jsonMsg = new JsonMsgBean(0, CVal.Exception, "禁用系统用户异常!");
		}
		
		model.addAttribute(jsonMsg);
		return "common/jsonTextHtml";	
	}
	
	
}
