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
		
		public function generar(asistencia:Array, desviaciones:Array, stock:Array, gastos_ac:Array , fecha:String, local:Object, mermas:Array, cantidadTotal:String, montoTotal:String):void
		{
			pdf.setFontSize(22);
          	pdf.writeText(22,"Control "+local.WhsName+" "+fecha+"\n");
          	pdf.setFontSize(8);
          	var i:int=0;
          	
          	pdf.writeText(5,"\n");
          	
          	if(gastos_ac.length>0)
          	{
          		pdf.setFontSize(12);
          		pdf.writeText(12,'Listado de Gastos\n');
          		pdf.setFontSize(8);
          		
          		pdf.addCell(70, 5,"Tipo Gasto", 1);
	          	pdf.addCell(50, 5,"Total", 1);
	          	pdf.addCell(30, 5,"Observaciones", 1);
	          	pdf.writeText(5,"\n");
	          	
          		for(i=0; i<gastos_ac.length; i++)
	          	{
	          		pdf.addCell(70, 5,gastos_ac[i].gasto, 1);
	          		pdf.addCell(50, 5,gastos_ac[i].total, 1);
	          		pdf.addCell(30, 5,gastos_ac[i].observaciones, 1);
	          		pdf.writeText(5,"\n");
	          	}
          	}
          	else
          	{
          		pdf.setFontSize(12);
          		pdf.writeText(12,"No se registra gasto alguno.\n");
          		pdf.setFontSize(8);
          	}
          	pdf.writeText(5,"\n");
          	
          	if(asistencia.length>0)
          	{
          		pdf.setFontSize(12);
          		pdf.writeText(12,"Asistencia de personal:\n");
		        pdf.setFontSize(8);
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
          		pdf.setFontSize(12);
          		pdf.writeText(12,"No se registra ingreso alguno de personal\n");
          		pdf.setFontSize(8);
          	}
          	
          	pdf.writeText(5,"\n");
          	
          	if(desviaciones.length>0)
          	{
          		pdf.setFontSize(12);
          		pdf.writeText(12,"Desviaciones:\n");
          		pdf.setFontSize(8);
          		
          		pdf.addCell(91, 5,"Item", 1);
          		pdf.addCell(23, 5,"Elaborado", 1);
          		pdf.addCell(23, 5,"Completado", 1);
          		pdf.addCell(23, 5,"Diferencia", 1);
          		pdf.addCell(17, 5,"% Logrado", 1);
          		pdf.addCell(20, 5,"% No Logrado", 1);
          		pdf.writeText(5,"\n");
          		
		        for(i=0; i<desviaciones.length; i++)
	          	{
	          		pdf.addCell(91, 5,desviaciones[i].ItemName, 1);
	          		pdf.addCell(23, 5,desviaciones[i].CantidadElaborada, 1,0,Align.RIGHT);
	          		pdf.addCell(23, 5,desviaciones[i].CantidadCompletada, 1,0,Align.RIGHT);
	          		pdf.addCell(23, 5,desviaciones[i].Diferencia, 1,0,Align.RIGHT);
	          		pdf.addCell(17, 5,desviaciones[i].Logrado, 1,0,Align.RIGHT);
	          		pdf.addCell(20, 5,desviaciones[i].NoLogrado, 1,0,Align.RIGHT);
	          		pdf.writeText(5,"\n");
	          	}
          	}
          	else
          	{
          		pdf.setFontSize(12);
          		pdf.writeText(12,"Local no registra desviaciones\n");
          		pdf.setFontSize(8);
          	}
          	
          	pdf.writeText(5,"\n");
          	
          	var contadorStock:int = 0;
          	for(i=0; i<stock.length; i++)
          	{
          		if(stock[i].mostrar) contadorStock++;
          	}
          	
          	if(contadorStock>0)
          	{
          		pdf.setFontSize(12);
          		pdf.writeText(12,"Stock:\n");
          		pdf.setFontSize(8);
          		
          		pdf.addCell(91, 5,"Item", 1);
          		pdf.addCell(23, 5,"En Stock Local", 1);
          		pdf.addCell(23, 5,"En Stock Sistema", 1);
          		pdf.addCell(20, 5,"Un. Medida", 1);
          		pdf.addCell(23, 5,"Diferencia", 1);
          		pdf.writeText(5,"\n");
          		
		        for(i=0; i<stock.length; i++)
	          	{
	          		if(stock[i].mostrar)
	          		{
		          		pdf.addCell(91, 5,stock[i].ItemName, 1);
		          		pdf.addCell(23, 5,stock[i].Local, 1,0,Align.RIGHT);
		          		pdf.addCell(23, 5,stock[i].Sistema, 1,0,Align.RIGHT);
		          		pdf.addCell(20, 5,stock[i].InvntryUom, 1,0,Align.RIGHT);
		          		pdf.addCell(23, 5,stock[i].Diferencia, 1,0,Align.RIGHT);
		          		pdf.writeText(5,"\n");
		          	}
	          	}
          	}
          	else
          	{
          		pdf.setFontSize(12);
          		pdf.writeText(12,"Local no registra stock\n");
          		pdf.setFontSize(8);
          	}
          	
          	pdf.writeText(5,"\n");
          	
          	if(mermas.length>0)
          	{
          		pdf.setFontSize(12);
          		pdf.writeText(12,"Mermas:\n");
          		pdf.setFontSize(8);
          		
          		pdf.addCell(85, 5,"Item", 1);
          		pdf.addCell(25, 5,"Fecha Salida", 1);
          		pdf.addCell(25, 5,"Cantidad", 1);
          		pdf.addCell(25, 5,"Monto", 1);
          		pdf.writeText(5,"\n");
          		
		        for(i=0; i<mermas.length; i++)
	          	{
	          		pdf.addCell(85, 5,mermas[i].Dscription, 1);
	          		if(mermas[i].U_FechSal) pdf.addCell(25, 5,mermas[i].U_FechSal, 1,0,Align.CENTER);
	          		else pdf.addCell(25, 5,"");
	          		pdf.addCell(25, 5,mermas[i].Quantity, 1,0,Align.RIGHT);
	          		pdf.addCell(25, 5,mermas[i].Monto, 1,0,Align.RIGHT);
	          		pdf.writeText(5,"\n");
	          	}
	          	pdf.writeText(1,"\n");
	          	
	          	pdf.addCell(85, 5,"");
          		pdf.addCell(25, 5,"Total",1);
          		pdf.addCell(25, 5,cantidadTotal, 1,0,Align.RIGHT);
          		pdf.addCell(25, 5,montoTotal, 1,0,Align.RIGHT);
          		pdf.writeText(5,"\n");
          	}
          	else
          	{
          		pdf.setFontSize(12);
          		pdf.writeText(12,"Local no registra mermas\n");
          		pdf.setFontSize(8);
          	}
          	
          	pdf.save(Method.REMOTE, "http://192.168.3.117/create.php",'inline', "Informe"+fecha+".pdf");
          	//pdf.save(Method.REMOTE, "http://propiedadesmartinez.cl/create.php",'inline', "Informe"+fecha+".pdf");
		}
	}
}