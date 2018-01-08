package com.routon.plcloud.common.utils;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.net.UnknownHostException;

/**
 * 
 * @author J
 *
 */
public class JsonMsgBean {
	private Integer id;
	private int code;
	private String msg;
	private String exception;
	//新增对象
	private Object obj;
	private Object obj1;

	public JsonMsgBean(Integer id, int code){
		this.setId(id);
		this.code = code;			
	}		
	
	public JsonMsgBean(Integer id, int code, String msg){
		this.setId(id);
		this.code = code;
		this.msg = msg;
	}
	
	public JsonMsgBean(Integer id, int code, String msg, Exception e){
		this.setId(id);
		this.code = code;
		this.msg = msg;
		this.exception = getStackTraceString(e);						
	}
	
	
	public JsonMsgBean(Object obj,Object obj1) {
		// TODO Auto-generated constructor stub
		this.obj = obj;
		this.obj1 = obj1;
	}

	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getException() {
		return exception;
	}
	public void setException(String exception) {
		this.exception = exception;
	}
	
	public void setException(Exception exception) {
		this.exception = getStackTraceString(exception);
	}
	
	public Object getObj() {
		return obj;
	}

	public void setObj(Object obj) {
		this.obj = obj;
	}
	
	public Object getObj1() {
		return obj1;
	}

	public void setObj1(Object obj1) {
		this.obj1 = obj1;
	}
	
    public static String getStackTraceString(Throwable tr) {
        if (tr == null) {
            return "";
        }

        Throwable t = tr;
        while (t != null) {
            if (t instanceof UnknownHostException) {
                return "";
            }
            t = t.getCause();
        }

        StringWriter sw = new StringWriter();
        PrintWriter pw = new PrintWriter(sw);
        tr.printStackTrace(pw);
        return sw.toString();
    }

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}	
}

