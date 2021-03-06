package com.routon.plcloud.admin.privilege.action;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.w3c.dom.stylesheets.LinkStyle;

import com.routon.plcloud.admin.order.service.ProjectService;
import com.routon.plcloud.admin.privilege.model.TreeBean;
import com.routon.plcloud.admin.privilege.service.GroupService;
import com.routon.plcloud.admin.privilege.service.RoleService;
import com.routon.plcloud.admin.privilege.service.UserService;
import com.routon.plcloud.common.PagingBean;
import com.routon.plcloud.common.PmaxException;
import com.routon.plcloud.common.UserProfile;
import com.routon.plcloud.common.constant.CVal;
import com.routon.plcloud.common.model.AuthType;
import com.routon.plcloud.common.model.Company;
import com.routon.plcloud.common.model.HardwareProduct;
import com.routon.plcloud.common.model.Project;
import com.routon.plcloud.common.model.Role;
import com.routon.plcloud.common.model.User;
import com.routon.plcloud.common.persistence.CompanyMapper;
import com.routon.plcloud.common.persistence.ProjectMapper;
//import com.routon.plcloud.common.model.User1;
import com.routon.plcloud.common.persistence.UserMapper;
import com.routon.plcloud.common.service.MessageServiceImpl;
import com.routon.plcloud.common.utils.JsonMsgBean;

@Controller
@SessionAttributes(value = { "userPrivilege", "userProfile" })
public class UserController {

	private Logger logger = LoggerFactory.getLogger(UserController.class);

	private final String RMPATH = "/user/";

	@Resource(name = "userServiceImpl")
	private UserService userService;

	@Resource(name = "roleServiceImpl")
	private RoleService roleService;

	@Resource(name = "messageServiceImpl")
	protected MessageServiceImpl messageService;

	@Resource(name = "groupServiceImpl")
	private GroupService groupService;
	
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private ProjectMapper projectMapper;
	
	@Autowired
	private CompanyMapper companyMapper;

	@RequestMapping(value = RMPATH + "show")
	public String list(HttpServletRequest request, User queryCondition,
			@ModelAttribute("userProfile")
			UserProfile user, Model model, HttpSession session) {

		logger.debug("show");
		try {
			User tem_user = new User();
			Long loginUserId = user.getCurrentUserId();		
			List<Role> roles = roleService.getRoles(loginUserId);
			request.getParameter("project");
			int page = NumberUtils.toInt(request.getParameter("page"), 1);
			int pageSize = NumberUtils.toInt(request.getParameter("pageSize"),
					10);
			int startIndex = (page - 1) * pageSize;

			String groupIds = userService.getGroupIdsByUserId(loginUserId);
			queryCondition.setGroupIds(groupIds);
			//项目分组树
			List<TreeBean> projectTreeBeans = userService.getProjectTrees(loginUserId , null);
			
			
			
			//下拉框 选择公司
			HashSet<String> companynames = new HashSet<String>();
			String sql = "select a.* from company a where 1=1";
			List<Company> companies = companyMapper.selectBySql(sql);
			for(int i=0; i<companies.size();i++){
				companynames.add(companies.get(i).getCompanyname());
			}
		
			
			PagingBean<User> pagingBean = userService.paging(startIndex,
					pageSize, request.getParameter("sort"),
					request.getParameter("dir"), queryCondition, null, null,
					loginUserId,request.getParameter("exportflag") != null&&request.getParameter("exportflag").equals("true")?true:false);

			int maxpage = (int) Math.ceil(pagingBean.getTotalCount()
					/ (double) pageSize);
			
			if (pagingBean.getTotalCount() == 0) {
				maxpage = 0;
			}
			
			if (StringUtils.isNotBlank(queryCondition.getPhone())) {
				model.addAttribute("phone", queryCondition.getPhone());
			}
			
			if (StringUtils.isNotBlank(queryCondition.getRealName())) {
				model.addAttribute("realName", queryCondition.getRealName());
			}
			

			model.addAttribute("projectTreeBeans", JSONArray.fromObject(projectTreeBeans).toString());
			model.addAttribute("companynames",companynames);
			model.addAttribute("roles", roles);
			model.addAttribute("maxpage", maxpage);
			model.addAttribute("page", page);
			model.addAttribute("pageList", pagingBean);
			model.addAttribute("user",tem_user);
			// addCatalogAttribute(catalogId, model);
		}
		catch (Exception e) {
			logger.error("错误", e);
		}
		
		return "user/show";
	}

	@RequestMapping(value = RMPATH + "add")
	public String add(User user , Model model, String realname,String idcard,  String phoneNum,
			String companynames, String department, String roleIds, String projectIds, Integer updateId , @ModelAttribute("userProfile") UserProfile userProfile ){
		JsonMsgBean jsonMsg = null;
		Long id =null;
	//	Long loginUserId = userProfile.getCurrentUserId();
		
	//	List<TreeBean> projectTreeBeans = userService.getProjectTrees(loginUserId , null);
		
		logger.info("提交");
		if(updateId == null){
			 id = userService.save(user,realname,idcard,phoneNum,companynames,department,roleIds,projectIds,userProfile); 
		
		} else{
			
			 id = userService.edit(updateId,realname,idcard,phoneNum,companynames,department,roleIds,projectIds,userProfile);
			
		}
		if (id > 0) {

			jsonMsg = new JsonMsgBean(0, CVal.Success, "保存成功!");
		}
		else if(id == -2){
			jsonMsg = new JsonMsgBean(0, CVal.Fail, "用户号码已经存在!");
		}
		else {
			jsonMsg = new JsonMsgBean(0, CVal.Fail, "保存失败!");
		}

		model.addAttribute("jsonMsg", jsonMsg);
	//	model.addAttribute("projectTreeBeans", JSONArray.fromObject(projectTreeBeans).toString());

		return "common/jsonTextHtml";
	}
	
//   编辑返回值
    	
	@RequestMapping(value = RMPATH + "querybyId")
	@ResponseBody public JsonMsgBean querybyId(@ModelAttribute("userProfile")UserProfile userProfile,Long id,Model model){
		
		User user = userService.getUserByUserId(id);
		Long loginUserId = userProfile.getCurrentUserId();
		HashSet<Long> userRoleIdSet = user.getRoleIdset();
		List<Role> roles = roleService.getRoles(loginUserId);
		for (Role role : roles) {
			if (userRoleIdSet.contains(role.getId())) {
				role.setChecked(true);
			}
		
		}
		JsonMsgBean jsonMsg = null;
	//	user = userMapper.selectById2(id);
		jsonMsg = new JsonMsgBean(user, roles);
		return jsonMsg;
	}
		
		
		
//		String role_texts = "";
//		String roleIds = "";
//		List<User1> users1 = userMapper.selectById1(id);
//		User1 user1 = users1.get(0);
//		if(users1 != null)
//		{
//			for (User1 systemuser : users1) {
//				String roleName = systemuser.getRolename();
//				Long roleId = systemuser.getRoleid();
//
//				if (StringUtils.isNotBlank(roleName)) {
//
//					if (StringUtils.isNotBlank(role_texts)) {
//						role_texts += ",";
//						roleIds += ",";
//						role_texts += roleName;
//						roleIds += roleId;
//					}
//					else {
//						role_texts += roleName;
//						roleIds += roleId;
//					}
//
//					user1.getRoleIdset().add(roleId);
//				}
//
//			}
//		}
//		user1.setRoleIds(roleIds);
//		user1.setRole_texts(role_texts);
//		
//		HashSet<Long> userRoleIdSet = user1.getRoleIdset();
//		
//		for (User1 user : users1) {
//			if (userRoleIdSet.contains(user.getRoleid())) {
//				user.setChecked(true);
//			}
//		}
		
	//model.addAttribute("user1",user1);

	
//	/**
//	 * 6.2.12 新增
//	 * 
//	 * @param model
//	 * @return
//	 */
//	@RequestMapping(value = RMPATH + "add", method = RequestMethod.GET)
//	public String setupAdd(Model model, @ModelAttribute("userProfile")
//	UserProfile userProfile, HttpServletRequest request) {
//
//		User user = new User();
//		Long loginUserId = userProfile.getCurrentUserId();
//
//		List<Role> roles = roleService.getRoles(loginUserId);
//
//		List<TreeBean> groupTreeBeans = groupService.getGroupTreeByUserId(
//				loginUserId, null, null);
//
//		int page = NumberUtils.toInt(request.getParameter("page"), 1);
//		
//		ArrayList<AuthType> list = userService.getAuthType();
//		
//		HashSet<String> companyNameSet = new HashSet<String>();
//		
//		for(int i = 0; i < list.size(); i++){
//			companyNameSet.add(list.get(i).getCompany_name());
//		}
//		
//		model.addAttribute("companyNameSet",companyNameSet);
//		model.addAttribute("ClientType", list);
//		model.addAttribute("page", page);
//		model.addAttribute("roles", roles);
//		model.addAttribute("user", user);
//		model.addAttribute("groupTreeBeans",
//				JSONArray.fromObject(groupTreeBeans).toString());
//		return "user/edit";
//	}

//	@RequestMapping(value = RMPATH + "edit", method = RequestMethod.GET)
//	public String setupEdit(Model model, @ModelAttribute("userProfile")
//	UserProfile userProfile, Long id, HttpServletRequest request) {
//
//		User user = userService.getUserByUserId(id);
//		HashSet<Long> userRoleIdSet = user.getRoleIdset();
//
//		Long loginUserId = userProfile.getCurrentUserId();
//		List<TreeBean> groupTreeBeans = groupService.getGroupTreeByUserId(
//				loginUserId, null, id);
//
//		List<Role> roles = roleService.getRoles(loginUserId);
//		for (Role role : roles) {
//			if (userRoleIdSet.contains(role.getId())) {
//				role.setChecked(true);
//			}
//		}
//		
//		ArrayList<AuthType> list = userService.getAuthType();
//		HashSet<String> companyNameSet = new HashSet<String>();
//		
//		for(int i = 0; i < list.size(); i++){
//			companyNameSet.add(list.get(i).getCompany_name());
//		}
//		
//		int page = NumberUtils.toInt(request.getParameter("page"), 1);
//		model.addAttribute("companyNameSet",companyNameSet);
//		model.addAttribute("ClientType", list);
//		model.addAttribute("page", page);
//		model.addAttribute("roles", roles);
//		model.addAttribute("user", user);
//		model.addAttribute("groupTreeBeans",
//				JSONArray.fromObject(groupTreeBeans).toString());
//
//		return "user/edit";
//	}
	
	/**
	 * 用户重置密码
	 * 
	 * @param id
	 *            待重置密码的用户ID
	 * @param optUser
	 *            当前操作用户
	 * @return ControllerResult 处理结果
	 */
	@RequestMapping(value = "user/resetPwd", method = RequestMethod.POST)
	public String resetPwd(String id, @ModelAttribute("userProfile")
	UserProfile optUser, Model model) {
		JsonMsgBean jsonMsg = null;
		try {
			userService.resetPwd(id, optUser);
			jsonMsg = new JsonMsgBean(0, CVal.Success, "");
		}
		catch (PmaxException e) {
			logger.error("重置密码以下用户\"{" + id + "}\"时异常", e);
			jsonMsg = new JsonMsgBean(0, CVal.Fail, e.getMessage());

		}
		catch (Exception e) {
			logger.error("重置密码以下用户\"{" + id + "}\"时异常", e);
			jsonMsg = new JsonMsgBean(0, CVal.Exception, "重置密码时异常!");

		}

		model.addAttribute("jsonMsg", jsonMsg);
		return "common/jsonTextHtml";

	}
	
	/**
	 * 用户禁用用户
	 * 
	 * @param id
	 *            待禁用的用户ID
	 * @param optUser
	 *            当前操作用户
	 * @return ControllerResult 处理结果
	 */
	@RequestMapping(value = "user/disableUser", method = RequestMethod.POST)
	public String disableUser(String id, @ModelAttribute("userProfile")
	UserProfile optUser, Model model){
		JsonMsgBean jsonMsg = null;
		try {
			Long loginUserId = optUser.getCurrentUserId();
			String userId_array[] = id.split(",");
			String disableUserIds = "";
			boolean isContainLoginUserId = false;
			
			for(String userId : userId_array) {
				if (Long.parseLong(userId) == loginUserId.longValue()) {
					isContainLoginUserId = true;
					continue;
				}
				if (disableUserIds.equals("")) {
					disableUserIds += userId;
				}
				else {
					disableUserIds += ",";
					disableUserIds += userId;
				}

			}
			if (!isContainLoginUserId) {
				userService.disableUser(disableUserIds, optUser);
				this.logger.info("成功禁用了以下用户：{}", disableUserIds);
				jsonMsg = new JsonMsgBean(0, CVal.Success, "");

			}
			else {
				if (!disableUserIds.equals("")) {
					userService.disableUser(disableUserIds, optUser);
					this.logger.info("成功禁用了以下用户：{}", disableUserIds);
					jsonMsg = new JsonMsgBean(0, CVal.Fail,
							"所选用户中包含当前登陆用户未能禁用,其他用户已禁用成功!");
					// return new ResultBean(-2,
					// "所选用户中包含当前登陆用户未能删除,其他用户已删除成功!");
				}
				else {
					jsonMsg = new JsonMsgBean(0, CVal.Fail, "禁用的用户为当前登陆用户不能禁用!");

				}
			}
				
		} catch (Exception e) {
			// TODO: handle exception
			logger.error("禁用以下用户\"{" + id + "}\"时异常", e);
			jsonMsg = new JsonMsgBean(0, CVal.Exception, "禁用系统用户异常!");
		}
		model.addAttribute("jsonMsg", jsonMsg);
		return "common/jsonTextHtml";
	}

	/**
	 * 删除用户
	 * 
	 * @param id
	 *            待删除用户的ID
	 * @param optUser
	 *            当前操作用户
	 * @return ControllerResult 处理结果
	 */
	@RequestMapping(value = "user/delete", method = RequestMethod.POST)
	public String delUser(String id, @ModelAttribute("userProfile")
	UserProfile optUser, Model model) {
		JsonMsgBean jsonMsg = null;
		try {
			Long loginUserId = optUser.getCurrentUserId();
			String userId_array[] = id.split(",");
			String delUserIds = "";
			boolean isContainLoginUserId = false;

			for (String userId : userId_array) {
				if (Long.parseLong(userId) == loginUserId.longValue()) {
					isContainLoginUserId = true;
					continue;
				}

				if (delUserIds.equals("")) {
					delUserIds += userId;
				}
				else {
					delUserIds += ",";
					delUserIds += userId;
				}

			}

			if (!isContainLoginUserId) {
				userService.delete(delUserIds, optUser);
				this.logger.info("成功删除了以下用户：{}", delUserIds);
				jsonMsg = new JsonMsgBean(0, CVal.Success, "");

			}
			else {
				if (!delUserIds.equals("")) {
					userService.delete(delUserIds, optUser);
					this.logger.info("成功删除了以下用户：{}", delUserIds);
					jsonMsg = new JsonMsgBean(0, CVal.Fail,
							"所选用户中包含当前登陆用户未能删除,其他用户已删除成功!");
					// return new ResultBean(-2,
					// "所选用户中包含当前登陆用户未能删除,其他用户已删除成功!");
				}
				else {
					jsonMsg = new JsonMsgBean(0, CVal.Fail, "删除的用户为当前登陆用户不能删除!");

				}
			}

		}
		catch (Exception e) {
			logger.error("删除以下用户\"{" + id + "}\"时异常", e);
			jsonMsg = new JsonMsgBean(0, CVal.Fail, "删除系统用户异常!");

		}

		model.addAttribute("jsonMsg", jsonMsg);
		return "common/jsonTextHtml";

	}

//	@RequestMapping(value = RMPATH + "save", method = RequestMethod.POST)
//	public String save(@Valid
//	User user, BindingResult result,
//			MultipartHttpServletRequest multipartRequest, Model model,
//			@ModelAttribute("userProfile")
//			UserProfile userProfile) {
//		JsonMsgBean jsonMsg = null;
//
///*		String username = user.getUserName();
//		List<User> listUser = userService.queryUserbyName(username);
//		if(listUser.size() > 0){
//			jsonMsg = new JsonMsgBean(0, CVal.Fail, "该用户名已存在!");
//			model.addAttribute("jsonMsg", jsonMsg);
//			return "common/jsonTextHtml";
//		}*/
//		do {
//			try {
//
//				if (result.hasErrors()) {
//
//					jsonMsg = new JsonMsgBean(0, CVal.Fail,
//							messageService.getOneMessage(result, "userName",
//									"realName", "phone", "roleIds", "groupIds", "company", "project"));
//					break;
//				}
//				Long id = null;
//				logger.info("提交");
//				if (user.getId() != null && user.getId() > 0) {
//					id = userService.edit(user, user.getGroupIds(),
//							user.getRoleIds(), userProfile);
//				}
//				else {
//
//					id = userService.add(user, user.getGroupIds(),
//							user.getRoleIds(), userProfile);
//				}
//
//				if (id > 0) {
//
//					jsonMsg = new JsonMsgBean(0, CVal.Success, "");
//				}
//				else if (id == -2) {
//					jsonMsg = new JsonMsgBean(0, CVal.Fail, "用户名已经存在!");
//				}
//				else {
//					jsonMsg = new JsonMsgBean(0, CVal.Fail, "保存用户失败!");
//				}
//
//			}
//			catch (Exception e) {
//				logger.error("用户保存异常", e);
//				jsonMsg = new JsonMsgBean(0, CVal.Exception, "保存失败，请稍候重试!");
//			}
//		} while (false);
//
//		model.addAttribute("jsonMsg", jsonMsg);
//
//		return "common/jsonTextHtml";
//	}
	
	@RequestMapping(value = RMPATH + "queryproject", method = RequestMethod.POST)
	public @ResponseBody 
	List<AuthType> queryProject(Model model, @ModelAttribute("userProfile")
	UserProfile userProfile, HttpServletRequest request, String data) {
		List<AuthType> list = userService.queryProjectByCompany(data);
		return list;

	}
	
//	@RequestMapping(value = RMPATH + "selectproject", method = RequestMethod.POST)
//	public @ResponseBody 
//	List<Project> selectproject(Model model, @ModelAttribute("userProfile")
//	UserProfile userProfile, HttpServletRequest request, String data) {
////		List<AuthType> list = userService.queryProjectByCompany(data);
////		return list;
////		HashSet<String> companynames = new HashSet<String>();
////		String sql = "select a.* from company a where 1=1";
////		List<Company> companies = companyMapper.selectBySql(sql);
////		for(int i=0; i<companies.size();i++){
////			companynames.add(companies.get(i).getCompanyname());
////		}
//		String sql = "select a.* from project a left join projectcompany b on a.id = b.projectid left join company c on b.companyid = c.id where c.companyname = '" + data +"'";
//		
//		List<Project> projects = projectMapper.selectBysql(sql);
//		
//		return projects;
//	}
}
