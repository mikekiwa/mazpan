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
public class Coneccion
{
    //public static String coneccionString = @"Data Source=192.168.3.131;Initial Catalog='Mantencion';Integrated Security=false;User='sa';Password='1234'";
    public static String coneccionString = "Data Source=localhost;Initial Catalog='Mantencion';Integrated Security=false;User='mazpan';Password='heman7'";

	public Coneccion()
	{
	}
}
