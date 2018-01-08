package com.routon.plcloud.admin.order.service;

import java.util.List;

import org.apache.poi.hssf.record.formula.functions.Int;

import com.routon.plcloud.admin.privilege.model.TreeBean;
import com.routon.plcloud.common.PagingBean;
import com.routon.plcloud.common.UserProfile;
import com.routon.plcloud.common.model.Company;

import com.routon.plcloud.common.model.Project;

public interface ProjectService {

//	PUBLIC LONG ADD(GROUP GROUP, USERPROFILE OPTUSER) THROWS EXCEPTION;
//
//	PUBLIC LONG EDIT(GROUP GROUP, USERPROFILE OPTUSER);
//
//	PUBLIC INT DELETE(STRING IDS, USERPROFILE OPTUSER) THROWS EXCEPTION;

	public Long move(Company group, UserProfile optUser);
	
	

	public List<TreeBean> getCompanyTreeByUserId(Long opuserId,
			Company queryCondition, Long userId  );

//	public List<TreeBean> getCompanyTreeByUserId(Long opuserId,
//			Company queryCondition, Long userId, boolean onlyleafcheck);

	public List<TreeBean> getCompanyTreeByUserId(Long opuserId,
			Company queryCondition, Long userId, boolean onlyleafcheck,
			boolean showRelevanceCount);
	
	public PagingBean<Project> paging(int startIndex, int pageSize, String sortCriterion,
			String sortDirection, Project queryCondition1, String in_projectIds,
			String notin_projectIds, Long id , Long loginUserId, boolean exportflag);



	public Long add(Project project, int companyid, UserProfile optUser) throws Exception;



	public Long edit(Project project, int companyid, UserProfile optUser);



	public void disableProject(String disableProjectIds);



	
}

