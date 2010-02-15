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
    private string i;//id
    private string pr;//privilegio
    private string r;//rut persona
    private string pl;//planta ó local

	public Usuario()
	{
	}
    public string id
    {
        set { i = value; }
        get { return i; }
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
    public string privilegio
    {
        set { pr = value; }
        get { return pr; }
    }
    public string rut_persona
    {
        set { r = value; }
        get { return r; }
    }
    public string planta
    {
        set { pl = value; }
        get { return pl; }
    }
}
