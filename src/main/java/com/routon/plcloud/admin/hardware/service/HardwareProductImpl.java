package com.routon.plcloud.admin.hardware.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.routon.plcloud.common.PagingBean;
import com.routon.plcloud.common.model.HardwareProduct;
import com.routon.plcloud.common.persistence.HardwareProductMapper;

/**
 * 
 * @author wangxiwei
 *
 */
@Service
public class HardwareProductImpl implements HardwareService {

	@Autowired
	private HardwareProductMapper hardwareProductMapper;
	
	@Override
	public PagingBean<HardwareProduct> quryAll(int startIndex, int pageSize, String productName) {
		String sql = "select a.id, a.hardware_product_name as hardwareProductName, a.hardware_product_version as hardwareProductVersion,"
				+ " a.erpcode, a.createtime, a.modifytime, a.hardware_station as hardwareStation,"
				+ " a.operate_system as operateSystem from hardwareproduct a WHERE 1 = 1 ";
		//List<HardwareProduct> list = hardwareProductMapper.selectBySql(sql);
		
		String countSql = "select count(*) from hardwareproduct a WHERE 1 = 1 ";
		
		StringBuilder sbHQL = new StringBuilder(sql);
		StringBuilder sbHQLcount = new StringBuilder(countSql);
		if(productName != null){
			sbHQL.append("and a.hardware_product_name like '%" + productName + "%'");
			sbHQLcount.append("and a.hardware_product_name like '%" + productName + "%'");
		}
		
		List<HardwareProduct> list = hardwareProductMapper.selectByCondition(sbHQL.toString(), startIndex, pageSize);
		Integer numbers = hardwareProductMapper.selectCountSql(sbHQLcount.toString());
		
		PagingBean<HardwareProduct> pagebean = new PagingBean<HardwareProduct>();
		pagebean.setDatas(list);
		pagebean.setTotalCount(numbers);
		return pagebean;
	}

	@Override
	public Long save(String productName, String erpCode, String hardwareVersion, String hardwarePlatform,
			String systemVersion) {
		HardwareProduct hardwareProduct = new HardwareProduct();
		hardwareProduct.setCreatetime(new Date());
		hardwareProduct.setHardwareProductName(productName);
		hardwareProduct.setErpCode(erpCode);
		hardwareProduct.setHardwareProductVersion(hardwareVersion);
		hardwareProduct.setOperateSystem(systemVersion);
		hardwareProduct.setHardwareStation(hardwarePlatform);
		long id = hardwareProductMapper.insert(hardwareProduct);
		return id;
	}

	@Override
	public Long edit(Integer id, String productName, String erpCode, String hardwareVersion, String hardwarePlatform,
			String systemVersion) {
		
		HardwareProduct hardwareProduct = hardwareProductMapper.selectById(id);
		hardwareProduct.setHardwareProductName(productName);
		hardwareProduct.setErpCode(erpCode);
		hardwareProduct.setHardwareProductVersion(hardwareVersion);
		hardwareProduct.setHardwareStation(hardwarePlatform);
		hardwareProduct.setOperateSystem(systemVersion);
		hardwareProduct.setModifytime(new Date());
		hardwareProductMapper.update(hardwareProduct);
		
		return hardwareProduct.getId();
	}

	@Override
	public List<String> queryAllHardwareStation() {
		String sql = "select distinct hardwarestationname from hardwarestation;";
		List<String> list = hardwareProductMapper.selectBySql2(sql);
		return list;
	}

	@Override
	public List<String> queryAllSystemVersion() {
		String sql = "select distinct operatingsystemname from operatingsystem;";
		List<String> list = hardwareProductMapper.selectBySql2(sql);
		return list;
	}

	@Override
	public List<String> queryAllHardwareProduct() {
		String sql = "select distinct hardware_product_name from hardwareproduct;";
		List<String> list = hardwareProductMapper.selectBySql2(sql);
		return list;
	}
	
}
