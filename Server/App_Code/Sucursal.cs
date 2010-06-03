using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

/// <summary>
/// Summary description for Sucursal
/// </summary>
public class Sucursal
{
    private string c;//codigo

	public Sucursal()
	{
	}

    public string Code
    {
        set { c = value; }
        get { return c; }
    }
}
