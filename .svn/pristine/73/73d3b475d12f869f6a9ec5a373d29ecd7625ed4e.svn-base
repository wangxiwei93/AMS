package com.routon.plcloud.admin.order.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.activiti.engine.impl.bpmn.data.Data;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.record.formula.functions.Int;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.method.P;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import com.routon.plcloud.admin.privilege.model.TreeBean;
import com.routon.plcloud.common.PagingBean;
import com.routon.plcloud.common.PagingSortDirection;
import com.routon.plcloud.common.UserProfile;
import com.routon.plcloud.common.constant.CVal;
import com.routon.plcloud.common.dao.mybatis.PagingDaoMybatis;
import com.routon.plcloud.common.model.Company;
import com.routon.plcloud.common.model.Project;
import com.routon.plcloud.common.model.ProjectCompany;
import com.routon.plcloud.common.persistence.CompanyMapper;
import com.routon.plcloud.common.persistence.ProjectCompanyMapper;
import com.routon.plcloud.common.persistence.ProjectMapper;
import com.routon.plcloud.common.persistence.UserMapper;


@Service
public class ProjectServiceImpl implements ProjectService{
	
	@Autowired
	private ProjectMapper ProjectMapper;
	
	@Autowired
	private CompanyMapper companyMapper;
	
	@Autowired
	private ProjectCompanyMapper projectCompanyMapper;
	
	@Resource(name = "pagingDaoMybatis")
    private PagingDaoMybatis pagingDao;	

	@Override
	public Long move(Company group, UserProfile optUser) {
		// TODO Auto-generated method stub
		return null;
	}
	
	

	@Override
	public List<TreeBean> getCompanyTreeByUserId(Long opuserId, Company queryCondition, Long userId) {
		// TODO Auto-generated method stub
		//没有划分权限，等用户管理权限划分完成后，完善权限的添加（通过连表查询projectcompany以及userproject与opuserId匹配）
		
		String sql = "select DISTINCT c.* FROM company c WHERE c.status = '有效'";
		if(queryCondition != null && StringUtils.isNotBlank(queryCondition.getCompanyname()))
		{
			sql += " and c.name like '%" + queryCondition.getCompanyname() + "%'";
		}
		List<Company> companys = companyMapper.selectBySql(sql);
		HashMap<Long, TreeBean> companyHashMaps = new HashMap<Long, TreeBean>();
	//树状显示	
		TreeBean treeBean1 = new TreeBean();
		Long a = -1L;
		treeBean1.setId(a);
		treeBean1.setName("全部公司");	
		companyHashMaps.put(a, treeBean1);
		
		for(Company company : companys){
			TreeBean treeBean = new TreeBean();
			treeBean.setId(company.getId());
			treeBean.setName(company.getCompanyname());
			
			companyHashMaps.put(company.getId(), treeBean);
		}
	//分级显示		
		Iterator<Long> iterator = companyHashMaps.keySet().iterator();
		Set<Long> removeIds = new HashSet<Long>();
		while (iterator.hasNext()) {
			Long id = iterator.next();
			TreeBean treeBean = companyHashMaps.get(id);
			
			
			TreeBean parentTreeBean = new TreeBean();
			if(treeBean.getId() == -1L){
			//	 parentTreeBean = companyHashMaps.get(treeBean.getId());
				continue;
			}
			else {				
				if(parentTreeBean !=null){
					parentTreeBean = companyHashMaps.get(-1L);
					Collection<TreeBean> parentschild = parentTreeBean
							.getChildren();
					if (parentschild == null) {
						parentschild = new ArrayList<TreeBean>();
					}
					parentschild.add(treeBean);
					parentTreeBean.setChildren(parentschild);
					removeIds.add(id);
				}	
			}
		}	
		for (Long id : removeIds) {
			companyHashMaps.remove(id);
		}
		return new ArrayList<TreeBean>(companyHashMaps.values());
	}

//	@Override
//	public List<TreeBean> getCompanyTreeByUserId(Long opuserId, Company queryCondition, Long userId,
//			boolean onlyleafcheck) {
//		// TODO Auto-generated method stub
//		return null;
//	}

	@Override
	public List<TreeBean> getCompanyTreeByUserId(Long opuserId, Company queryCondition, Long userId,
			boolean onlyleafcheck, boolean showRelevanceCount) {
		// TODO Auto-generated method stub
		return null;
	}



	@Transactional(readOnly = true)
	public PagingBean<Project> paging(int startIndex, int pageSize, String sortCriterion, String sortDirection,
			Project queryCondition1, String in_projectIds, String notin_projectIds, Long id, Long loginUserId,
			boolean exportflag) {
		// TODO Auto-generated method stub
		String pagingQueryLanguage = "select a.*,c.address from project a LEFT JOIN projectcompany b on a.id=b.projectid LEFT JOIN company c on b.companyid=c.ID where a.status=1 ";
		StringBuilder sbHQL = new StringBuilder(pagingQueryLanguage);
	
		
		
		
		
		
		if (StringUtils.isNotBlank(queryCondition1.getProjectname())){
			
						String projectname = queryCondition1.getProjectname();
						
						sbHQL.append(" and a.projectname like '%");
						sbHQL.append(projectname); 
						sbHQL.append("%'");
						 
					}

		if (in_projectIds != null) {

			if (StringUtils.isNotBlank(in_projectIds)) {
				  sbHQL.append(" and a.id in ("); 
				  sbHQL.append(in_projectIds);
				  sbHQL.append(")");
			} else {
				sbHQL.append(" and a.id in (");
				sbHQL.append("-1");
				sbHQL.append(")");
			}
		}

		if (StringUtils.isNotBlank(notin_projectIds)) {
			
			 sbHQL.append(" and a.id not in (");
			 sbHQL.append(notin_projectIds); 
			 sbHQL.append(")");
			
		}
		
		if(id != null )
		{
			sbHQL.append("and c.id = ");
			sbHQL.append(id);
		}

		String[] sortCriterions = null;
		if(sortCriterion != null){
			if(sortCriterion.equals("address"))
			{
				sortCriterions = new String[] { "c." + sortCriterion };
			}
			else{
				sortCriterions = new String[] { "a." + sortCriterion };
			}	
		}
		PagingSortDirection[] sortDirections =null;
		if(sortDirection != null){
			sortDirections = new PagingSortDirection[] { "desc"
					.equals(sortDirection.toLowerCase()) ? PagingSortDirection.DESC
					: PagingSortDirection.ASC };
		}

		PagingBean<Project> pagingSystemproject = pagingDao.query(ProjectMapper, sbHQL.toString(),
				sortCriterions, sortDirections, startIndex, pageSize, exportflag);
		
		return pagingSystemproject;
	}





	@Transactional(rollbackFor = Exception.class)
	public Long add(Project project, int companyid, UserProfile optUser) throws Exception {
		// TODO Auto-generated method stub
		Long projectid = saveproject(project);
		if(projectid > 0 && companyid != 0){
			ProjectCompany projectCompany = new ProjectCompany();
			projectCompany.setCompanyid(companyid);
			projectCompany.setProjectid(projectid);
			projectCompany.setModifytime(new Date());
			
			projectCompanyMapper.insert(projectCompany);
			return projectid;
		}
		else{
			return projectid;
		}
	}

	@Override
	public Long edit(Project project, int companyid, UserProfile optUser) {
		// TODO Auto-generated method stub
		Long projectid = updateproject(project);
		if(projectid > 0)
		{
			projectCompanyMapper.deleteByProjectId(projectid);
			if(companyid != 0 )
			{
				ProjectCompany projectCompany = new ProjectCompany();
				projectCompany.setCompanyid(companyid);
				projectCompany.setProjectid(projectid);
				projectCompany.setModifytime(new Date());
				
				projectCompanyMapper.insert(projectCompany);
			}
			return projectid;
		}
		else{
			return projectid;
		}
	}

	private Long updateproject(Project project) {
		// TODO Auto-generated method stub
		Project tem_project = ProjectMapper.selectById(project.getId());
		tem_project.setProjectname(project.getProjectname());
		tem_project.setProjectadd(project.getProjectadd());
		tem_project.setCusprojectname(project.getCusprojectname());
		tem_project.setCusprojectphone(project.getCusprojectphone());
		tem_project.setDemandquantity(project.getDemandquantity());
		tem_project.setRequirementtype(project.getRequirementtype());
		tem_project.setIndustry(project.getIndustry());
		tem_project.setLicensekey(project.getLicensekey());
		tem_project.setMonth(project.getMonth());
		tem_project.setStarttime(project.getStarttime());
		tem_project.setTacitstarttime(project.getTacitstarttime());
		tem_project.setEndtime(project.getEndtime());
		tem_project.setModifytime(new Date());
		ProjectMapper.update(tem_project);
		return tem_project.getId();
	}


	private Long saveproject(Project project) throws Exception  {
		String projectname = project.getProjectname();
		boolean isExist = projectnameExist(projectname);
		if(isExist)
		{
	//		Logger.info("新增项目时，项目名称已经存在");
			return -2l;
		}
	
		project.setCreatetime(new Date());
		project.setModifytime(new Date());
		project.setStatus(CVal.ProjectStatus.valid);
		
		try {
			long projectId = ProjectMapper.insert(project);
			projectId = project.getId();
			if(projectId > 0)
			{
				return projectId;
			}
			return -1l;
		} catch (Exception e) {
			
			return -1l;
		}
		
	}



	private boolean projectnameExist(String projectname) {
		// TODO Auto-generated method stub
		String sql = "select a.* from project a where a.projectname = '" + projectname + "'";
		List<Project> projects = ProjectMapper.selectBysql(sql);
		if (projects != null && projects.size() > 0) {
			return true;
		}
		else {
			return false;
		}
	}



	@Override
	public void disableProject(String disableProjectIds) {
		// TODO Auto-generated method stub
		String projectId_array[] = disableProjectIds.split(",");
		for(String projectId : projectId_array)
		{
			Project project = ProjectMapper.selectById(Long.parseLong(projectId));
			int status = project.getStatus();
			if(status == 1)
			{
				status = 0;
				project.setStatus(status);
			}
			ProjectMapper.update(project);
		}
		
	}












//
//		
//
//		if (in_companyIds != null) {
//
//			if (StringUtils.isNotBlank(in_companyIds)) {
//				  sbHQL.append(" and a.id in ("); 
//				  sbHQL.append(in_companyIds);
//				  sbHQL.append(")");
//			} else {
//				sbHQL.append(" and a.id in (");
//				sbHQL.append("-1");
//				sbHQL.append(")");
//			}
//		}
//
//		if (StringUtils.isNotBlank(notin_companyIds)) {
//			
//			 sbHQL.append(" and a.id not in (");
//			 sbHQL.append(notin_companyIds); 
//			 sbHQL.append(")");
//			
//		}
//
//		String[] sortCriterions = null;
//		if(sortCriterion != null){
//			sortCriterions = new String[] { "a." + sortCriterion };
//		}
//		PagingSortDirection[] sortDirections =null;
//		if(sortDirection != null){
//			sortDirections = new PagingSortDirection[] { "desc"
//					.equals(sortDirection.toLowerCase()) ? PagingSortDirection.DESC
//					: PagingSortDirection.ASC };
//		}
//		PagingBean<Company> pagingSystemcompany = pagingDao.query(CompanyMapper,sbHQL.toString(), 
//				sortCriterions, sortDirections, startIndex, pageSize,  exportflag);
//
//		return pagingSystemcompany;
//		
//		
//	}

}
