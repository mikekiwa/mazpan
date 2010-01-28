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
/// Descripción breve de Tercero
/// </summary>
public class Tercero
{
    private string i;//id
    private string n;//nombre
    private string e;//email
    private string d;//direccion
    private string f;//telefono

	public Tercero()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}
    public string nombre
    {
        set { n = value; }
        get { return n; }
    }
    public string eMail
    {
        set { e = value; }
        get { return e; }
    }
    public string direccion
    {
        set { d = value; }
        get { return d; }
    }
    public string fono
    {
        set { f = value; }
        get { return f; }
    }
}
