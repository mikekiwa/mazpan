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
/// Descripción breve de Componente
/// </summary>
public class Componente
{
    private string c;//codigo
	public Componente()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}
    public string codigo
    {
        set { c = value; }
        get { return c; }
    }

}
