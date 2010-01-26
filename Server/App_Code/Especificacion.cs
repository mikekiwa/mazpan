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
/// Descripción breve de Especificacion
/// </summary>
public class Especificacion
{
    private string v;//valor
    private string e;//especificacion

	public Especificacion()
	{
	}

    public string valor 
    {
        set { v = value; }
        get { return v; }
    }
    public string especificacion
    {
        set { e = value; }
        get { return e; }
    }
}
