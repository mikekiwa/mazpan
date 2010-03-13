package locales
{
	import org.alivepdf.colors.RGBColor;
	import org.alivepdf.layout.Align;
	import org.alivepdf.layout.Orientation;
	import org.alivepdf.layout.Size;
	import org.alivepdf.layout.Unit;
	import org.alivepdf.pdf.PDF;
	import org.alivepdf.saving.Method;

	public class LayoutLocales
	{
		private var pdf:PDF;
		
		public function LayoutLocales()
		{
			pdf = new PDF(Orientation.PORTRAIT,Unit.MM,Size.LETTER);
			pdf.setMargins(10,10,10,10);
			pdf.addPage();
			pdf.textStyle(new RGBColor(0),1);
		}
		
		public function generar(asistencia:Array, desviaciones:Array, stock:Array, fecha:String, local:Object, petroleo:Object, luz:Object):void
		{
			pdf.setFontSize(22);
          	pdf.writeText(22,"Control "+local.WhsName+" "+fecha+"\n");
          	pdf.setFontSize(8);
          	var i:int=0;
          	
          	if(petroleo.id!=null || luz.id!=null)
          	{
          		pdf.writeText(8,"Gastos:\n");
          		pdf.addCell(40, 5,"Gasto", 1);
          		pdf.addCell(30, 5,"Total", 1);
          		pdf.addCell(127, 5,"Observaciones", 1);
          		pdf.writeText(5,"\n");
          		
		        if(petroleo.id!=null)
		        {
		        	pdf.addCell(40, 5,"Petroleo", 1);
	          		pdf.addCell(30, 5,petroleo.total, 1);
	          		pdf.addCell(127, 5,petroleo.observaciones, 1);
	          		pdf.writeText(5,"\n");
		        }
		       	if(luz.id!=null)
		        {
		        	pdf.addCell(40, 5,"Luz", 1);
	          		pdf.addCell(30, 5,luz.total, 1);
	          		pdf.addCell(127, 5,luz.observaciones, 1);
	          		pdf.writeText(5,"\n");
		        }
          	}
          	else
          	{
          		pdf.writeText(8,"Planta no registra gasto alguno.\n\n");
          	}
          	
          	if(asistencia.length>0)
          	{
          		pdf.writeText(8,"Asistencia de personal:\n");
		        for(i=0; i<asistencia.length; i++)
	          	{
	          		pdf.addCell(70, 5,asistencia[i].CardName, 1);
	          		pdf.addCell(50, 5,asistencia[i].asistencia, 1);
	          		if(asistencia[i].atraso) pdf.addCell(30, 5,asistencia[i].atraso+ " Hrs.", 1);
	          		pdf.writeText(5,"\n");
	          	}
          	}
          	else
          	{
          		pdf.writeText(8,"Local no registra ingreso alguno de personal el "+fecha+"\n");
          	}
          	
          	pdf.writeText(5,"\n");
          	if(desviaciones.length>0)
          	{
          		pdf.writeText(8,"Desviaciones:\n");
          		
          		pdf.addCell(85, 5,"Item", 1);
          		pdf.addCell(25, 5,"Elaborado", 1);
          		pdf.addCell(25, 5,"Completado", 1);
          		pdf.addCell(25, 5,"Diferencia", 1);
          		pdf.addCell(17, 5,"% Logrado", 1);
          		pdf.addCell(20, 5,"% No Logrado", 1);
          		pdf.writeText(5,"\n");
          		
		        for(i=0; i<desviaciones.length; i++)
	          	{
	          		pdf.addCell(85, 5,desviaciones[i].ItemName, 1);
	          		pdf.addCell(25, 5,desviaciones[i].CantidadElaborada, 1,0,Align.RIGHT);
	          		pdf.addCell(25, 5,desviaciones[i].CantidadCompletada, 1,0,Align.RIGHT);
	          		pdf.addCell(25, 5,desviaciones[i].Diferencia, 1,0,Align.RIGHT);
	          		pdf.addCell(17, 5,desviaciones[i].Logrado, 1,0,Align.RIGHT);
	          		pdf.addCell(20, 5,desviaciones[i].NoLogrado, 1,0,Align.RIGHT);
	          		pdf.writeText(5,"\n");
	          	}
          	}
          	else
          	{
          		pdf.writeText(8,"Local no registra desviaciones el "+fecha+"\n");
          	}
          	
          	pdf.writeText(5,"\n");
          	
          	var contadorStock:int = 0;
          	for(i=0; i<stock.length; i++)
          	{
          		if(stock[i].mostrar) contadorStock++;
          	}
          	
          	if(contadorStock>0)
          	{
          		pdf.writeText(8,"Stock:\n");
          		
          		pdf.addCell(85, 5,"Item", 1);
          		pdf.addCell(25, 5,"En Stock Local", 1);
          		pdf.addCell(25, 5,"En Stock Sistema", 1);
          		pdf.addCell(20, 5,"Un. Medida", 1);
          		pdf.addCell(25, 5,"Diferencia", 1);
          		pdf.writeText(5,"\n");
          		
		        for(i=0; i<stock.length; i++)
	          	{
	          		if(stock[i].mostrar)
	          		{
		          		pdf.addCell(85, 5,stock[i].ItemName, 1);
		          		pdf.addCell(25, 5,stock[i].Local, 1,0,Align.RIGHT);
		          		pdf.addCell(25, 5,stock[i].OnHand, 1,0,Align.RIGHT);
		          		pdf.addCell(20, 5,stock[i].InvntryUom, 1,0,Align.RIGHT);
		          		pdf.addCell(25, 5,stock[i].Diferencia, 1,0,Align.RIGHT);
		          		pdf.writeText(5,"\n");
		          	}
	          	}
          	}
          	else
          	{
          		pdf.writeText(8,"Local no registra stock el "+fecha+"\n");
          	}
          	
          	pdf.save(Method.REMOTE, "http://propiedadesmartinez.cl/create.php",'inline', "Informe"+fecha+".pdf");
		}
	}
}