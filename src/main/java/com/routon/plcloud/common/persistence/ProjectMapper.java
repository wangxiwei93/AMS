package com.routon.plcloud.common.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

import com.routon.plcloud.common.model.Project;



public interface ProjectMapper extends PageMapper<Project>{
	
	@Select("${sql} limit #{rowCount} offset #{offset}")
	List<Project> selectByCondition(@Param("sql") String sql,  @Param("offset")int offset, @Param("rowCount")int rowCount);

	@Select("${sql}")
	List<Project> selectBysql(@Param("sql") String sql);
	
	@Insert("INSERT INTO project (projectname,modifytime,createtime,projectadd,cusprojectname,cusprojectphone,demandquantity,requirementtype,industry,licensekey,month,starttime,endtime,tacitstarttime,status) "
			+ "VALUES (#{projectname},#{modifytime},#{createtime},#{projectadd},#{cusprojectname},#{cusprojectphone},#{demandquantity},#{requirementtype},#{industry},#{licensekey},#{month},#{starttime},#{endtime},#{tacitstarttime},#{status})")
	@SelectKey(statement="SELECT currval('project_id_seq'::regclass) AS id", keyProperty="id", before=false, resultType=long.class) 
	long insert(Project project);
	
	@Update("UPDATE  project SET projectname=#{projectname},modifytime=#{modifytime},createtime=#{createtime},projectadd=#{projectadd},cusprojectname=#{cusprojectname},cusprojectphone=#{cusprojectphone},demandquantity=#{demandquantity},requirementtype=#{requirementtype},industry=#{industry},licensekey=#{licensekey},month=#{month},starttime=#{starttime},endtime=#{endtime},tacitstarttime=#{tacitstarttime},status=#{status} "
			+ " WHERE id = #{id} ")
	void update(Project project);
	
	@Select("select * from project where id = #{id}")
	Project selectById(long id);
}
