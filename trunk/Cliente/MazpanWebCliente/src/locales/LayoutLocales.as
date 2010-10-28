package locales
{
	
	import mx.formatters.NumberFormatter;
	
	import org.alivepdf.colors.RGBColor;
	import org.alivepdf.display.Display;
	import org.alivepdf.layout.Align;
	import org.alivepdf.layout.Orientation;
	import org.alivepdf.layout.Size;
	import org.alivepdf.layout.Unit;
	import org.alivepdf.pdf.PDF;
	import org.alivepdf.saving.Method;

	public class LayoutLocales
	{
		private var pdf:PDF;
		private var formato:NumberFormatter = new NumberFormatter();
			
		public function LayoutLocales()
		{
			pdf = new PDF(Orientation.PORTRAIT,Unit.MM,Size.LETTER);
			pdf.setDisplayMode(Display.FULL_WIDTH);
			pdf.setMargins(10,10,10,10);
			pdf.addPage();
			pdf.textStyle(new RGBColor(0),1);
			
			formato.precision=2;
			formato.useThousandsSeparator=true;
			formato.thousandsSeparatorFrom=".";
			formato.thousandsSeparatorTo=".";
			formato.decimalSeparatorFrom=",";
			formato.decimalSeparatorTo=",";
		}
		private function removeFormatting(e:String):String
		{
			e = removeParentesis(e);
			var array:Array;
			array = e.split(".");
			var salida:String = array.join("");
			array = salida.split(",");
			return array.join(".");
		}
		private function removeParentesis(e:String):String
		{
			var aux:String;
			var array:Array;
			array = e.split("(");
			aux = array.join("");
			if(array.length==2) aux = "-"+aux;
			array = aux.split(")");
			return array.join("");
		}
		public function generar(asistencia:Array, desviaciones:Array, stock:Array, gastos_ac:Array , fecha:String, local:Object, mermas:Array, cantidadTotalProducida:String, cantidadTotalMermada:String, montoTotalMermado:String):void
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
	          	pdf.addCell(50, 5,"Total", 1,0,Align.CENTER);
	          	pdf.addCell(20, 5,"Unidad", 1);
	          	pdf.addCell(20, 5,"Fecha", 1);
	          	pdf.addCell(30, 5,"Observaciones", 1);
	          	pdf.writeText(5,"\n");
	          	
          		for(i=0; i<gastos_ac.length; i++)
	          	{
	          		pdf.addCell(70, 5,gastos_ac[i].gasto, 1);
	          		pdf.addCell(50, 5,gastos_ac[i].total, 1,0,Align.RIGHT);
	          		pdf.addCell(20, 5,gastos_ac[i].unidad, 1);
	          		pdf.addCell(20, 5,gastos_ac[i].ddmmaaaa, 1);
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
          		pdf.addCell(20, 5,"Congelado", 1,0,Align.CENTER);
          		pdf.addCell(20, 5,"Horneado", 1,0,Align.CENTER);
          		pdf.addCell(20, 5,"Diferencia", 1,0,Align.CENTER);
          		pdf.addCell(20, 5,"Desviación %", 1,0,Align.CENTER);
          		pdf.writeText(5,"\n");
          		
          		var a1:Number;
          		var a2:Number;
		        for(i=0; i<desviaciones.length; i++)
	          	{//aqui ver si referencia es menor para colocar todo el texto en color diferente
	          		
	          		pdf.addCell(91, 5,desviaciones[i].ItemName, 1);
	          		pdf.addCell(20, 5,desviaciones[i].CONSUMIDO, 1,0,Align.RIGHT);
	          		pdf.addCell(20, 5,desviaciones[i].HORNEADO, 1,0,Align.RIGHT);
	          		pdf.addCell(20, 5,desviaciones[i].Diferencia, 1,0,Align.RIGHT);
	          		pdf.addCell(20, 5,desviaciones[i].Desviacion, 1,0,Align.RIGHT);
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
          		pdf.addCell(18, 5,"Un. Medida", 1,0,Align.CENTER);
          		pdf.addCell(23, 5,"Diferencia", 1,0,Align.CENTER);
          		pdf.writeText(5,"\n");
          		
		        for(i=0; i<stock.length; i++)
	          	{
	          		if(stock[i].mostrar)
	          		{
		          		pdf.addCell(91, 5,stock[i].ItemName, 1);
		          		pdf.addCell(23, 5,stock[i].Local, 1,0,Align.RIGHT);
		          		pdf.addCell(23, 5,stock[i].Sistema, 1,0,Align.RIGHT);
		          		pdf.addCell(18, 5,stock[i].InvntryUom, 1,0,Align.RIGHT);
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
          		pdf.addCell(25, 5,"Cant. Producida", 1,0,Align.CENTER);
          		pdf.addCell(25, 5,"Cant. Mermada", 1,0,Align.CENTER);
          		pdf.addCell(25, 5,"Desviación", 1,0,Align.CENTER);
          		pdf.addCell(25, 5,"Monto $", 1,0,Align.CENTER);
          		pdf.writeText(5,"\n");
          		
		        for(i=0; i<mermas.length; i++)
	          	{
	          		pdf.addCell(85, 5,mermas[i].Dscription, 1);
	          		pdf.addCell(25, 5,mermas[i].PRODUCIDO, 1,0,Align.RIGHT);
	          		pdf.addCell(25, 5,mermas[i].MERMADO, 1,0,Align.RIGHT);
	          		pdf.addCell(25, 5,mermas[i].Desviacion, 1,0,Align.RIGHT);
	          		pdf.addCell(25, 5,mermas[i].MONTOSTOCK, 1,0,Align.RIGHT);
	          		pdf.writeText(5,"\n");
	          	}
	          	pdf.writeText(1,"\n");
	          	
	          	pdf.addCell(55, 5,"");
          		pdf.addCell(30, 5,"Total",1);
          		pdf.addCell(25, 5,cantidadTotalProducida, 1,0,Align.RIGHT);
          		pdf.addCell(25, 5,cantidadTotalMermada, 1,0,Align.RIGHT);          		
          		if(cantidadTotalProducida!='0')
        		{
        			cantidadTotalProducida = removeFormatting(cantidadTotalProducida);
        			var ef:Number = Number(removeFormatting(cantidadTotalMermada));
        			ef = ef*100;
        			var desv:String = formato.format(ef/Number(cantidadTotalProducida));
        			pdf.addCell(25, 5,desv,1,0,Align.RIGHT);
        		}
        		else pdf.addCell(25, 5,'100',1,0,Align.RIGHT);
          		pdf.addCell(25, 5,montoTotalMermado, 1,0,Align.RIGHT);
          		
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