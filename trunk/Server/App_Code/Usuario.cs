using System;
using System.Collections.Generic;
using System.Web;

/// <summary>
/// Descripción breve de Usuario
/// </summary>
public class Usuario
{
    private string u;//user
    private string p;//pass

	public Usuario()
	{
	}

    public string user
    {
        set { u = value; }
        get { return u; }
    }
    public string pass
    {
        set { p = value; }
        get { return p; }
    }
}
