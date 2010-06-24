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
/// Summary description for Monto
/// </summary>
public class Monto
{
    private string v;//valor
    private string i;//item
	
    public Monto()
	{
	}
    public string Column1
    {
        set { v = value; }
        get { return v; }
    }
    public string itemName
    {
        set { i = value; }
        get { return i; }
    }
}
