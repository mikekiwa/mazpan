using System;
using System.Collections.Generic;
using System.Web;
using System.Data;

/// <summary>
/// Descripción breve de Tablas
/// </summary>
public class Tablas
{
    private DataTable dt1;//mes actual
    private DataTable dt2;//notas credito del año
    private DataTable dt3;//mes año anterior
    private DataTable dt4;//notas credito del año anterior
    private DataTable dt5;//presupuesto
    private string cn;
    private string cc;
    private int m;//mes

	public Tablas()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}
    public DataTable t1
    {
        set { dt1 = value; }
        get { return dt1; }
    }
    public DataTable t2
    {
        set { dt2 = value; }
        get { return dt2; }
    }
    public DataTable t3
    {
        set { dt3 = value; }
        get { return dt3; }
    }
    public DataTable t4
    {
        set { dt4 = value; }
        get { return dt4; }
    }
    public DataTable t5
    {
        set { dt5 = value; }
        get { return dt5; }
    }
    public string CardName
    {
        set { cn = value; }
        get { return cn; }
    }
    public string CardCode
    {
        set { cc = value; }
        get { return cc; }
    }
    public int mes
    {
        set { m = value; }
        get { return m; }
    }
}
