package com.routon.plcloud.common.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;

import com.routon.plcloud.common.model.Order;

/**
 * 
 * @author wangxiwei
 *
 */
public interface OrderMapper extends PageMapper<Order> {
	
	@Select("${sql} limit #{rowCount} offset #{offset}")
	List<Order> selectByCondition(@Param("sql") String sql,  @Param("offset")int offset, @Param("rowCount")int rowCount);
	
	@Insert("INSERT INTO order (ordernum,softwareerpnumber,softwaretypeversion,demandquantity,licensetype,reminderdays,bindingmode,month,starttime,endtime"
			+ ",tacitstarttime,remarks,moditytime,createtime) "
			+ " VALUES (#{ordernum},#{softwareerpnumber},#{softwaretypeversion},#{demandquantity},#{licensetype},#{reminderdays},"
			+ "#{bindingmode},#{month},#{starttime},#{endtime},#{reminderdays},#{reminderdays})")
	@SelectKey(statement="SELECT currval('order_id_seq'::regclass) AS id", keyProperty="id", before=false, resultType=long.class) 
	long insert(Order order);
}
