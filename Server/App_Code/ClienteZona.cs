using System;
using System.Collections.Generic;
using System.Web;

/// <summary>
/// Descripción breve de ClienteZona
/// </summary>
public class ClienteZona
{
    private string c;//codigo cliente
    private string z;//zona
	
    public ClienteZona()
	{
	}

    public string CardCode
    {
        set { c = value; }
        get { return c; }
    }
    public string ShortName
    {
        set { z = value; }
        get { return z; }
    }
}
