using System;
using System.Collections.Generic;
using System.Web;

/// <summary>
/// Descripción breve de Presupuesto
/// </summary>
public class Presupuesto
{
    private string art;
    private string ene;
    private string feb;
    private string mar;
    private string abr;
    private string may;
    private string jun;
    private string jul;
    private string ago;
    private string sep;
    private string oct;
    private string nov;
    private string dic;

	public Presupuesto()
	{
	}
    public string itemCode
    {
        set { art = value; }
        get { return art; }
    }
    public string enero
    {
        set { ene = value; }
        get { return ene; }
    }
    public string febrero
    {
        set { feb = value; }
        get { return feb; }
    }
    public string marzo
    {
        set { mar = value; }
        get { return mar; }
    }
    public string abril
    {
        set { abr = value; }
        get { return abr; }
    }
    public string mayo
    {
        set { may = value; }
        get { return may; }
    }
    public string junio
    {
        set { jun = value; }
        get { return jun; }
    }
    public string julio
    {
        set { jul = value; }
        get { return jul; }
    }
    public string agosto
    {
        set { ago = value; }
        get { return ago; }
    }
    public string septiembre
    {
        set { sep = value; }
        get { return sep; }
    }
    public string octubre
    {
        set { oct = value; }
        get { return oct; }
    }
    public string noviembre
    {
        set { nov = value; }
        get { return nov; }
    }
    public string diciembre
    {
        set { dic = value; }
        get { return dic; }
    }
}
