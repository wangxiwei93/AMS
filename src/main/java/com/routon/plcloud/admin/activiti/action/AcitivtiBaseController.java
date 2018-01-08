package com.routon.plcloud.admin.activiti.action;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.FormService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.runtime.ProcessInstanceQuery;
import org.activiti.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.routon.plcloud.admin.privilege.service.RoleService;
import com.routon.plcloud.common.UserProfile;


/**
 * 
 * @author wangxiwei
 *
 */
@Controller
@SessionAttributes(value = { "userPrivilege", "userProfile" })
public class AcitivtiBaseController {
	
	 @Autowired
	 private RepositoryService repositoryService;
	 
	 @Autowired
	 private RuntimeService runtimeService;
	 
	 @Autowired
	 private TaskService taskService;
	 
	 @Autowired
	 private RoleService roleService;
	 
	 @Autowired
	 private FormService formService;
	
	@RequestMapping(value ="/activiti/show")
	public String list(Model model){
		
		// 读取所有流程
        ProcessDefinitionQuery query = repositoryService.createProcessDefinitionQuery().active().orderByDeploymentId().desc();
        List<ProcessDefinition> list = query.list();
        model.addAttribute("pageList", list);
		return "activiti/ProcessShow";
		
	}
	
	@RequestMapping(value ="/activiti/getProcessImageAndXml")
	public void showProcess(HttpServletResponse response, String processDefinitionId, String resourceType) throws IOException{
		ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery()
				.processDefinitionId(processDefinitionId).singleResult();
		String resourceName = "";
        if (resourceType.equals("image")) {
            resourceName = processDefinition.getDiagramResourceName();
        } else if (resourceType.equals("xml")) {
            resourceName = processDefinition.getResourceName();
        }
        InputStream resourceAsStream = repositoryService.getResourceAsStream(processDefinition.getDeploymentId(), resourceName);
        byte[] b = new byte[1024];
        int len = -1;
        while ((len = resourceAsStream.read(b, 0, 1024)) != -1) {
            response.getOutputStream().write(b, 0, len);
        }
	}
	
	@RequestMapping(value ="/activiti/startPrpces")
	public @ResponseBody
	String startProcess(String processDefinitionId){
		ProcessInstance instance = runtimeService.startProcessInstanceById(processDefinitionId);
		if(instance == null){
			return "error";
		}
		return "success";
	}
	
	@RequestMapping(value ="/activiti/showRuntimeProcess")
	public String queryRuntimeProcess(Model model, @ModelAttribute("userProfile") UserProfile user){
		ProcessInstanceQuery querylist = runtimeService.createProcessInstanceQuery()
				.orderByProcessInstanceId().desc().active();
		List<ProcessInstance> list = querylist.list();
		
		Map<String,String> map = roleService.queryRoleByUserId(user.getCurrentUserId().toString());
		
		String username = user.getCurrentUserRealName();
		
		List<Task> taskQuery = taskService.createTaskQuery().taskCandidateOrAssigned(username).list();
		
/*		List<Task> taskQuery = new ArrayList<Task>();
		for (String key : map.keySet()) {
			   System.out.println("key= "+ key + " and value= " + map.get(key));
			  }*/
/*		String roleid = map.get("id").toString();
		
		for(int i = 0; i < rolelist.size(); i++){
			//HashMap<Object,String> map = rolelist.get(i);
			//String roleid = map.get("id").toString();
			List<Task> partlist = taskService.createTaskQuery().taskCandidateOrAssigned("1").list();
			taskQuery.addAll(partlist);
		}*/
		model.addAttribute("pageList", taskQuery);
		return "activiti/RuntimeProcess";
	}
	
	@RequestMapping(value ="/activiti/finisheTask")
	public String finisheTask(String taskId){
		
/*		List<Task> task = taskService.createTaskQuery().list();
		for(Task result : task){
			System.out.println(result.getId());
		}*/
		taskService.complete(taskId);
		return "success";
	}
	
	@RequestMapping(value ="/activiti/finisheTaskCondition")
	public String finisheTaskCondition(String taskId, Boolean pass){
		Map<String, String> variables =  new HashMap<String,String>();
		if(pass){
			
			variables.put("adminAudi", "true");

		} else{
			variables.put("adminAudi", "false");
		}
		
		formService.submitTaskFormData(taskId, variables);
		return "success";
	}
}
