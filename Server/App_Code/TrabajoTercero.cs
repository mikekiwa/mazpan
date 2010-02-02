using System;
using System.Collections.Generic;
using System.Web;

/// <summary>
/// Descripción breve de TrabajoTercero
/// </summary>
public class TrabajoTercero
{
    private string i;//id
    private string t;//trabajo
    private string c;//costo
    private string a;//agente Externo ó Tercero

	public TrabajoTercero()
	{
	}

    public string id
    {
        set { i = value; }
        get { return i; }
    }
    public string trabajo
    {
        set { t = value; }
        get { return t; }
    }
    public string costo
    {
        set { c = value; }
        get { return c; }
    }
    public string agenteExterno
    {
        set { a = value; }
        get { return a; }
    }
}
