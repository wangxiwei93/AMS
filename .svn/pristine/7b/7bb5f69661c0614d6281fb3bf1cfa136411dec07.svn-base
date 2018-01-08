package com.routon.plcloud.admin.order.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.routon.plcloud.common.PagingBean;
import com.routon.plcloud.common.PagingSortDirection;
import com.routon.plcloud.common.UserProfile;
import com.routon.plcloud.common.dao.mybatis.PagingDaoMybatis;
import com.routon.plcloud.common.model.Company;
import com.routon.plcloud.common.model.Role;
import com.routon.plcloud.common.model.RoleMenu;
import com.routon.plcloud.common.model.UserRole;
import com.routon.plcloud.common.persistence.CompanyMapper;

@Service
public class CompanyServiceImpl implements CompanyService {
	
	@Autowired
	private CompanyMapper CompanyMapper;
	
	@Resource(name = "pagingDaoMybatis")
    private PagingDaoMybatis pagingDao;	
	
	@Transactional(readOnly = true)
	public boolean companyNameExist(String companyName, Long companyId) {
		String sql = "select a.* from company a where a.companyname = '"+companyName+"'";

		if (companyId != null) {
			sql += " and a.id <>" + companyId;
		}

		List<Company> roles = CompanyMapper.selectBySql(sql);

		if (roles != null && roles.size() > 0) {
			return true;
		} else {
			return false;
		}
	}
	

	
	
	private Long saveCompany(Company company) {
		String companyName = company.getCompanyname();
	//	String roleName = role.getName();
		boolean isExist = companyNameExist(companyName, null);

		if (isExist) {
//			logger.info("新增角色时,角色名已经存在");
			return -2l;
		}

		company.setCreatetime(new Date());
		company.setModitytime(new Date());
	//	role.setCreateTime(new Date());
	//	role.setModifyTime(new Date());

		long companyid = CompanyMapper.insert(company);
		companyid = company.getId();
		if (companyid > 0) {
			return companyid;
		}

		return -1l;
	}
	
	@Transactional(readOnly = true)
	public Company getCompanyByCompanyId(Long roleId) {
		List<Company> companys = CompanyMapper.selectById(roleId);
		Company company = companys.get(0);
		return company;
	}
	
	@Transactional(rollbackFor = Exception.class)
	public Long add(Company company, UserProfile optUser) {
	//	role.setCreateUserId(optUser.getCurrentUserId()); 
		Long companyId = saveCompany(company);

//		if (roleId > 0) {
//			String menuId_array[] = menuIds.split(",");
//
//			for (String menuId : menuId_array) {
//
//				RoleMenu roleMenu = new RoleMenu();
//				roleMenu.setMenuID(Long
//						.parseLong(menuId));
//				roleMenu.setRoleID(Long.parseLong(roleId + ""));
//				roleMenu.setModifyTime(new Date());
//
//				saveRoleMenu(roleMenu);
//			}
//
//			roleServiceLog.add(role, menuIds, optUser);
//			
//			return roleId;
//
//		} else {
//			return roleId;
//		}
		return companyId;
	}
	
	
	
	
	

	@Transactional(readOnly = true)
	public PagingBean<Company> paging(int startIndex, int pageSize,
			String sortCriterion, String sortDirection, Company queryCondition,
			String in_companyIds, String notin_companyIds, Long loginUserId, boolean exportflag) {

		String pagingQueryLanguage = " select a.* from company  a  where 1=1  ";
		// String countpagingQueryLanguage =
		// "select count(DISTINCT a) from Systemrole a  where 1=1  ";
		StringBuilder sbHQL = new StringBuilder(pagingQueryLanguage);
		// StringBuilder countsbHQL = new
		// StringBuilder(countpagingQueryLanguage);

		if (StringUtils.isNotBlank(queryCondition.getCompanyname())) {

			String companyName = queryCondition.getCompanyname();
			
			sbHQL.append(" and a.companyname like '%");
			sbHQL.append(companyName); 
			sbHQL.append("%'");
			 
		}

		

		if (in_companyIds != null) {

			if (StringUtils.isNotBlank(in_companyIds)) {
				  sbHQL.append(" and a.id in ("); 
				  sbHQL.append(in_companyIds);
				  sbHQL.append(")");
			} else {
				sbHQL.append(" and a.id in (");
				sbHQL.append("-1");
				sbHQL.append(")");
			}
		}

		if (StringUtils.isNotBlank(notin_companyIds)) {
			
			 sbHQL.append(" and a.id not in (");
			 sbHQL.append(notin_companyIds); 
			 sbHQL.append(")");
			
		}

//		if (loginUserId != null) {
//			
//			sbHQL.append(" and (select count(*) from rolemenu b where b.roleId = a.id) ");
//			sbHQL.append("- (select count(*) from rolemenu b where b.roleId = a.id ");
//			sbHQL.append("    and b.menuId IN (select c.menuId FROM rolemenu c where c.roleId in (select d.roleId from userrole d WHERE d.userId = ");
//			sbHQL.append(loginUserId);
//			sbHQL.append("))");
//			sbHQL.append(") <= 0");
//
//	
//
//		}
		
		String[] sortCriterions = null;
		if(sortCriterion != null){
			sortCriterions = new String[] { "a." + sortCriterion };
		}
		PagingSortDirection[] sortDirections =null;
		if(sortDirection != null){
			sortDirections = new PagingSortDirection[] { "desc"
					.equals(sortDirection.toLowerCase()) ? PagingSortDirection.DESC
					: PagingSortDirection.ASC };
		}
		PagingBean<Company> pagingSystemcompany = pagingDao.query(CompanyMapper,sbHQL.toString(), 
				sortCriterions, sortDirections, startIndex, pageSize,  exportflag);

		return pagingSystemcompany;
	
	}




//	@Override
//	public Long edit(Company company, UserProfile optUser) {
//		// TODO Auto-generated method stub
//		return null;
//	}

	@Transactional(rollbackFor = Exception.class)
	public Long edit(Company company, UserProfile optUser) {
		
		Long companyId = updateCompany(company);

//		if (roleId > 0) {
//			roleMenuMapper.deleteByRoleId(roleId);
//
//			String menuId_array[] = menuIds.split(",");
//			for (String menuId : menuId_array) {
//				RoleMenu roleMenu = new RoleMenu();
//				roleMenu.setMenuID(Long
//						.parseLong(menuId));
//				roleMenu.setRoleID(Long.parseLong(roleId + ""));
//				roleMenu.setModifyTime(new Date());
//
//				saveRoleMenu(roleMenu);
//			}
//			roleServiceLog.edit(role, menuIds, optUser);
//			return roleId;
//		} else {
//			return roleId;
//		}
		return companyId;
	}


//	/**
//	 * 
//	 * @param systemrole
//	 * @return
//	 */
//	private Long updateRole(Role role) {
//
//		boolean isExist = roleNameExist(role.getName(), role.getId());
//
//		if (isExist) {
//			logger.info("更新角色时,角色名已经存在");
//			return -2L;
//		}
//
//		List<Role> tem_roles = roleMapper.selectById(role.getId());
//		Role tem_role = tem_roles.get(0);
//		tem_role.setName(role.getName());
//		tem_role.setRemark(role.getRemark());
//		tem_role.setModifyTime(new Date());
//		roleMapper.update(tem_role);
//
//		return role.getId();
//	}
	
//	@Transactional(readOnly = true)
//	public boolean roleNameExist(String roleName, Long roleId) {
//		String sql = "select a.* from role a where a.name = '"+roleName+"'";
//
//		if (roleId != null) {
//			sql += " and a.id <>" + roleId;
//		}
//
//		List<Role> roles = roleMapper.selectBySql(sql);
//
//		if (roles != null && roles.size() > 0) {
//			return true;
//		} else {
//			return false;
//		}
//	}
	

private boolean roleNameExist(String companyname, Long companyid) {
	// TODO Auto-generated method stub
	String sql = "select a.* from company a where a.companyname = '"+companyname+"'";
	if (companyid != null) {
		sql += " and a.id <>" + companyid;
	}

	List<Company> roles = CompanyMapper.selectBySql(sql);

	if (roles != null && roles.size() > 0) {
		return true;
	} else {
		return false;
	}
	
}

private Long updateCompany(Company company) {
	// TODO Auto-generated method stub
	
	boolean isExist = roleNameExist(company.getCompanyname(), company.getId());

	if (isExist) {
	//	logger.info("更新角色时,角色名已经存在");
		return -2L;
	}

	List<Company> tem_companys = CompanyMapper.selectById(company.getId());
	Company tem_company = tem_companys.get(0);
	tem_company.setCompanyname(company.getCompanyname());
	tem_company.setCompanyrep(company.getCompanyrep());
	tem_company.setEnglishname(company.getEnglishname());
	tem_company.setNamespell(company.getNamespell());
	tem_company.setIdentifynum(company.getIdentifynum());
	tem_company.setRegnum(company.getRegnum());
	tem_company.setOrganizationcode(company.getOrganizationcode());
	tem_company.setTrade(company.getTrade());
	tem_company.setStatus(company.getStatus());
	tem_company.setContactname(company.getContactname());
	tem_company.setContactphone(company.getContactphone());
	tem_company.setContactfixedphone(company.getContactfixedphone());
	tem_company.setEmail(company.getEmail());
	tem_company.setSalename(company.getSalename());
	tem_company.setCountry(company.getCountry());
	tem_company.setProvince(company.getProvince());
	tem_company.setCity(company.getCity());
	tem_company.setAddress(company.getAddress());
	tem_company.setZipcode(company.getZipcode());
	tem_company.setModitytime(new Date());
	tem_company.setCreatetime(new Date());

	CompanyMapper.update(tem_company);
//	tem_role.setName(role.getName());
//	tem_role.setRemark(role.getRemark());
//	tem_role.setModifyTime(new Date());
//	roleMapper.update(tem_role);

	return company.getId();
}


/*公司与项目相关查询关系*/

//private boolean isProCompany(Long companyId) {
//
//	String sql = "select a.* from userrole a where a.roleId = " + roleId;
//	List<UserRole> roleUsers = userRoleMapper.selectBySql(sql);
//
//	if (roleUsers != null && roleUsers.size() > 0) {
//		return true;
//	} else {
//		return false;
//	}
//}



@Transactional(rollbackFor = Exception.class)
public int delete(String companyIds, UserProfile optUser) {
	String companyId_array[] = companyIds.split(",");
	int del_succee_count = 0;
	String del_succee_companyIds =  "";
	for (String companyId : companyId_array) {

//		if (isUseCompany(Long.parseLong(companyId))) {
//	//		logger.info("该角色被用户使用不能删除");
//			continue;
//		} else {
//			Long roleid = Long.parseLong(roleId);
//			roleMenuMapper.deleteByRoleId(roleid);
			
		//	roleMapper.deleteById(roleid);
		
		  Long companyid = Long.parseLong(companyId);
			CompanyMapper.deleteById(companyid);

			if(del_succee_companyIds.equals("")){
				del_succee_companyIds += companyid;
			}else {
				del_succee_companyIds += ",";
				del_succee_companyIds += companyid;
			}
			
			del_succee_count++;
		}

	if (del_succee_count == 0) {
		return -1;// 全部删除失败
	} else if (del_succee_count == companyId_array.length) {
	//	roleServiceLog.delete(del_succee_roleIds, optUser);
		return 1;// 全部删除成功
	} else {
	//	roleServiceLog.delete(del_succee_roleIds, optUser);
		return -2;// 部分删除 还有部分因用户引用关系不能删除
	}

}



	
	
}
