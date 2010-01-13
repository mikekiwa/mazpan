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
/// Descripción breve de ItemCuenta
/// </summary>
public class ItemCuenta
{
    private string c;//cuenta
    private string i;//item
    private string nc;//nombre de la cuenta

	public ItemCuenta()
	{
	}

    public string nombreCuenta
    {
        set { nc = value; }
        get { return nc; }
    }
    public string cuentaId
    {
        set { c = value; }
        get { return c; }
    }
    public string itemId
    {
        set { i = value; }
        get { return i; }
    }
}
