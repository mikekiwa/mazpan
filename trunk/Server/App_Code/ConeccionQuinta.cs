using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Descripción breve de Coneccion
/// </summary>
public class ConeccionQuinta
{
    //public static String coneccionString = @"Data Source=192.168.3.131;Initial Catalog='Mantencion';Integrated Security=false;User='sa';Password='1234'";
    //public static String coneccionString = @"Data Source=localhost\SQLEXPRESS;Initial Catalog='Mantencion';Integrated Security=false;User='mazpan';Password='heman'";
    //public static String coneccionString = @"Data Source=192.168.3.130\SQLEXPRESS;Initial Catalog='Mantencion';Integrated Security=SSPI;User='mazpan';Password='heman'";
    //public static String coneccionString = @"Data Source=SVR-MASPAN2;Initial Catalog='Mantencion';Integrated Security=false;User='sa';Password='1234'";

	//public static String coneccionStringSVRMASPAN = @"Data Source=SVR-MASPAN;Integrated Security=false;User='sa';Password='1234'";
    //public static String coneccionStringSVRMASPAN2 = @"Data Source=SVR-MASPAN2;Initial Catalog='PracticaDB';Integrated Security=false;User='sa';Password='1234'";
    
    public static String coneccionStringQUINTA = ConfigurationManager.ConnectionStrings["QUINTASQLSERVER2005"].ConnectionString;
    
    public static String SapDb = "[Quinta].[dbo]";
    public static String PracticaDb = "[ConfigERQuinta].[dbo]";
	
	public ConeccionQuinta()
	{
	}
}
