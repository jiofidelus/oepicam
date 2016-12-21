package fr.ummisco.oepicam.model;

public class UserAuth {
	
	String login;
	String passwd;
	String level;
	public UserAuth() {
		super();
	}
	public UserAuth(String login, String passwd, String level) {
		super();
		this.login = login;
		this.passwd = passwd;
		this.level = level;
	}
	public String getLogin() {
		return login;
	}
	public void setLogin(String login) {
		this.login = login;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	
	

}
