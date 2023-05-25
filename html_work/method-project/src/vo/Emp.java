package vo;

public class Emp {
	private int empID;
	private String empName;
	private String team;
	private boolean retirer;
	
	public int getEmpID() {
		return empID;
	}
	public void setEmpID(int empID) {
		this.empID = empID;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getTeam() {
		return team;
	}
	public void setTeam(String team) {
		this.team = team;
	}
	public boolean isRetirer() {
		return retirer;
	}
	public void setRetirer(boolean retirer) {
		this.retirer = retirer;
	}
}