package estadoResultado
{
	import componentes.Atributo;
	
	import flash.display.DisplayObject;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.formatters.NumberFormatter;
	
	import org.alivepdf.colors.RGBColor;
	import org.alivepdf.data.Grid;
	import org.alivepdf.data.GridColumn;
	import org.alivepdf.drawing.Joint;
	import org.alivepdf.fonts.CoreFont;
	import org.alivepdf.fonts.FontFamily;
	import org.alivepdf.layout.Align;
	import org.alivepdf.layout.Orientation;
	import org.alivepdf.layout.Size;
	import org.alivepdf.layout.Unit;
	import org.alivepdf.pdf.PDF;
	import org.alivepdf.saving.Method;
	
	/*
	 pdf.setFont(new CoreFont(FontFamily.HELVETICA_BOLD),8);
					
	 
pdf.setDisplayMode (Display.FULL_WIDTH, Layout.SINGLE_PAGE, PageMode.USE_NONE, 1);
	 */
	
	
	
	public class FORMATO
	{
		private var pdf:PDF;
		private var formato:NumberFormatter = new NumberFormatter();
		
		
		public function FORMATO()
		{
			pdf = new PDF(Orientation.LANDSCAPE,Unit.MM,Size.LETTER);
			pdf.setMargins(7,10,7,10);
			pdf.addPage();
			pdf.textStyle(new RGBColor(0),1);
		}
		
		public function generarGrafico(grafico:DisplayObject, img:DisplayObject, ano:String, item:String, sucursal:String):void
		{
			pdf.addImage(img,null,0,0);
			pdf.setFontSize(25);
			pdf.addText(item+" año "+ano,90,20);
			pdf.addText(sucursal, 110,30);
			pdf.addImage(grafico,null,10,30,250,160);
          	
          	pdf.save(Method.REMOTE, "http://192.168.3.117/create.php", 'inline', "Grafico.pdf");
			//pdf.save(Method.REMOTE, "http://propiedadesmartinez.cl/create.php", 'inline',"Grafico.pdf");
		}
		
		public function generarTabla(arreglo:Array,tabla:DisplayObject, img:DisplayObject, ano:String, titulo:String, sucursal:String, meses:int):void
		{
			pdf.addImage(img,null,0,0);
			pdf.setFontSize(25);
			pdf.setMargins(5,7,5,7);
			pdf.addText(titulo+" "+ano,90,20);
			pdf.addText(sucursal,110,30);
			
			pdf.setFontSize(8);
			var deltaX:int =(11-meses)*7;
			pdf.setXY(deltaX,40);
			pdf.writeText(2,"\n");
			pdf.addCell(deltaX, 4);
			pdf.addCell(45, 4,"Cuenta", 1);
			pdf.addCell(14, 4,"ENE", 1,0,Align.CENTER);
			if(meses>=1) pdf.addCell(14, 4,"FEB", 1,0,Align.CENTER);
			if(meses>=2) pdf.addCell(14, 4,"MAR", 1,0,Align.CENTER);
			if(meses>=3) pdf.addCell(14, 4,"ABR", 1,0,Align.CENTER);
			if(meses>=4) pdf.addCell(14, 4,"MAY", 1,0,Align.CENTER);
			if(meses>=5) pdf.addCell(14, 4,"JUN", 1,0,Align.CENTER);
			if(meses>=6) pdf.addCell(14, 4,"JUL", 1,0,Align.CENTER);
			if(meses>=7) pdf.addCell(14, 4,"AGO", 1,0,Align.CENTER);
			if(meses>=8) pdf.addCell(14, 4,"SEP", 1,0,Align.CENTER);
			if(meses>=9) pdf.addCell(14, 4,"OCT", 1,0,Align.CENTER);
			if(meses>=10) pdf.addCell(14, 4,"NOV", 1,0,Align.CENTER);
			if(meses>=11) pdf.addCell(14, 4,"DIC", 1,0,Align.CENTER);
			pdf.addCell(14, 4,"P. MES", 1,0,Align.CENTER);
			pdf.addCell(14, 4,"ACUM",1,0,Align.CENTER);
			pdf.addCell(17, 4,"PPTO", 1,0,Align.CENTER);
			pdf.addCell(13, 4,"DESV %", 1,0,Align.CENTER);
			pdf.writeText(5,"\n");
          	
          	for(var i:int=0; i<arreglo.length; i++)
			{
				pdf.addCell(deltaX, 4);
				if(i!=ITEMS.VENTAS && i!=ITEMS.VENTASNETAS && i!=ITEMS.COSTOS && i!=ITEMS.COSTOSTOTALES && i!=ITEMS.MARGENCOMERCIAL && i!=ITEMS.GASTOSADMISTRATIVOS && i!=ITEMS.TOTALGASTOSADMINISTRATIVOS && i!=ITEMS.MARGENOPERACIONAL && i!=ITEMS.RESULTADOANTESDEIMPUESTO && i!=ITEMS.RESULTADO)
				{
					pdf.addCell(45, 4,arreglo[i].itemName, 1);
					pdf.addCell(14, 4,arreglo[i].ENE, 1,0,Align.RIGHT);
					if(meses>=1) pdf.addCell(14, 4,arreglo[i].FEB, 1,0,Align.RIGHT);
					if(meses>=2) pdf.addCell(14, 4,arreglo[i].MAR, 1,0,Align.RIGHT);
					if(meses>=3) pdf.addCell(14, 4,arreglo[i].ABR, 1,0,Align.RIGHT);
					if(meses>=4) pdf.addCell(14, 4,arreglo[i].MAY, 1,0,Align.RIGHT);
					if(meses>=5) pdf.addCell(14, 4,arreglo[i].JUN, 1,0,Align.RIGHT);
					if(meses>=6) pdf.addCell(14, 4,arreglo[i].JUL, 1,0,Align.RIGHT);
					if(meses>=7) pdf.addCell(14, 4,arreglo[i].AGO, 1,0,Align.RIGHT);
					if(meses>=8) pdf.addCell(14, 4,arreglo[i].SEP, 1,0,Align.RIGHT);
					if(meses>=9) pdf.addCell(14, 4,arreglo[i].OCT, 1,0,Align.RIGHT);
					if(meses>=10) pdf.addCell(14, 4,arreglo[i].NOV, 1,0,Align.RIGHT);
					if(meses>=11) pdf.addCell(14, 4,arreglo[i].DIC, 1,0,Align.RIGHT);
					pdf.addCell(14, 4,arreglo[i].MES, 1,0,Align.RIGHT);
					pdf.addCell(14, 4,arreglo[i].REAL, 1,0,Align.RIGHT);
					pdf.addCell(17, 4,arreglo[i].PPTO, 1,0,Align.RIGHT);
					pdf.addCell(13, 4,arreglo[i].DESV, 1,0,Align.RIGHT);
					
				}
				else if(i!=ITEMS.VENTAS && i!=ITEMS.COSTOS && i!=ITEMS.GASTOSADMISTRATIVOS)
				{
					pdf.setFont(new CoreFont(FontFamily.HELVETICA_BOLD),8);
					pdf.addCell(45, 4,arreglo[i].itemName, 1);
					pdf.addCell(14, 4,arreglo[i].ENE, 1,0,Align.RIGHT);
					if(meses>=1) pdf.addCell(14, 4,arreglo[i].FEB, 1,0,Align.RIGHT);
					if(meses>=2) pdf.addCell(14, 4,arreglo[i].MAR, 1,0,Align.RIGHT);
					if(meses>=3) pdf.addCell(14, 4,arreglo[i].ABR, 1,0,Align.RIGHT);
					if(meses>=4) pdf.addCell(14, 4,arreglo[i].MAY, 1,0,Align.RIGHT);
					if(meses>=5) pdf.addCell(14, 4,arreglo[i].JUN, 1,0,Align.RIGHT);
					if(meses>=6) pdf.addCell(14, 4,arreglo[i].JUL, 1,0,Align.RIGHT);
					if(meses>=7) pdf.addCell(14, 4,arreglo[i].AGO, 1,0,Align.RIGHT);
					if(meses>=8) pdf.addCell(14, 4,arreglo[i].SEP, 1,0,Align.RIGHT);
					if(meses>=9) pdf.addCell(14, 4,arreglo[i].OCT, 1,0,Align.RIGHT);
					if(meses>=10) pdf.addCell(14, 4,arreglo[i].NOV, 1,0,Align.RIGHT);
					if(meses>=11) pdf.addCell(14, 4,arreglo[i].DIC, 1,0,Align.RIGHT);
					pdf.addCell(14, 4,arreglo[i].MES, 1,0,Align.RIGHT);
					pdf.addCell(14, 4,arreglo[i].REAL, 1,0,Align.RIGHT);
					pdf.addCell(17, 4,arreglo[i].PPTO, 1,0,Align.RIGHT);
					pdf.addCell(13, 4,arreglo[i].DESV, 1,0,Align.RIGHT);
					pdf.setFont(new CoreFont(FontFamily.HELVETICA),8);
				}
				else
				{
					pdf.writeText(4,"\n");
					pdf.addCell(deltaX, 4);
					pdf.setFont(new CoreFont(FontFamily.HELVETICA_BOLD),8);
					pdf.addCell(45, 4,arreglo[i].itemName, 1);
					pdf.setFont(new CoreFont(FontFamily.HELVETICA),8);
				}
				
				pdf.writeText(4,"\n");
			}
			
			
          	pdf.save(Method.REMOTE, "http://192.168.3.117/create.php", 'inline', "ER1.pdf");
			//pdf.save(Method.REMOTE, "http://propiedadesmartinez.cl/create.php", 'inline',"ER1.pdf");
		}
		
		private function removeFormatting(e:String):String
		{
			e = removeParentesis(e);
			var array:Array;
			array = e.split(".");
			return array.join("");
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
		private function parentesis(valor:String):String
		{
			var arreglo:Array = valor.split('-');
			if(arreglo.length==1) return valor;
			return "("+arreglo[1]+")";
		}
		public function generarTabla4(arreglo:Array, img:DisplayObject, ano:String, titulo:String, sucursal:String, meses:int):void
		{
			pdf.setFont(new CoreFont(FontFamily.HELVETICA),6);
			
			var elMES:String = index.meses[meses];
			var m1:String='-';
			var m2:String='-';
			var m3:String='-';
			if(meses==1){ m3='ENE';}
			if(meses==2){ m2='ENE';m3='FEB';}
			if(meses==3){ m1='ENE';m2='FEB';m3='MAR';}
			if(meses==4){ m1='FEB';m2='MAR';m3='ABR';}
			if(meses==5){ m1='MAR';m2='ABR';m3='MAY';}
			if(meses==6){ m1='ABR';m2='MAY';m3='JUN';}
			if(meses==7){ m1='MAY';m2='JUN';m3='JUL';}
			if(meses==8){ m1='JUN';m2='JUL';m3='AGO';}
			if(meses==9){ m1='JUL';m2='AGO';m3='SEP';}
			if(meses==10){ m1='AGO';m2='SEP';m3='OCT';}
			if(meses==11){ m1='SEP';m2='OCT';m3='NOV';}
			
			pdf.setFontSize(15);
			pdf.addImage(img,null,0,0);
			pdf.addCell(53,1);//espacio para la imagen
			pdf.addCell(147, 10,titulo,0,0,Align.CENTER);
			pdf.writeText(6,"\n");
			pdf.addCell(53,1);//espacio para la imagen
			pdf.addCell(147,10,elMES+" "+ano,0,0,Align.CENTER);
			pdf.writeText(10,"\n");
			
			pdf.setFontSize(8);
			pdf.writeText(2,"\n");
			pdf.addCell(47, 4,ano,1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(53, 14,"INGRESOS Y GASTOS",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(47, 4,elMES+" "+ano,1,0,Align.CENTER);
			pdf.addCell(3,1);//espacio
			pdf.addCell(47, 4,"ACUMULADO a "+elMES+" "+ano,1,0,Align.CENTER);

			pdf.writeText(5,"\n");
			pdf.addCell(15, 4,m1,1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(15, 4,m2,1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(15, 4,m3,1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(53, 4);//NADA
			pdf.addCell(1,1);//espacio
			pdf.addCell(15, 4,"REAL",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(15, 4,"PPTO",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(15, 4,"DESV",1,0,Align.CENTER);
			pdf.addCell(3,1);//espacio
			pdf.addCell(15, 4,"REAL",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(15, 4,"PPTO",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(15, 4,"DESV",1,0,Align.CENTER);
			
			pdf.writeText(5,"\n");
			pdf.addCell(15, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(15, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(15, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(53, 4);//NADA
			pdf.addCell(1,1);//espacio
			pdf.addCell(15, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(15, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(15, 4,"%",1,0,Align.CENTER);
			pdf.addCell(3,1);//espacio
			pdf.addCell(15, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(15, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(15, 4,"%",1,0,Align.CENTER);
			pdf.writeText(8,"\n");
			pdf.setFontSize(6);
			
			addDatosLineas(arreglo,ITEMS.VENTASZONAS,ITEMS.VENTASNETAS,meses,2);
			addLineaTotal(1,2);
			addTotal(arreglo,ITEMS.VENTASNETAS,meses,2);
			addLineaTotal(1,2);
			
			addDatosLineas(arreglo,ITEMS.COSTOSINSUMOSZONAS,ITEMS.COSTOSTOTALES,meses,2);
			addLineaTotal(1,2);
			addTotal(arreglo,ITEMS.COSTOSTOTALES,meses,2);
			addLineaTotal(2,2);
			addTotal(arreglo,ITEMS.MARGENCOMERCIAL,meses,2);
			addLineaTotal(1,2);
			
			addTexto("GASTOS DE ADM. Y VENTAS",2);
			addDatosLineas(arreglo,ITEMS.REMUNERACIONES,ITEMS.DEPRECIACIONES,meses,2);
			addLineaTotal(1,2);
			
			addTotalGastosAdministrativosYVentas("TOTAL GASTOS ADM. Y VENTAS",arreglo,meses,2);
			addLineaTotal(2,2);
			addTotalMargenOperacionalBruto("MARGEN OPERACIONAL BRUTO",arreglo,meses,2);
			addLineaTotal(1,2);
/////////////////////	
			
			pdf.setFontSize(8);
			pdf.writeText(2,"\n");
			pdf.addCell(47, 4,ano,1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(53, 14,"INGRESOS Y GASTOS",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(47, 4,elMES+" "+ano,1,0,Align.CENTER);
			pdf.addCell(3,1);//espacio
			pdf.addCell(47, 4,"ACUMULADO a "+elMES+" "+ano,1,0,Align.CENTER);

			pdf.writeText(5,"\n");
			pdf.addCell(15, 4,m1,1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(15, 4,m2,1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(15, 4,m3,1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(53, 4);//NADA
			pdf.addCell(1,1);//espacio
			pdf.addCell(15, 4,"REAL",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(15, 4,"");//En cualquier caso diferente del general, la desvicion no es una factor, por tanto no se coloca
			pdf.addCell(1,1);//espacio
			pdf.addCell(15, 4,"PPTO",1,0,Align.CENTER);
			pdf.addCell(3,1);//espacio
			pdf.addCell(15, 4,"REAL",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(15, 4,"");//En cualquier caso diferente del general, la desvicion no es una factor, por tanto no se coloca
			pdf.addCell(1,1);//espacio
			pdf.addCell(15, 4,"PPTO",1,0,Align.CENTER);
			
			pdf.writeText(5,"\n");
			pdf.addCell(15, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(15, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(15, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(53, 4);//NADA
			pdf.addCell(1,1);//espacio
			pdf.addCell(15, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(15, 4,"");//En cualquier caso diferente del general, la desvicion no es una factor, por tanto no se coloca
			pdf.addCell(1,1);//espacio
			pdf.addCell(15, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(3,1);//espacio
			pdf.addCell(15, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(15, 4,"");//En cualquier caso diferente del general, la desvicion no es una factor, por tanto no se coloca
			pdf.addCell(1,1);//espacio
			pdf.addCell(15, 4,"M$",1,0,Align.CENTER);
			pdf.writeText(8,"\n");
			pdf.setFontSize(6);
			
			addDatosLineas(arreglo,ITEMS.VENTASZONAS,ITEMS.VENTASNETAS,meses,2,true);
			addLineaTotal(1,2);
			addTotal(arreglo,ITEMS.VENTASNETAS,meses,2,true);
			addLineaTotal(1,2);
			
			addDatosLineas(arreglo,ITEMS.COSTOSINSUMOSZONAS,ITEMS.COSTOSTOTALES,meses,2,true);
			addLineaTotal(1,2);
			addTotal(arreglo,ITEMS.COSTOSTOTALES,meses,2,true);
			addLineaTotal(2,2);
			addTotal(arreglo,ITEMS.MARGENCOMERCIAL,meses,2,true);
			addLineaTotal(1,2);
			
			addTexto("GASTOS DE ADM. Y VENTAS",2);
			addDatosLineas(arreglo,ITEMS.REMUNERACIONES,ITEMS.DEPRECIACIONES,meses,2,true);
			addLineaTotal(1,2);
			
			addTotalGastosAdministrativosYVentas("TOTAL GASTOS ADM. Y VENTAS",arreglo,meses,2,true);
			addLineaTotal(2,2);
			addTotalMargenOperacionalBruto("MARGEN OPERACIONAL BRUTO",arreglo,meses,2,true);
			addLineaTotal(1,2);
			
			pdf.save(Method.REMOTE, "http://192.168.3.117/create.php", 'inline', "ER3-2.pdf");
			//pdf.save(Method.REMOTE, "http://propiedadesmartinez.cl/create.php", 'inline', "ER3-2.pdf");
		}
		public function generarTabla3(arreglo:Array, img:DisplayObject, ano:String, titulo:String, sucursal:String, meses:int):void
		{
			pdf.setFont(new CoreFont(FontFamily.HELVETICA),8);
			
			var elMES:String = index.meses[meses];
			var m1:String='-';
			var m2:String='-';
			var m3:String='-';
			if(meses==1){ m3='ENE';}
			if(meses==2){ m2='ENE';m3='FEB';}
			if(meses==3){ m1='ENE';m2='FEB';m3='MAR';}
			if(meses==4){ m1='FEB';m2='MAR';m3='ABR';}
			if(meses==5){ m1='MAR';m2='ABR';m3='MAY';}
			if(meses==6){ m1='ABR';m2='MAY';m3='JUN';}
			if(meses==7){ m1='MAY';m2='JUN';m3='JUL';}
			if(meses==8){ m1='JUN';m2='JUL';m3='AGO';}
			if(meses==9){ m1='JUL';m2='AGO';m3='SEP';}
			if(meses==10){ m1='AGO';m2='SEP';m3='OCT';}
			if(meses==11){ m1='SEP';m2='OCT';m3='NOV';}
			
			pdf.setFontSize(20);
			pdf.addImage(img,null,0,0);
			pdf.addCell(70,1);//espacio para la imagen
			pdf.addCell(195, 10,titulo,0,0,Align.CENTER);
			pdf.writeText(10,"\n");
			pdf.addCell(70,1);//espacio para la imagen
			pdf.addCell(195,10,elMES+" "+ano,0,0,Align.CENTER);
			pdf.writeText(10,"\n");
			
			pdf.setFontSize(8);
			pdf.writeText(2,"\n");
			pdf.addCell(62, 4,ano,1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(70, 14,"INGRESOS Y GASTOS",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(62, 4,elMES+" "+ano,1,0,Align.CENTER);
			pdf.addCell(3,1);//espacio
			pdf.addCell(62, 4,"ACUMULADO a "+elMES+" "+ano,1,0,Align.CENTER);

			pdf.writeText(5,"\n");
			pdf.addCell(20, 4,m1,1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(20, 4,m2,1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(20, 4,m3,1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(70, 4);//NADA
			pdf.addCell(1,1);//espacio
			pdf.addCell(20, 4,"REAL",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(20, 4,"PPTO",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(20, 4,"DESV",1,0,Align.CENTER);
			pdf.addCell(3,1);//espacio
			pdf.addCell(20, 4,"REAL",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(20, 4,"PPTO",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(20, 4,"DESV",1,0,Align.CENTER);
			
			pdf.writeText(5,"\n");
			pdf.addCell(20, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(20, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(20, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(70, 4);//NADA
			pdf.addCell(1,1);//espacio
			pdf.addCell(20, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(20, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(20, 4,"%",1,0,Align.CENTER);
			pdf.addCell(3,1);//espacio
			pdf.addCell(20, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(20, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(20, 4,"%",1,0,Align.CENTER);
			pdf.writeText(8,"\n");
			
			addDatosLineas(arreglo,ITEMS.VENTASZONAS,ITEMS.VENTASNETAS,meses);
			addLineaTotal();
			addTotal(arreglo,ITEMS.VENTASNETAS,meses);
			addLineaTotal();
			
			
			addDatosLineas(arreglo,ITEMS.COSTOSINSUMOSZONAS,ITEMS.COSTOSTOTALES,meses);
			addLineaTotal();
			addTotal(arreglo,ITEMS.COSTOSTOTALES,meses);
			addLineaTotal(2);
			addTotal(arreglo,ITEMS.MARGENCOMERCIAL,meses);
			addLineaTotal();
			
			addTexto("GASTOS DE ADM. Y VENTAS");
			addDatosLineas(arreglo,ITEMS.REMUNERACIONES,ITEMS.DEPRECIACIONES,meses);
			addLineaTotal();
			
			addTotalGastosAdministrativosYVentas("TOTAL GASTOS ADM. Y VENTAS",arreglo,meses);
			addLineaTotal(2);
			addTotalMargenOperacionalBruto("MARGEN OPERACIONAL BRUTO",arreglo,meses);
			addLineaTotal();
			
			addDatosLineas(arreglo,ITEMS.DEPRECIACIONES,ITEMS.TOTALGASTOSADMINISTRATIVOS,meses);
			addLineaTotal();
			addTotal(arreglo,ITEMS.MARGENOPERACIONAL,meses);
			addLineaTotal();
			
			addDatosLineas(arreglo,ITEMS.GASTOSFINANCIEROS,ITEMS.RESULTADOANTESDEIMPUESTO,meses);
			addLineaTotal();
			addTotal(arreglo,ITEMS.RESULTADOANTESDEIMPUESTO,meses);
			addLineaTotal();
			
			addDatosLineas(arreglo,ITEMS.IMPUESTOALARENTA,ITEMS.RESULTADO,meses);
			addLineaTotal();
			addTotal(arreglo,ITEMS.RESULTADO,meses);
			addLineaTotal();
			
			pdf.save(Method.REMOTE, "http://192.168.3.117/create.php", 'inline', "ER3-1.pdf");
			//pdf.save(Method.REMOTE, "http://propiedadesmartinez.cl/create.php", 'inline', "ER3-1.pdf");
		}
		
		private function getVentas(arreglo:Array,meses:int):Array
		{
			var i:int=ITEMS.VENTASNETAS;
			var s:Array = [0,0,0,0,0,0,0];
			
			if(meses==0){ s[3] = arreglo[i].ENE;}
			if(meses==1){ s[3] = arreglo[i].FEB;s[2] = arreglo[i].ENE;}
			if(meses==2){ s[3] = arreglo[i].MAR;s[2] = arreglo[i].FEB;s[1] = arreglo[i].ENE;}
			if(meses==3){ s[3] = arreglo[i].ABR;s[2] = arreglo[i].MAR;s[1] = arreglo[i].FEB;s[0] = arreglo[i].ENE;}
			if(meses==4){ s[3] = arreglo[i].MAY;s[2] = arreglo[i].ABR;s[1] = arreglo[i].MAR;s[0] = arreglo[i].FEB;}
			if(meses==5){ s[3] = arreglo[i].JUN;s[2] = arreglo[i].MAY;s[1] = arreglo[i].ABR;s[0] = arreglo[i].MAR;}
			if(meses==6){ s[3] = arreglo[i].JUL;s[2] = arreglo[i].JUN;s[1] = arreglo[i].MAY;s[0] = arreglo[i].ABR;}
			if(meses==7){ s[3] = arreglo[i].AGO;s[2] = arreglo[i].JUL;s[1] = arreglo[i].JUN;s[0] = arreglo[i].MAY;}
			if(meses==8){ s[3] = arreglo[i].SEP;s[2] = arreglo[i].AGO;s[1] = arreglo[i].JUL;s[0] = arreglo[i].JUN;}
			if(meses==9){ s[3] = arreglo[i].OCT;s[2] = arreglo[i].SEP;s[1] = arreglo[i].AGO;s[0] = arreglo[i].JUL;}
			if(meses==10){s[3] = arreglo[i].NOV;s[2] = arreglo[i].OCT;s[1] = arreglo[i].SEP;s[0] = arreglo[i].AGO;}
			if(meses==11){s[3] = arreglo[i].DIC;s[2] = arreglo[i].NOV;s[1] = arreglo[i].OCT;s[0] = arreglo[i].SEP;}
			
			s[4] = arreglo[i].MES;
			s[5] = arreglo[i].REAL;
			s[6] = arreglo[i].PPTO;
			
			return s;
		}
		private function addTotalGastosAdministrativosYVentas(nombre:String,arreglo:Array,meses:int,escala:int=1,porcentaje:Boolean=false):void
		{
			var m1:String='-';
			var m2:String='-';
			var m3:String='-';
			
			var r:String='0';
			var p:String='0';
			var d:String='0';
			
			var ra:String='0';
			var pa:String='0';
			var da:String='0';
			
			var realAux:String='0';
			
			if(meses==0){ realAux=formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].ENE))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].ENE)))+"");}
			if(meses==1){ realAux=formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].FEB))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].FEB)))+"");m3 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].ENE))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].ENE))))+"");}
			if(meses==2){ realAux=formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].MAR))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].MAR)))+"");m3 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].FEB))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].FEB))))+"");m2 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].ENE))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].ENE))))+"");}
			if(meses==3){ realAux=formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].ABR))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].ABR)))+"");m3 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].MAR))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].MAR))))+"");m2 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].FEB))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].FEB))))+"");m1 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].ENE))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].ENE))))+"");}
			if(meses==4){ realAux=formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].MAY))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].MAY)))+"");m3 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].ABR))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].ABR))))+"");m2 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].MAR))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].MAR))))+"");m1 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].FEB))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].FEB))))+"");}
			if(meses==5){ realAux=formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].JUN))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].JUN)))+"");m3 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].MAY))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].MAY))))+"");m2 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].ABR))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].ABR))))+"");m1 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].MAR))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].MAR))))+"");}
			if(meses==6){ realAux=formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].JUL))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].JUL)))+"");m3 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].JUN))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].JUN))))+"");m2 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].MAY))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].MAY))))+"");m1 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].ABR))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].ABR))))+"");}
			if(meses==7){ realAux=formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].AGO))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].AGO)))+"");m3 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].JUL))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].JUL))))+"");m2 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].JUN))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].JUN))))+"");m1 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].MAY))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].MAY))))+"");}
			if(meses==8){ realAux=formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].SEP))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].SEP)))+"");m3 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].AGO))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].AGO))))+"");m2 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].JUL))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].JUL))))+"");m1 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].JUN))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].JUN))))+"");}
			if(meses==9){ realAux=formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].OCT))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].OCT)))+"");m3 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].SEP))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].SEP))))+"");m2 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].AGO))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].AGO))))+"");m1 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].JUL))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].JUL))))+"");}
			if(meses==10){realAux=formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].NOV))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].NOV)))+"");m3 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].OCT))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].OCT))))+"");m2 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].SEP))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].SEP))))+"");m1 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].AGO))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].AGO))))+"");}
			if(meses==11){realAux=formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].DIC))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].DIC)))+"");m3 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].NOV))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].NOV))))+"");m2 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].OCT))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].OCT))))+"");m1 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].SEP))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].SEP))))+"");}
			
			
			ra = parentesis(formato.format(int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].REAL))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].REAL))));
			pa = parentesis(formato.format(int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].PPTO))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].PPTO))));
			da = parentesis(carcularDesviacion(formato.format(int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].REAL))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].REAL))),formato.format(int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].PPTO))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].PPTO))),2));
			r = parentesis(realAux);
			p = parentesis(formato.format(int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].MES))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].MES))));
			d = parentesis(carcularDesviacion(realAux,formato.format(int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].MES))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].MES))),2));
			
			if(escala==1)
			{
				pdf.setFont(new CoreFont(FontFamily.HELVETICA_BOLD),8);
			
				pdf.addCell(20,0.3,m1,0,0,Align.RIGHT);
				pdf.addCell(20,0.3,m2,0,0,Align.RIGHT);
				pdf.addCell(20,0.3,m3,0,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(70,0.3,"   "+nombre,0,0,Align.LEFT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(20,0.3,r,0,0,Align.RIGHT);
				pdf.addCell(20,0.3,p,0,0,Align.RIGHT);
				pdf.addCell(20,0.3,d,0,0,Align.RIGHT);
				pdf.addCell(3,1);//espacio
				pdf.addCell(20,0.3,ra,0,0,Align.RIGHT);
				pdf.addCell(20,0.3,pa,0,0,Align.RIGHT);
				pdf.addCell(20,0.3,da,0,0,Align.RIGHT);
				pdf.writeText(3,"\n");
			}
			else
			{
				if(!porcentaje)
				{
					pdf.setFont(new CoreFont(FontFamily.HELVETICA_BOLD),6);
				
					pdf.addCell(15,0.3,m1,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,m2,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,m3,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(53,0.3,"   "+nombre,0,0,Align.LEFT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,r,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,p,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,d,0,0,Align.RIGHT);
					pdf.addCell(3,1);//espacio
					pdf.addCell(15,0.3,ra,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,pa,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,da,0,0,Align.RIGHT);
					pdf.writeText(2,"\n");
					pdf.setFontSize(8);
				}
				else
				{
					pdf.setFont(new CoreFont(FontFamily.HELVETICA_BOLD),6);
					var ventasNetas:Array = getVentas(arreglo,meses);
						
					pdf.addCell(15,0.3,aPorcentaje(m1,ventasNetas[0]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,aPorcentaje(m2,ventasNetas[1]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,aPorcentaje(m3,ventasNetas[2]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(53,0.3,"   "+nombre,0,0,Align.LEFT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,aPorcentaje(r ,ventasNetas[3]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,"");//En cualquier caso diferente del general, la desvicion no es una factor, por tanto no se coloca
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,aPorcentaje(p ,ventasNetas[4]),0,0,Align.RIGHT);
					pdf.addCell(3,1);//espacio
					pdf.addCell(15,0.3,aPorcentaje(ra,ventasNetas[5]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,"");//En cualquier caso diferente del general, la desvicion no es una factor, por tanto no se coloca
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,aPorcentaje(pa,ventasNetas[6]),0,0,Align.RIGHT);
					pdf.writeText(2,"\n");
					pdf.setFontSize(8);
				}
			}
			
			pdf.setFont(new CoreFont(FontFamily.HELVETICA),8);
		}
		private function addTotalMargenOperacionalBruto(nombre:String,arreglo:Array,meses:int,escala:int=1,porcentaje:Boolean=false):void
		{
			var m1:String='-';
			var m2:String='-';
			var m3:String='-';
			
			var r:String='0';
			var p:String='0';
			var d:String='0';
			
			var ra:String='0';
			var pa:String='0';
			var da:String='0';
			
			var realAux:String='0';
			
			if(meses==0){ realAux=formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].ENE))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].ENE))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].ENE)))+"");}
			if(meses==1){ realAux=formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].FEB))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].FEB))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].FEB)))+"");m3 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].ENE))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].ENE))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].ENE))))+"");}
			if(meses==2){ realAux=formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].MAR))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].MAR))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].MAR)))+"");m3 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].FEB))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].FEB))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].FEB))))+"");m2 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].ENE))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].ENE))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].ENE))))+"");}
			if(meses==3){ realAux=formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].ABR))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].ABR))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].ABR)))+"");m3 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].MAR))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].MAR))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].MAR))))+"");m2 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].FEB))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].FEB))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].FEB))))+"");m1 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].ENE))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].ENE))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].ENE))))+"");}
			if(meses==4){ realAux=formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].MAY))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].MAY))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].MAY)))+"");m3 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].ABR))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].ABR))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].ABR))))+"");m2 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].MAR))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].MAR))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].MAR))))+"");m1 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].FEB))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].FEB))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].FEB))))+"");}
			if(meses==5){ realAux=formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].JUN))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].JUN))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].JUN)))+"");m3 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].MAY))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].MAY))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].MAY))))+"");m2 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].ABR))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].ABR))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].ABR))))+"");m1 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].MAR))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].MAR))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].MAR))))+"");}
			if(meses==6){ realAux=formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].JUL))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].JUL))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].JUL)))+"");m3 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].JUN))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].JUN))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].JUN))))+"");m2 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].MAY))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].MAY))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].MAY))))+"");m1 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].ABR))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].ABR))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].ABR))))+"");}
			if(meses==7){ realAux=formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].AGO))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].AGO))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].AGO)))+"");m3 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].JUL))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].JUL))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].JUL))))+"");m2 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].JUN))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].JUN))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].JUN))))+"");m1 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].MAY))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].MAY))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].MAY))))+"");}
			if(meses==8){ realAux=formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].SEP))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].SEP))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].SEP)))+"");m3 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].AGO))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].AGO))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].AGO))))+"");m2 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].JUL))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].JUL))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].JUL))))+"");m1 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].JUN))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].JUN))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].JUN))))+"");}
			if(meses==9){ realAux=formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].OCT))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].OCT))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].OCT)))+"");m3 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].SEP))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].SEP))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].SEP))))+"");m2 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].AGO))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].AGO))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].AGO))))+"");m1 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].JUL))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].JUL))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].JUL))))+"");}
			if(meses==10){realAux=formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].NOV))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].NOV))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].NOV)))+"");m3 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].OCT))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].OCT))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].OCT))))+"");m2 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].SEP))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].SEP))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].SEP))))+"");m1 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].AGO))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].AGO))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].AGO))))+"");}
			if(meses==11){realAux=formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].DIC))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].DIC))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].DIC)))+"");m3 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].NOV))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].NOV))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].NOV))))+"");m2 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].OCT))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].OCT))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].OCT))))+"");m1 = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].SEP))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].SEP))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].SEP))))+"");}
		
			
			ra = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].REAL))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].REAL))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].REAL)))+"")); 
			pa = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].PPTO))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].PPTO))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].PPTO)))+""));
			da = parentesis(carcularDesviacion(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].REAL))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].REAL))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].REAL)))+""),formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].PPTO))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].PPTO))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].PPTO)))+""),2));
			r = parentesis(realAux);
			p = parentesis(formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].MES))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].MES))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].MES)))+""));
			d = parentesis(carcularDesviacion(realAux,formato.format((int(removeFormatting(arreglo[ITEMS.MARGENCOMERCIAL].MES))+int(removeFormatting(arreglo[ITEMS.TOTALGASTOSADMINISTRATIVOS].MES))-int(removeFormatting(arreglo[ITEMS.DEPRECIACIONES].MES)))+""),2));
			
						
			if(escala==1)
			{
				pdf.setFont(new CoreFont(FontFamily.HELVETICA_BOLD),8);
				
				pdf.addCell(20,0.3,m1,0,0,Align.RIGHT);
				pdf.addCell(20,0.3,m2,0,0,Align.RIGHT);
				pdf.addCell(20,0.3,m3,0,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(70,0.3,"   "+nombre,0,0,Align.LEFT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(20,0.3,r,0,0,Align.RIGHT);
				pdf.addCell(20,0.3,p,0,0,Align.RIGHT);
				pdf.addCell(20,0.3,d,0,0,Align.RIGHT);
				pdf.addCell(3,1);//espacio
				pdf.addCell(20,0.3,ra,0,0,Align.RIGHT);
				pdf.addCell(20,0.3,pa,0,0,Align.RIGHT);
				pdf.addCell(20,0.3,da,0,0,Align.RIGHT);
				pdf.writeText(3,"\n");
			}
			else
			{
				if(!porcentaje)
				{
					pdf.setFont(new CoreFont(FontFamily.HELVETICA_BOLD),6);
					
					pdf.addCell(15,0.3,m1,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,m2,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,m3,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(53,0.3,"   "+nombre,0,0,Align.LEFT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,r,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,p,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,d,0,0,Align.RIGHT);
					pdf.addCell(3,1);//espacio
					pdf.addCell(15,0.3,ra,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,pa,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,da,0,0,Align.RIGHT);
					pdf.writeText(2,"\n");
				}
				else
				{
					pdf.setFont(new CoreFont(FontFamily.HELVETICA_BOLD),6);
					var ventasNetas:Array = getVentas(arreglo,meses);
						
					pdf.addCell(15,0.3,aPorcentaje(m1,ventasNetas[0]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,aPorcentaje(m2,ventasNetas[1]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,aPorcentaje(m3,ventasNetas[2]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(53,0.3,"   "+nombre,0,0,Align.LEFT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,aPorcentaje(r ,ventasNetas[3]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,"");//En cualquier caso diferente del general, la desvicion no es una factor, por tanto no se coloca
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,aPorcentaje(p ,ventasNetas[4]),0,0,Align.RIGHT);
					pdf.addCell(3,1);//espacio
					pdf.addCell(15,0.3,aPorcentaje(ra,ventasNetas[5]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,"");//En cualquier caso diferente del general, la desvicion no es una factor, por tanto no se coloca
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,aPorcentaje(pa,ventasNetas[6]),0,0,Align.RIGHT);
					pdf.writeText(2,"\n");
				}
			}
			
			pdf.setFont(new CoreFont(FontFamily.HELVETICA),8);
		}
		private function addTexto(texto:String,escala:int=1):void
		{
			if(escala==1)
			{
				pdf.setFont(new CoreFont(FontFamily.HELVETICA_BOLD),8);
				
				pdf.addCell(20,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(20,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(20,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(70,0.3,"   "+texto,0,0,Align.LEFT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(20,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(20,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(20,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(3,1);//espacio
				pdf.addCell(20,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(20,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(20,0.3,"",0,0,Align.RIGHT);
				pdf.writeText(3,"\n");
			}
			else
			{
				pdf.setFont(new CoreFont(FontFamily.HELVETICA_BOLD),6);
				
				pdf.addCell(15,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(15,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(15,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(53,0.3,"   "+texto,0,0,Align.LEFT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(15,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(15,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(15,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(3,1);//espacio
				pdf.addCell(15,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(15,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(15,0.3,"",0,0,Align.RIGHT);
				pdf.writeText(2,"\n");
			}
			
			pdf.setFont(new CoreFont(FontFamily.HELVETICA),8);
		}
		private function addTotal(arreglo:Array,i:int,meses:int,escala:int=1,porcentaje:Boolean=false):void
		{
			var m1:String='-';
			var m2:String='-';
			var m3:String='-';
			
			var r:String='0';
			var p:String='0';
			var d:String='0';
			
			var ra:String='0';
			var pa:String='0';
			var da:String='0';
			
			var realAux:String='0';
			
			if(meses==0){ realAux=arreglo[i].ENE}
			if(meses==1){ realAux=arreglo[i].FEB;m3 = parentesis(arreglo[i].ENE);}
			if(meses==2){ realAux=arreglo[i].MAR;m3 = parentesis(arreglo[i].FEB);m2 = parentesis(arreglo[i].ENE);}
			if(meses==3){ realAux=arreglo[i].ABR;m3 = parentesis(arreglo[i].MAR);m2 = parentesis(arreglo[i].FEB);m1 = parentesis(arreglo[i].ENE);}
			if(meses==4){ realAux=arreglo[i].MAY;m3 = parentesis(arreglo[i].ABR);m2 = parentesis(arreglo[i].MAR);m1 = parentesis(arreglo[i].FEB);}
			if(meses==5){ realAux=arreglo[i].JUN;m3 = parentesis(arreglo[i].MAY);m2 = parentesis(arreglo[i].ABR);m1 = parentesis(arreglo[i].MAR);}
			if(meses==6){ realAux=arreglo[i].JUL;m3 = parentesis(arreglo[i].JUN);m2 = parentesis(arreglo[i].MAY);m1 = parentesis(arreglo[i].ABR);}
			if(meses==7){ realAux=arreglo[i].AGO;m3 = parentesis(arreglo[i].JUL);m2 = parentesis(arreglo[i].JUN);m1 = parentesis(arreglo[i].MAY);}
			if(meses==8){ realAux=arreglo[i].SEP;m3 = parentesis(arreglo[i].AGO);m2 = parentesis(arreglo[i].JUL);m1 = parentesis(arreglo[i].JUN);}
			if(meses==9){ realAux=arreglo[i].OCT;m3 = parentesis(arreglo[i].SEP);m2 = parentesis(arreglo[i].AGO);m1 = parentesis(arreglo[i].JUL);}
			if(meses==10){ realAux=arreglo[i].NOV;m3 = parentesis(arreglo[i].OCT);m2 = parentesis(arreglo[i].SEP);m1 = parentesis(arreglo[i].AGO);}
			if(meses==11){ realAux=arreglo[i].DIC;m3 = parentesis(arreglo[i].NOV);m2 = parentesis(arreglo[i].OCT);m1 = parentesis(arreglo[i].SEP);}
			
			ra = parentesis(arreglo[i].REAL);
			pa = parentesis(arreglo[i].PPTO);
			da = parentesis(carcularDesviacion(arreglo[i].REAL,arreglo[i].PPTO,2));
			r = parentesis(realAux);
			p = parentesis(arreglo[i].MES);
			d = parentesis(carcularDesviacion(realAux,arreglo[i].MES,2));
				
			
			if(escala==1)
			{
				pdf.setFont(new CoreFont(FontFamily.HELVETICA_BOLD),8);
				
				pdf.addCell(20,0.3,m1,0,0,Align.RIGHT);
				pdf.addCell(20,0.3,m2,0,0,Align.RIGHT);
				pdf.addCell(20,0.3,m3,0,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(70,0.3,"   "+arreglo[i].nombre,0,0,Align.LEFT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(20,0.3,r,0,0,Align.RIGHT);
				pdf.addCell(20,0.3,p,0,0,Align.RIGHT);
				pdf.addCell(20,0.3,d,0,0,Align.RIGHT);
				pdf.addCell(3,1);//espacio
				pdf.addCell(20,0.3,ra,0,0,Align.RIGHT);
				pdf.addCell(20,0.3,pa,0,0,Align.RIGHT);
				pdf.addCell(20,0.3,da,0,0,Align.RIGHT);
				pdf.writeText(3,"\n");
			}
			else
			{
				if(!porcentaje)
				{
					pdf.setFont(new CoreFont(FontFamily.HELVETICA_BOLD),6);
				
					pdf.addCell(15,0.3,m1,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,m2,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,m3,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(53,0.3,"   "+arreglo[i].nombre,0,0,Align.LEFT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,r,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,p,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,d,0,0,Align.RIGHT);
					pdf.addCell(3,1);//espacio
					pdf.addCell(15,0.3,ra,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,pa,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,da,0,0,Align.RIGHT);
					pdf.writeText(2,"\n");
				}
				else
				{
					pdf.setFont(new CoreFont(FontFamily.HELVETICA_BOLD),6);
					var ventasNetas:Array = getVentas(arreglo,meses);
					
					pdf.addCell(15,0.3,aPorcentaje(m1,ventasNetas[0]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,aPorcentaje(m2,ventasNetas[1]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,aPorcentaje(m3,ventasNetas[2]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(53,0.3,"   "+arreglo[i].nombre,0,0,Align.LEFT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,aPorcentaje(r, ventasNetas[3]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,"");//En cualquier caso diferente del general, la desvicion no es una factor, por tanto no se coloca
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,aPorcentaje(p, ventasNetas[4]),0,0,Align.RIGHT);
					pdf.addCell(3,1);//espacio
					pdf.addCell(15,0.3,aPorcentaje(ra,ventasNetas[5]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,"");//En cualquier caso diferente del general, la desvicion no es una factor, por tanto no se coloca
					pdf.addCell(1,1);//espacio
					pdf.addCell(15,0.3,aPorcentaje(pa,ventasNetas[6]),0,0,Align.RIGHT);
					pdf.writeText(2,"\n");
				}
			}
			
			pdf.setFont(new CoreFont(FontFamily.HELVETICA),8);
		}
		private function carcularDesviacion(_real:String,_ppto:String,decimales:int=1):String
		{
			formato.precision=0;
			formato.useThousandsSeparator=true;
			formato.thousandsSeparatorFrom=".";
			formato.thousandsSeparatorTo=".";
			formato.decimalSeparatorFrom=",";
			formato.decimalSeparatorTo=",";
			
			var ppto:Number = Number(removeFormatting(_ppto)) as Number;
			var real:Number = Number(removeFormatting(_real)) as Number;
			
			if(ppto!=0 && real==0)
			{
				return "-100";
			}
			else if(ppto==0 && real!=0)
			{
				return "100";
			}
			else if(ppto==0 && real==0)
			{
				return "0";
			}
			else
			{ 
				var aux:Number = real/ppto;
				aux = aux - 1;
				aux = aux*1000;
				return parentesis(formato.format(Math.round(aux)/10));
			}			
		}
		private function addDatosLineas(arreglo:Array,desde:int, hasta:int,meses:int, escala:int=1,porcentaje:Boolean=false):void
		{
			var m1:String='-';
			var m2:String='-';
			var m3:String='-';
			
			var r:String='0';
			var p:String='0';
			var d:String='0';
			
			var ra:String='0';
			var pa:String='0';
			var da:String='0';
			
			var realAux:String='0';
			
			for(var i:int=desde; i<hasta; i++)
			{
				if(meses==0){ realAux=arreglo[i].ENE}
				if(meses==1){ realAux=arreglo[i].FEB;m3 = parentesis(arreglo[i].ENE);}
				if(meses==2){ realAux=arreglo[i].MAR;m3 = parentesis(arreglo[i].FEB);m2 = parentesis(arreglo[i].ENE);}
				if(meses==3){ realAux=arreglo[i].ABR;m3 = parentesis(arreglo[i].MAR);m2 = parentesis(arreglo[i].FEB);m1 = parentesis(arreglo[i].ENE);}
				if(meses==4){ realAux=arreglo[i].MAY;m3 = parentesis(arreglo[i].ABR);m2 = parentesis(arreglo[i].MAR);m1 = parentesis(arreglo[i].FEB);}
				if(meses==5){ realAux=arreglo[i].JUN;m3 = parentesis(arreglo[i].MAY);m2 = parentesis(arreglo[i].ABR);m1 = parentesis(arreglo[i].MAR);}
				if(meses==6){ realAux=arreglo[i].JUL;m3 = parentesis(arreglo[i].JUN);m2 = parentesis(arreglo[i].MAY);m1 = parentesis(arreglo[i].ABR);}
				if(meses==7){ realAux=arreglo[i].AGO;m3 = parentesis(arreglo[i].JUL);m2 = parentesis(arreglo[i].JUN);m1 = parentesis(arreglo[i].MAY);}
				if(meses==8){ realAux=arreglo[i].SEP;m3 = parentesis(arreglo[i].AGO);m2 = parentesis(arreglo[i].JUL);m1 = parentesis(arreglo[i].JUN);}
				if(meses==9){ realAux=arreglo[i].OCT;m3 = parentesis(arreglo[i].SEP);m2 = parentesis(arreglo[i].AGO);m1 = parentesis(arreglo[i].JUL);}
				if(meses==10){ realAux=arreglo[i].NOV;m3 = parentesis(arreglo[i].OCT);m2 = parentesis(arreglo[i].SEP);m1 = parentesis(arreglo[i].AGO);}
				if(meses==11){ realAux=arreglo[i].DIC;m3 = parentesis(arreglo[i].NOV);m2 = parentesis(arreglo[i].OCT);m1 = parentesis(arreglo[i].SEP);}
				
				ra = parentesis(arreglo[i].REAL);
				pa = parentesis(arreglo[i].PPTO);
				da = parentesis(carcularDesviacion(arreglo[i].REAL,arreglo[i].PPTO,2));
				r = parentesis(realAux);
				p = parentesis(arreglo[i].MES);
				d = parentesis(carcularDesviacion(realAux,arreglo[i].MES,2));
				
				if(escala==1)
				{
					pdf.addCell(20,0.3,m1,0,0,Align.RIGHT);
					pdf.addCell(20,0.3,m2,0,0,Align.RIGHT);
					pdf.addCell(20,0.3,m3,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(70,0.3,"   "+arreglo[i].nombre,0,0,Align.LEFT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(20,0.3,r,0,0,Align.RIGHT);
					pdf.addCell(20,0.3,p,0,0,Align.RIGHT);
					pdf.addCell(20,0.3,d,0,0,Align.RIGHT);
					pdf.addCell(3,1);//espacio
					pdf.addCell(20,0.3,ra,0,0,Align.RIGHT);
					pdf.addCell(20,0.3,pa,0,0,Align.RIGHT);
					pdf.addCell(20,0.3,da,0,0,Align.RIGHT);
					pdf.writeText(3,"\n");
				}
				else
				{
					if(!porcentaje)
					{
						pdf.setFont(new CoreFont(FontFamily.HELVETICA),6);
						pdf.addCell(15,0.3,m1,0,0,Align.RIGHT);
						pdf.addCell(1,1);//espacio
						pdf.addCell(15,0.3,m2,0,0,Align.RIGHT);
						pdf.addCell(1,1);//espacio
						pdf.addCell(15,0.3,m3,0,0,Align.RIGHT);
						pdf.addCell(1,1);//espacio
						pdf.addCell(53,0.3,"   "+arreglo[i].nombre,0,0,Align.LEFT);
						pdf.addCell(1,1);//espacio
						pdf.addCell(15,0.3,r,0,0,Align.RIGHT);
						pdf.addCell(1,1);//espacio
						pdf.addCell(15,0.3,p,0,0,Align.RIGHT);
						pdf.addCell(1,1);//espacio
						pdf.addCell(15,0.3,d,0,0,Align.RIGHT);//En cualquier caso diferente del general, la desvicion no es una factor, por tanto no se coloca
						pdf.addCell(3,1);//espacio
						pdf.addCell(15,0.3,ra,0,0,Align.RIGHT);
						pdf.addCell(1,1);//espacio
						pdf.addCell(15,0.3,pa,0,0,Align.RIGHT);
						pdf.addCell(1,1);//espacio
						pdf.addCell(15,0.3,da,0,0,Align.RIGHT);//En cualquier caso diferente del general, la desvicion no es una factor, por tanto no se coloca
						pdf.writeText(2,"\n");
					}
					else
					{
						pdf.setFont(new CoreFont(FontFamily.HELVETICA),6);
						var ventasNetas:Array = getVentas(arreglo,meses);
						
						pdf.addCell(15,0.3,aPorcentaje(m1,ventasNetas[0]),0,0,Align.RIGHT);
						pdf.addCell(1,1);//espacio
						pdf.addCell(15,0.3,aPorcentaje(m2,ventasNetas[1]),0,0,Align.RIGHT);
						pdf.addCell(1,1);//espacio
						pdf.addCell(15,0.3,aPorcentaje(m3,ventasNetas[2]),0,0,Align.RIGHT);
						pdf.addCell(1,1);//espacio
						pdf.addCell(53,0.3,"   "+arreglo[i].nombre,0,0,Align.LEFT);
						pdf.addCell(1,1);//espacio
						pdf.addCell(15,0.3,aPorcentaje(r,ventasNetas[3]),0,0,Align.RIGHT);
						pdf.addCell(1,1);//espacio
						pdf.addCell(15,0.3,"",0);//En cualquier caso diferente del general, la desvicion no es una factor, por tanto no se coloca
						pdf.addCell(1,1);//espacio
						pdf.addCell(15,0.3,aPorcentaje(p,ventasNetas[4]),0,0,Align.RIGHT);
						pdf.addCell(3,1);//espacio
						pdf.addCell(15,0.3,aPorcentaje(ra,ventasNetas[5]),0,0,Align.RIGHT);
						pdf.addCell(1,1);//espacio
						pdf.addCell(15,0.3,"",0);//En cualquier caso diferente del general, la desvicion no es una factor, por tanto no se coloca
						pdf.addCell(1,1);//espacio
						pdf.addCell(15,0.3,aPorcentaje(pa,ventasNetas[6]),0,0,Align.RIGHT);
						pdf.writeText(2,"\n");
					}
				}
				pdf.setFont(new CoreFont(FontFamily.HELVETICA),8);
			}
		}
		private function aPorcentaje(m:String,venta:String):String
		{
			formato.precision = 1;
			var valor:Number = Number(removeFormatting(m));
			var total:Number = Number(removeFormatting(venta));
			var salida:String="";
			
			if(total!=0)
			{
				var aux:Number = (valor*100)/total;
				var aux2:String  = "0";
				
				var arreglo:Array = aux.toString().split('.');
				if(arreglo.length==2) aux2 = arreglo.join(',');
				else aux2 = aux.toString();
				
				salida =  parentesis( formato.format(aux2) );
			}
			else salida = '100';
			
			formato.precision = 0;
			return salida;
		}
		private function addLineaTotal(lineas:int=1,escala:int=1,porcentaje:Boolean=false):void
		{
			if(lineas==2)
			{
				if(escala==1)
				{
					pdf.addCell(62,0.3,"",1,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(70,0.3,"",0,0,Align.LEFT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(62,0.3,"",1,0,Align.RIGHT);
					pdf.addCell(3,1);//espacio
					pdf.addCell(62,0.3,"",1,0,Align.RIGHT);
					pdf.writeText(2,"\n");
				}
				else
				{
					pdf.setFont(new CoreFont(FontFamily.HELVETICA),6);
			
					pdf.addCell(47,0.3,"",1,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(53,0.3,"",0,0,Align.LEFT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(47,0.3,"",1,0,Align.RIGHT);
					pdf.addCell(3,1);//espacio
					pdf.addCell(47,0.3,"",1,0,Align.RIGHT);
					pdf.writeText(1,"\n");
				}
			}
			if(escala==1)
			{
				pdf.addCell(62,0.3,"",1,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(70,0.3,"",0,0,Align.LEFT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(62,0.3,"",1,0,Align.RIGHT);
				pdf.addCell(3,1);//espacio
				pdf.addCell(62,0.3,"",1,0,Align.RIGHT);
				pdf.writeText(3,"\n");
			}
			else
			{
				pdf.setFont(new CoreFont(FontFamily.HELVETICA),6);
			
				pdf.addCell(47,0.3,"",1,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(53,0.3,"",0,0,Align.LEFT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(47,0.3,"",1,0,Align.RIGHT);
				pdf.addCell(3,1);//espacio
				pdf.addCell(47,0.3,"",1,0,Align.RIGHT);
				pdf.writeText(2,"\n");
			}
			pdf.setFont(new CoreFont(FontFamily.HELVETICA),8);
			
		}




		private function rellenar(texto:String):String
		{
			var salida:String = "";
			var largo:int = int((100 - texto.length)/2);
			for(var i:int=0; i<largo; i++)
			{
				salida +=" ";
			}
			return salida+texto;
		}
		public function generarTabla2(arreglo:Array,tabla:DisplayObject, img:DisplayObject, ano:String, titulo:String, sucursal:String, meses:int):void
		{
			formato.precision=0;
			formato.useThousandsSeparator=true;
			formato.thousandsSeparatorFrom=".";
			formato.thousandsSeparatorTo=".";
			formato.decimalSeparatorFrom=",";
			formato.decimalSeparatorTo=",";
			
			
			pdf.addImage(img,null,0,0);
			pdf.setFontSize(25);
			pdf.setMargins(5,7,5,7);
			pdf.addText(titulo+" "+ano,90,20);
			if(sucursal!="General") pdf.addText(rellenar(sucursal),10,30);
			else pdf.addText(rellenar("Consolidado"),10,30);
			
			pdf.setFontSize(8);
			
			var deltaX:int;
			if(meses==0) deltaX = 50;
			else if(meses==1) deltaX = 40;
			else if(meses==2) deltaX = 30;
			else if(meses==3) deltaX = 20;
			else if(meses==4) deltaX = 10;
			else if(meses==5) deltaX = 0;
			else if(meses==6) deltaX = 50;
			else if(meses==7) deltaX = 40;
			else if(meses==8) deltaX = 30;
			else if(meses==9) deltaX = 20;
			else if(meses==10) deltaX = 10;
			else if(meses==11) deltaX = 0;
			
			pdf.setXY(deltaX,40);
			pdf.writeText(2,"\n");
			pdf.addCell(deltaX, 4);
			pdf.addCell(45, 4, "Cuenta", 1);
			
			if(meses==0){ pdf.addCell(20, 4,"ENE", 1,0,Align.CENTER);}
			if(meses==1){ pdf.addCell(20, 4,"ENE", 1,0,Align.CENTER);pdf.addCell(2, 4);pdf.addCell(20, 4,"FEB", 1,0,Align.CENTER);}
			if(meses==2){ pdf.addCell(20, 4,"ENE", 1,0,Align.CENTER);pdf.addCell(20, 4,"FEB", 1,0,Align.CENTER);pdf.addCell(2, 4);pdf.addCell(20, 4,"MAR", 1,0,Align.CENTER);}
			if(meses==3){ pdf.addCell(20, 4,"ENE", 1,0,Align.CENTER);pdf.addCell(20, 4,"FEB", 1,0,Align.CENTER);pdf.addCell(20, 4,"MAR", 1,0,Align.CENTER);pdf.addCell(2, 4);pdf.addCell(20, 4,"ABR", 1,0,Align.CENTER);}
			if(meses==4){ pdf.addCell(20, 4,"ENE", 1,0,Align.CENTER);pdf.addCell(20, 4,"FEB", 1,0,Align.CENTER);pdf.addCell(20, 4,"MAR", 1,0,Align.CENTER);pdf.addCell(20, 4,"ABR", 1,0,Align.CENTER);pdf.addCell(2, 4);pdf.addCell(20, 4,"MAY", 1,0,Align.CENTER);}
			if(meses==5){ pdf.addCell(20, 4,"ENE", 1,0,Align.CENTER);pdf.addCell(20, 4,"FEB", 1,0,Align.CENTER);pdf.addCell(20, 4,"MAR", 1,0,Align.CENTER);pdf.addCell(20, 4,"ABR", 1,0,Align.CENTER);pdf.addCell(20, 4,"MAY", 1,0,Align.CENTER);pdf.addCell(2, 4);pdf.addCell(20, 4,"JUN", 1,0,Align.CENTER);}
			
			
			if(meses==6){ pdf.addCell(20, 4,"ENE", 1,0,Align.CENTER);pdf.addCell(20, 4,"FEB", 1,0,Align.CENTER);pdf.addCell(20, 4,"MAR", 1,0,Align.CENTER);pdf.addCell(20, 4,"ABR", 1,0,Align.CENTER);pdf.addCell(20, 4,"MAY", 1,0,Align.CENTER);pdf.addCell(20, 4,"JUN", 1,0,Align.CENTER);}
			if(meses==7){ pdf.addCell(20, 4,"ENE", 1,0,Align.CENTER);pdf.addCell(20, 4,"FEB", 1,0,Align.CENTER);pdf.addCell(20, 4,"MAR", 1,0,Align.CENTER);pdf.addCell(20, 4,"ABR", 1,0,Align.CENTER);pdf.addCell(20, 4,"MAY", 1,0,Align.CENTER);pdf.addCell(20, 4,"JUN", 1,0,Align.CENTER);pdf.addCell(20, 4,"JUL", 1,0,Align.CENTER)}
			if(meses==8){ pdf.addCell(20, 4,"ENE", 1,0,Align.CENTER);pdf.addCell(20, 4,"FEB", 1,0,Align.CENTER);pdf.addCell(20, 4,"MAR", 1,0,Align.CENTER);pdf.addCell(20, 4,"ABR", 1,0,Align.CENTER);pdf.addCell(20, 4,"MAY", 1,0,Align.CENTER);pdf.addCell(20, 4,"JUN", 1,0,Align.CENTER);pdf.addCell(20, 4,"JUL", 1,0,Align.CENTER);pdf.addCell(20, 4,"AGO", 1,0,Align.CENTER);}
			if(meses==9){ pdf.addCell(20, 4,"ENE", 1,0,Align.CENTER);pdf.addCell(20, 4,"FEB", 1,0,Align.CENTER);pdf.addCell(20, 4,"MAR", 1,0,Align.CENTER);pdf.addCell(20, 4,"ABR", 1,0,Align.CENTER);pdf.addCell(20, 4,"MAY", 1,0,Align.CENTER);pdf.addCell(20, 4,"JUN", 1,0,Align.CENTER);pdf.addCell(20, 4,"JUL", 1,0,Align.CENTER);pdf.addCell(20, 4,"AGO", 1,0,Align.CENTER);pdf.addCell(20, 4,"SEP", 1,0,Align.CENTER);}
			if(meses==10){ pdf.addCell(20, 4,"ENE", 1,0,Align.CENTER);pdf.addCell(20, 4,"FEB", 1,0,Align.CENTER);pdf.addCell(20, 4,"MAR", 1,0,Align.CENTER);pdf.addCell(20, 4,"ABR", 1,0,Align.CENTER);pdf.addCell(20, 4,"MAY", 1,0,Align.CENTER);pdf.addCell(20, 4,"JUN", 1,0,Align.CENTER);pdf.addCell(20, 4,"JUL", 1,0,Align.CENTER);pdf.addCell(20, 4,"AGO", 1,0,Align.CENTER);pdf.addCell(20, 4,"SEP", 1,0,Align.CENTER);pdf.addCell(20, 4,"OCT", 1,0,Align.CENTER);}
			if(meses==11){ pdf.addCell(20, 4,"ENE", 1,0,Align.CENTER);pdf.addCell(20, 4,"FEB", 1,0,Align.CENTER);pdf.addCell(20, 4,"MAR", 1,0,Align.CENTER);pdf.addCell(20, 4,"ABR", 1,0,Align.CENTER);pdf.addCell(20, 4,"MAY", 1,0,Align.CENTER);pdf.addCell(20, 4,"JUN", 1,0,Align.CENTER);pdf.addCell(20, 4,"JUL", 1,0,Align.CENTER);pdf.addCell(20, 4,"AGO", 1,0,Align.CENTER);pdf.addCell(20, 4,"SEP", 1,0,Align.CENTER);pdf.addCell(20, 4,"OCT", 1,0,Align.CENTER);pdf.addCell(20, 4,"NOV", 1,0,Align.CENTER);}
			
			if(meses<6)
			{
				pdf.addCell(20, 4,"P. MES", 1,0,Align.CENTER);
				pdf.addCell(20, 4,"DESV %", 1,0,Align.CENTER);
				pdf.addCell(2, 4);
				
				pdf.addCell(20, 4,"ACUM",1,0,Align.CENTER);
				pdf.addCell(20, 4,"PPTO", 1,0,Align.CENTER);
				pdf.addCell(20, 4,"DESV %", 1,0,Align.CENTER);
   			}
   			pdf.writeText(4,"\n");
          	
          	var i:int=0;
          	
          	for(i=0; i<arreglo.length; i++)
			{
				var aux1:Number=0;
				var aux2:Number=0;
				var desv:Number=0;
				
				pdf.addCell(deltaX, 4);
				if(i==ITEMS.IMPUESTOALARENTA)
				{
					pdf.addCell(45, 4, arreglo[i].itemName, 1);
					if(meses==0){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].ENE)) as Number;}
					if(meses==1){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(2, 4);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].FEB)) as Number;}
					if(meses==2){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(2, 4);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].MAR)) as Number;}
					if(meses==3){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(2, 4);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].ABR)) as Number;}
					if(meses==4){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(2, 4);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].MAY)) as Number;}
					if(meses==5){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);pdf.addCell(2, 4);pdf.addCell(20, 4,parentesis(arreglo[i].JUN+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].JUN)) as Number;}
					if(meses==6){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUN+""), 1,0,Align.RIGHT);}
					if(meses==7){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUN+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUL+""), 1,0,Align.RIGHT);}
					if(meses==8){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUN+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUL+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].AGO+""), 1,0,Align.RIGHT);}
					if(meses==9){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUN+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUL+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].AGO+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].SEP+""), 1,0,Align.RIGHT);}
					if(meses==10){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUN+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUL+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].AGO+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].SEP+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].OCT+""), 1,0,Align.RIGHT);}
					if(meses==11){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUN+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUL+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].AGO+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].SEP+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].OCT+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].NOV+""), 1,0,Align.RIGHT);}
					
					if(meses<6)
					{
						if(arreglo[i].MES==0) aux1 = 0;
						else
						{ 
							aux2 = Number(removeFormatting(arreglo[i].MES)) as Number;
							desv = aux1 / aux2;
							desv = desv - 1;
							desv = desv * 1000;
							desv = Number(formato.format(Math.round(desv)/10)) as Number;
						}
						pdf.addCell(20, 4,parentesis(arreglo[i].MES+""), 1,0,Align.RIGHT);
						pdf.addCell(20, 4,parentesis(desv+""), 1,0,Align.CENTER);
						pdf.addCell(2, 4);
						
						pdf.addCell(20, 4,parentesis(arreglo[i].REAL+""), 1,0,Align.RIGHT);
						pdf.addCell(20, 4,parentesis(arreglo[i].PPTO+""), 1,0,Align.RIGHT);
						pdf.addCell(20, 4,parentesis(arreglo[i].DESV+""), 1,0,Align.RIGHT);
					}
				}
				else if(i!=ITEMS.VENTAS && i!=ITEMS.VENTASNETAS && i!=ITEMS.COSTOS && i!=ITEMS.COSTOSTOTALES && i!=ITEMS.MARGENCOMERCIAL && i!=ITEMS.GASTOSADMISTRATIVOS && i!=ITEMS.TOTALGASTOSADMINISTRATIVOS && i!=ITEMS.MARGENOPERACIONAL && i!=ITEMS.RESULTADOANTESDEIMPUESTO && i!=ITEMS.RESULTADO)
				{
					pdf.addCell(45, 4, arreglo[i].itemName, 1);
					if(meses==0){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].ENE)) as Number;}
					if(meses==1){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(2, 4);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].FEB)) as Number;}
					if(meses==2){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(2, 4);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].MAR)) as Number;}
					if(meses==3){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(2, 4);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].ABR)) as Number;}
					if(meses==4){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(2, 4);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].MAY)) as Number;}
					if(meses==5){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);pdf.addCell(2, 4);pdf.addCell(20, 4,parentesis(arreglo[i].JUN+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].JUN)) as Number;}
					if(meses==6){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUN+""), 1,0,Align.RIGHT);}
					if(meses==7){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUN+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUL+""), 1,0,Align.RIGHT);}
					if(meses==8){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUN+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUL+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].AGO+""), 1,0,Align.RIGHT);}
					if(meses==9){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUN+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUL+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].AGO+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].SEP+""), 1,0,Align.RIGHT);}
					if(meses==10){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUN+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUL+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].AGO+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].SEP+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].OCT+""), 1,0,Align.RIGHT);}
					if(meses==11){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUN+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUL+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].AGO+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].SEP+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].OCT+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].NOV+""), 1,0,Align.RIGHT);}
					
					if(meses<6)
					{
						if(arreglo[i].PPTOMENSUAL[meses]==0) aux1 = 0;
						else
						{ 
							aux2 = Number(arreglo[i].PPTOMENSUAL[meses]) as Number;
							desv = aux1 / aux2;
							desv = desv - 1;
							desv = desv * 1000;
							desv = Number(formato.format(Math.round(desv)/10)) as Number;
						}
						pdf.addCell(20, 4,parentesis(arreglo[i].MES+""), 1,0,Align.RIGHT);
						pdf.addCell(20, 4,parentesis(desv+""), 1,0,Align.CENTER);
						pdf.addCell(2, 4);
						
						pdf.addCell(20, 4,parentesis(arreglo[i].REAL+""), 1,0,Align.RIGHT);
						pdf.addCell(20, 4,parentesis(arreglo[i].PPTO+""), 1,0,Align.RIGHT);
						pdf.addCell(20, 4,parentesis(arreglo[i].DESV+""), 1,0,Align.RIGHT);
					}
				}
				else if(i==ITEMS.RESULTADOANTESDEIMPUESTO || i==ITEMS.RESULTADO)
				{
					pdf.setFont(new CoreFont(FontFamily.HELVETICA_BOLD),8);
					pdf.addCell(45, 4, arreglo[i].itemName, 1);
					if(meses==0){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].ENE)) as Number;}
					if(meses==1){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT); pdf.addCell(2, 4);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].FEB)) as Number;}
					if(meses==2){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT); pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(2, 4);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].MAR)) as Number;}
					if(meses==3){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT); pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(2, 4);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].ABR)) as Number;}
					if(meses==4){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT); pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(2, 4);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].MAY)) as Number;}
					if(meses==5){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT); pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);pdf.addCell(2, 4);pdf.addCell(20, 4,parentesis(arreglo[i].JUN+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].JUN)) as Number;}
					if(meses==6){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT); pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUN+""), 1,0,Align.RIGHT);}
					if(meses==7){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT); pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUN+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUL+""), 1,0,Align.RIGHT);}
					if(meses==8){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT); pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUN+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUL+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].AGO+""), 1,0,Align.RIGHT);}
					if(meses==9){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT); pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUN+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUL+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].AGO+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].SEP+""), 1,0,Align.RIGHT);}
					if(meses==10){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUN+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUL+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].AGO+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].SEP+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].OCT+""), 1,0,Align.RIGHT);}
					if(meses==11){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUN+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUL+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].AGO+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].SEP+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].OCT+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].NOV+""), 1,0,Align.RIGHT);}
					
					if(meses<6)
					{
						if(arreglo[i].MES==0) aux1 = 0;
						else
						{ 
							aux2 = Number(removeFormatting(arreglo[i].MES)) as Number;
							desv = aux1/aux2;
							desv = desv - 1;
							desv = desv * 1000;
							desv = Number(formato.format(Math.round(desv)/10)) as Number;
						}
						pdf.addCell(20, 4,parentesis(arreglo[i].MES+""), 1,0,Align.RIGHT);
						pdf.addCell(20, 4,parentesis(desv+""), 1,0,Align.CENTER);
						pdf.addCell(2, 4);
						
						pdf.addCell(20, 4,parentesis(arreglo[i].REAL+""), 1,0,Align.RIGHT);
						pdf.addCell(20, 4,parentesis(arreglo[i].PPTO+""), 1,0,Align.RIGHT);
						pdf.addCell(20, 4,parentesis(arreglo[i].DESV+""), 1,0,Align.RIGHT);
						pdf.setFont(new CoreFont(FontFamily.HELVETICA),8);
					}
				}
				else if(i!=ITEMS.VENTAS && i!=ITEMS.COSTOS && i!=ITEMS.GASTOSADMISTRATIVOS)
				{
					pdf.setFont(new CoreFont(FontFamily.HELVETICA_BOLD),8);
					pdf.addCell(45, 4, arreglo[i].itemName, 1);
					if(meses==0){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].ENE)) as Number;}
					if(meses==1){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(2, 4);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].FEB)) as Number;}
					if(meses==2){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(2, 4);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].MAR)) as Number;}
					if(meses==3){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(2, 4);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].ABR)) as Number;}
					if(meses==4){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(2, 4);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].MAY)) as Number;}
					if(meses==5){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);pdf.addCell(2, 4);pdf.addCell(20, 4,parentesis(arreglo[i].JUN+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].JUN)) as Number;}
					if(meses==6){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUN+""), 1,0,Align.RIGHT);}
					if(meses==7){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUN+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUL+""), 1,0,Align.RIGHT);}
					if(meses==8){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUN+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUL+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].AGO+""), 1,0,Align.RIGHT);}
					if(meses==9){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUN+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUL+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].AGO+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].SEP+""), 1,0,Align.RIGHT);}
					if(meses==10){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT); pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUN+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUL+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].AGO+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].SEP+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].OCT+""), 1,0,Align.RIGHT);}
					if(meses==11){ pdf.addCell(20, 4,parentesis(arreglo[i].ENE+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].FEB+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].ABR+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].MAY+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUN+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].JUL+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].AGO+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].SEP+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].OCT+""), 1,0,Align.RIGHT);pdf.addCell(20, 4,parentesis(arreglo[i].NOV+""), 1,0,Align.RIGHT);}
					
					if(meses<6)
					{
						if(arreglo[i].PPTOMENSUAL[meses]==0) aux1 = 0;
						else
						{ 
							aux2 = Number(removeFormatting(arreglo[i].PPTOMENSUAL[meses])) as Number;
							desv = aux1/aux2;
							desv = desv - 1;
							desv = desv * 1000;
							desv = Number(formato.format(Math.round(desv)/10)) as Number;
						}
						pdf.addCell(20, 4,parentesis(arreglo[i].MES+""), 1,0,Align.RIGHT);
						pdf.addCell(20, 4,parentesis(desv+""), 1,0,Align.CENTER);
						pdf.addCell(2, 4);
						
						pdf.addCell(20, 4,parentesis(arreglo[i].REAL+""), 1,0,Align.RIGHT);
						pdf.addCell(20, 4,parentesis(arreglo[i].PPTO+""), 1,0,Align.RIGHT);
						pdf.addCell(20, 4,parentesis(arreglo[i].DESV+""), 1,0,Align.RIGHT);
						pdf.setFont(new CoreFont(FontFamily.HELVETICA),8);
					}
				}
				else
				{
					pdf.writeText(1,"\n");
					pdf.addCell(deltaX, 4);
					pdf.setFont(new CoreFont(FontFamily.HELVETICA_BOLD),8);
					pdf.addCell(45, 4, arreglo[i].itemName, 1);
					pdf.setFont(new CoreFont(FontFamily.HELVETICA),8);
				}
				
				pdf.writeText(4,"\n");
			}
			
/*****************************************/
			
			if(meses>5)
			{
				pdf.writeText(30,"\n");//para pasar a la proxima pagina ó para cambiar de linea en caso de estar en una pagina con POCO espacio
				deltaX = 50;//para centrar los datos
				pdf.addCell(deltaX, 4);//para centrar los datos
				pdf.addCell(45, 4, "Cuenta", 1);
				
				if(meses==6){ pdf.addCell(20, 4,"JUL", 1,0,Align.CENTER);}
				if(meses==7){ pdf.addCell(20, 4,"AGO", 1,0,Align.CENTER);}
				if(meses==8){ pdf.addCell(20, 4,"SEP", 1,0,Align.CENTER);}
				if(meses==9){ pdf.addCell(20, 4,"OCT", 1,0,Align.CENTER);}
				if(meses==10){ pdf.addCell(20, 4,"NOV", 1,0,Align.CENTER);}
				if(meses==11){ pdf.addCell(20, 4,"DIC", 1,0,Align.CENTER);}
				
				pdf.addCell(20, 4,"P. MES", 1,0,Align.CENTER);
				pdf.addCell(20, 4,"DESV %", 1,0,Align.CENTER);
				pdf.addCell(2, 4);
				
				pdf.addCell(20, 4,"ACUM",1,0,Align.CENTER);
				pdf.addCell(20, 4,"PPTO", 1,0,Align.CENTER);
				pdf.addCell(20, 4,"DESV %", 1,0,Align.CENTER);
				
				pdf.writeText(4,"\n");
				
				for(i=0; i<arreglo.length; i++)
				{
					var aux1:Number=0;
					var aux2:Number=0;
					var desv:Number=0;
					
					pdf.addCell(deltaX, 4);
					if(i==ITEMS.IMPUESTOALARENTA)
					{
						pdf.addCell(45, 4, arreglo[i].itemName, 1);
						if(meses==6){ pdf.addCell(20, 4,parentesis(arreglo[i].JUL+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].JUL)) as Number;}
						if(meses==7){ pdf.addCell(20, 4,parentesis(arreglo[i].AGO+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].AGO)) as Number;}
						if(meses==8){ pdf.addCell(20, 4,parentesis(arreglo[i].SEP+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].SEP)) as Number;}
						if(meses==9){ pdf.addCell(20, 4,parentesis(arreglo[i].OCT+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].OCT)) as Number;}
						if(meses==10){ pdf.addCell(20, 4,parentesis(arreglo[i].NOV+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].NOV)) as Number;}
						if(meses==11){ pdf.addCell(20, 4,parentesis(arreglo[i].DIC+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].DIC)) as Number;}
						
						if(arreglo[i].MES==0) aux1 = 0;
						else
						{
							aux2 = Number(removeFormatting(arreglo[i].MES)) as Number;
							desv = aux1 / aux2;
							desv = desv - 1;
							desv = desv * 1000;
							desv = Number(formato.format(Math.round(desv)/10)) as Number;
						}
						pdf.addCell(20, 4,parentesis(arreglo[i].MES+""), 1,0,Align.RIGHT);
						pdf.addCell(20, 4,parentesis(desv+""), 1,0,Align.CENTER);
						pdf.addCell(2, 4);
						
						pdf.addCell(20, 4,parentesis(arreglo[i].REAL+""), 1,0,Align.RIGHT);
						pdf.addCell(20, 4,parentesis(arreglo[i].PPTO+""), 1,0,Align.RIGHT);
						pdf.addCell(20, 4,parentesis(arreglo[i].DESV+""), 1,0,Align.RIGHT);
					}
					else if(i!=ITEMS.VENTAS && i!=ITEMS.VENTASNETAS && i!=ITEMS.COSTOS && i!=ITEMS.COSTOSTOTALES && i!=ITEMS.MARGENCOMERCIAL && i!=ITEMS.GASTOSADMISTRATIVOS && i!=ITEMS.TOTALGASTOSADMINISTRATIVOS && i!=ITEMS.MARGENOPERACIONAL && i!=ITEMS.RESULTADOANTESDEIMPUESTO && i!=ITEMS.RESULTADO)
					{
						pdf.addCell(45, 4, arreglo[i].itemName, 1);
						if(meses==6){ pdf.addCell(20, 4,parentesis(arreglo[i].JUL+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].JUL)) as Number;}
						if(meses==7){ pdf.addCell(20, 4,parentesis(arreglo[i].AGO+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].AGO)) as Number;}
						if(meses==8){ pdf.addCell(20, 4,parentesis(arreglo[i].SEP+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].SEP)) as Number;}
						if(meses==9){ pdf.addCell(20, 4,parentesis(arreglo[i].OCT+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].OCT)) as Number;}
						if(meses==10){ pdf.addCell(20, 4,parentesis(arreglo[i].NOV+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].NOV)) as Number;}
						if(meses==11){ pdf.addCell(20, 4,parentesis(arreglo[i].DIC+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].DIC)) as Number;}
						
						if(arreglo[i].PPTOMENSUAL[meses]==0) aux1 = 0;
						else
						{ 
							aux2 = Number(arreglo[i].PPTOMENSUAL[meses]) as Number;
							desv = aux1 / aux2;
							desv = desv - 1;
							desv = desv * 1000;
							desv = Number(formato.format(Math.round(desv)/10)) as Number;
						}
						pdf.addCell(20, 4,parentesis(arreglo[i].MES+""), 1,0,Align.RIGHT);
						pdf.addCell(20, 4,parentesis(desv+""), 1,0,Align.CENTER);
						pdf.addCell(2, 4);
						
						pdf.addCell(20, 4,parentesis(arreglo[i].REAL+""), 1,0,Align.RIGHT);
						pdf.addCell(20, 4,parentesis(arreglo[i].PPTO+""), 1,0,Align.RIGHT);
						pdf.addCell(20, 4,parentesis(arreglo[i].DESV+""), 1,0,Align.RIGHT);
						
					}
					else if(i==ITEMS.RESULTADOANTESDEIMPUESTO || i==ITEMS.RESULTADO)
					{
						pdf.setFont(new CoreFont(FontFamily.HELVETICA_BOLD),8);
						pdf.addCell(45, 4, arreglo[i].itemName, 1);
						
						if(meses==6){ pdf.addCell(20, 4,parentesis(arreglo[i].JUL+""), 1,0,Align.RIGHT);}
						if(meses==7){ pdf.addCell(20, 4,parentesis(arreglo[i].AGO+""), 1,0,Align.RIGHT);}
						if(meses==8){ pdf.addCell(20, 4,parentesis(arreglo[i].SEP+""), 1,0,Align.RIGHT);}
						if(meses==9){ pdf.addCell(20, 4,parentesis(arreglo[i].OCT+""), 1,0,Align.RIGHT);}
						if(meses==10){ pdf.addCell(20, 4,parentesis(arreglo[i].NOV+""), 1,0,Align.RIGHT);}
						if(meses==11){ pdf.addCell(20, 4,parentesis(arreglo[i].DIC+""), 1,0,Align.RIGHT);}
						
						if(arreglo[i].MES==0) aux1 = 0;
						else
						{ 
							aux2 = Number(removeFormatting(arreglo[i].MES)) as Number;
							desv = aux1/aux2;
							desv = desv - 1;
							desv = desv * 1000;
							desv = Number(formato.format(Math.round(desv)/10)) as Number;
						}
						pdf.addCell(20, 4,parentesis(arreglo[i].MES+""), 1,0,Align.RIGHT);
						pdf.addCell(20, 4,parentesis(desv+""), 1,0,Align.CENTER);
						pdf.addCell(2, 4);
						
						pdf.addCell(20, 4,parentesis(arreglo[i].REAL+""), 1,0,Align.RIGHT);
						pdf.addCell(20, 4,parentesis(arreglo[i].PPTO+""), 1,0,Align.RIGHT);
						pdf.addCell(20, 4,parentesis(arreglo[i].DESV+""), 1,0,Align.RIGHT);
						pdf.setFont(new CoreFont(FontFamily.HELVETICA),8);
					}
					else if(i!=ITEMS.VENTAS && i!=ITEMS.COSTOS && i!=ITEMS.GASTOSADMISTRATIVOS)
					{
						pdf.setFont(new CoreFont(FontFamily.HELVETICA_BOLD),8);
						pdf.addCell(45, 4, arreglo[i].itemName, 1);
						if(meses==6){ pdf.addCell(20, 4,parentesis(arreglo[i].JUL+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].JUL)) as Number;}
						if(meses==7){ pdf.addCell(20, 4,parentesis(arreglo[i].AGO+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].AGO)) as Number;}
						if(meses==8){ pdf.addCell(20, 4,parentesis(arreglo[i].SEP+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].SEP)) as Number;}
						if(meses==9){ pdf.addCell(20, 4,parentesis(arreglo[i].OCT+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].OCT)) as Number;}
						if(meses==10){ pdf.addCell(20, 4,parentesis(arreglo[i].NOV+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].NOV)) as Number;}
						if(meses==11){ pdf.addCell(20, 4,parentesis(arreglo[i].DIC+""), 1,0,Align.RIGHT);aux1=Number(removeFormatting(arreglo[i].DIC)) as Number;}
						
						if(arreglo[i].PPTOMENSUAL[meses]==0) aux1 = 0;
						else
						{ 
							aux2 = Number(removeFormatting(arreglo[i].PPTOMENSUAL[meses])) as Number;
							desv = aux1/aux2;
							desv = desv - 1;
							desv = desv * 1000;
							desv = Number(formato.format(Math.round(desv)/10)) as Number;
						}
						pdf.addCell(20, 4,parentesis(arreglo[i].MES+""), 1,0,Align.RIGHT);
						pdf.addCell(20, 4,parentesis(desv+""), 1,0,Align.CENTER);
						pdf.addCell(2, 4);
						
						pdf.addCell(20, 4,parentesis(arreglo[i].REAL+""), 1,0,Align.RIGHT);
						pdf.addCell(20, 4,parentesis(arreglo[i].PPTO+""), 1,0,Align.RIGHT);
						pdf.addCell(20, 4,parentesis(arreglo[i].DESV+""), 1,0,Align.RIGHT);
						pdf.setFont(new CoreFont(FontFamily.HELVETICA),8);
					}
					else
					{
						pdf.writeText(1,"\n");
						pdf.addCell(deltaX, 4);
						pdf.setFont(new CoreFont(FontFamily.HELVETICA_BOLD),8);
						pdf.addCell(45, 4, arreglo[i].itemName, 1);
						pdf.setFont(new CoreFont(FontFamily.HELVETICA),8);
					}
					
					pdf.writeText(4,"\n");
				}
			}
			
          	pdf.save(Method.REMOTE, "http://192.168.3.117/create.php", 'inline', "ER2.pdf");
			//pdf.save(Method.REMOTE, "http://propiedadesmartinez.cl/create.php", 'inline',"ER2.pdf");
		}

		public function actividades(array:ArrayCollection, fecha:String):void
		{
		 	var check:GridColumn = new GridColumn("",null,5);
		 	var codigo:GridColumn = new GridColumn("Codigo Elemento", "codigo", 30, Align.CENTER, Align.LEFT);
			var nombre:GridColumn = new GridColumn("Nombre", "nombre", 85, Align.CENTER, Align.LEFT);
			var actividad:GridColumn = new GridColumn("Actividad", "actividad", 85, Align.CENTER, Align.LEFT);
			var frecuencia:GridColumn = new GridColumn("Frecuencia", "frecuencia", 20, Align.CENTER, Align.LEFT);
			var planificada:GridColumn = new GridColumn("Planificada", "planificada", 40, Align.CENTER, Align.LEFT);
			
			var columnas:Array=new Array(check,
										 codigo,
										 nombre,
										 actividad,
										 frecuencia,
										 planificada);
										 
          	var arr:Array = new Array();
          	
          	for(var i:int=0; i<array.length; i++)
          	{
          		arr.push(array.getItemAt(i));
          		arr[i].codigo = to20(arr[i].codigo);
          	}
          	
          	var grid:Grid = new Grid(arr, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),1,Joint.BEVEL);
          	grid.columns=columnas;
          	
          	pdf.setFontSize(22);
          	pdf.writeText(20,"Actividades de Mantención "+fecha+"\n");
          	pdf.setFontSize(10);
          	pdf.addGrid(grid, 0, 0, true);
          	
          	pdf.save(Method.REMOTE, "http://192.168.3.117/create.php", 'inline', "actividades.pdf");
			//pdf.save(Method.REMOTE, "http://propiedadesmartinez.cl/create.php", 'inline', "actividades.pdf");
		}
		private function to20(codigo:String):String
		{
			for(; codigo.length<20;)
			{
				codigo += " ";
			}
			return codigo;
		}
		public function solicitudes(array:Array, fecha:String):void
		{
		 	var check:GridColumn = new GridColumn("",null,5);
		 	var actividad:GridColumn = new GridColumn("Actividad", "actividad", 80, Align.CENTER, Align.LEFT);
			var solicitada:GridColumn = new GridColumn("Solicitada", "solicitadaString", 25, Align.CENTER, Align.CENTER);
			var plazo:GridColumn = new GridColumn("Plazo [dias]", "plazo", 25, Align.CENTER, Align.RIGHT);
			var limite:GridColumn = new GridColumn("Fecha Límite", "limiteString", 25, Align.CENTER, Align.CENTER);
			var prioridad:GridColumn = new GridColumn("Prioridad", "prioridad", 20, Align.CENTER, Align.CENTER);
			var descripcion:GridColumn = new GridColumn("Descripción", "descripcion", 85, Align.CENTER, Align.LEFT);
						
			var columnas:Array=new Array(check,
										 actividad,
										 solicitada,
										 plazo,
										 limite,
										 prioridad,
										 descripcion);
										 
          	var grid:Grid = new Grid(array, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
          	grid.columns=columnas;
          	
          	pdf.setFontSize(22);
          	pdf.addText("Solicitudes de Trabajo "+fecha, 20, 20);
          	pdf.setFontSize(10);
          	pdf.addGrid(grid, 0, 18, false);
          	
          	pdf.save(Method.REMOTE, "http://192.168.3.117/create.php", 'inline', "solicitudes.pdf");
			//pdf.save(Method.REMOTE, "http://propiedadesmartinez.cl/create.php", 'inline',"solicitudes.pdf");
		}
		public function vistaComponente(componente:Object):void
		{
			pdf = new PDF(Orientation.PORTRAIT,Unit.MM,Size.LETTER);
			pdf.addPage();
			pdf.textStyle(new RGBColor(0),1);
			
			var atributos:Array = new Array();
          	atributos.push(new Atributo("SysCode",					componente.superClass));
          	atributos.push(new Atributo("Código",					componente.codigo));
          	atributos.push(new Atributo("Nombre",					componente.nombre));
          	atributos.push(new Atributo("Tipo",						componente.tipo));
          	atributos.push(new Atributo("Sistema",					componente.sistema));
          	atributos.push(new Atributo("Costo",					componente.costo));
          	atributos.push(new Atributo("Fecha Puesta en Marcha",	componente.puestaMarcha));
          	atributos.push(new Atributo("Hora de Vida Util",		componente.horasVidaUtil));
          	atributos.push(new Atributo("Descripción",				componente.descripcion));
          	var mantenciones:Array = componente.mantenciones.source as Array;
          	var especificaciones:Array = componente.especificaciones.source as Array;
          	var fabricante:Array = new Array();
          	fabricante.push(new Atributo("Nombre",			componente.fabricante.fabricante));
          	fabricante.push(new Atributo("Año",				componente.fabricante.ano));
          	fabricante.push(new Atributo("Modelo",			componente.fabricante.modelo));
          	fabricante.push(new Atributo("Marca",			componente.fabricante.marca));
          	fabricante.push(new Atributo("Pais",			componente.fabricante.pais));
          	fabricante.push(new Atributo("Serie",			componente.fabricante.serie));
          	
          	var colAtributo:GridColumn = new GridColumn("Atributo", "atributo", 80, Align.CENTER, Align.LEFT);
			var colValor:GridColumn = new GridColumn("Valor", "valor", 115, Align.CENTER, Align.LEFT);
			var colEspecificacion:GridColumn = new GridColumn("Especificación", "especificacion", 80, Align.CENTER, Align.LEFT);
			var colActividad:GridColumn = new GridColumn("Actividad", "actividad", 115, Align.CENTER, Align.LEFT);
			var colFrecuencia:GridColumn = new GridColumn("Frecuencia", "frecuencia", 40, Align.CENTER, Align.CENTER);
			var colMantencion:GridColumn = new GridColumn("Mantención", "mantencion", 40, Align.CENTER, Align.CENTER);
			
			
			var colsBasico:Array=new Array(colAtributo,colValor);
			var basico:Grid = new Grid(atributos, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
          	basico.columns=colsBasico;
          	
          	var colsEspecif:Array=new Array(colEspecificacion,colValor);
			var especif:Grid = new Grid(especificaciones, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
          	especif.columns=colsEspecif;
          	
          	var colsManten:Array=new Array(colActividad,colFrecuencia,colMantencion);
			var manten:Grid = new Grid(mantenciones, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
          	manten.columns=colsManten;
          	
          	var colsFabric:Array=new Array(colAtributo,colValor);
			var fabric:Grid = new Grid(fabricante, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
          	fabric.columns=colsFabric;
          	
          	
          	pdf.setFontSize(22);
          	pdf.addText("Datos "+componente.nombre, 20, 20);
          	pdf.setFontSize(10);
          	pdf.setY(20);
          	pdf.writeText(8,'\nDatos Básicos\n');
          	pdf.addGrid(basico);
          	pdf.writeText(8,'\nDatos del Fabricante\n');
          	pdf.addGrid(fabric);
          	
          	if(especificaciones.length>0)
          	{
          		pdf.writeText(8,'\nEspecificaciones\n');
          		pdf.addGrid(especif);
          	}
          	if(mantenciones.length>0)
          	{
          		pdf.writeText(8,'\nActividades de Mantención\n');
          		pdf.addGrid(manten);
          	}
          	
          	pdf.save(Method.REMOTE, "http://192.168.3.117/create.php", 'inline', "DatosComponente.pdf");
			//pdf.save(Method.REMOTE, "http://propiedadesmartinez.cl/create.php", 'inline', "DatosComponente.pdf");
		}
		public function vistaMaquina(maquina:Object):void
		{
			pdf = new PDF(Orientation.PORTRAIT,Unit.MM,Size.LETTER);
			pdf.addPage();
			pdf.textStyle(new RGBColor(0),1);
			
			var atributos:Array = new Array();
          	atributos.push(new Atributo("SysCode",					maquina.superClass));
          	atributos.push(new Atributo("Código",					maquina.codigo));
          	atributos.push(new Atributo("Condición de Recepcion",	maquina.condicionRecepcion));
          	atributos.push(new Atributo("Nombre",					maquina.nombre));
          	atributos.push(new Atributo("Estado",					maquina.estado));
          	atributos.push(new Atributo("Horas actuales",			maquina.horasActuales));
          	atributos.push(new Atributo("Horas diarias promedio",	maquina.horasDiariasPromedio));
          	atributos.push(new Atributo("Hora de Vida Util",		maquina.horasVidaUtil));
          	atributos.push(new Atributo("Costo",					maquina.costo));
          	atributos.push(new Atributo("Descripción",				maquina.descripcion));
          	atributos.push(new Atributo("Fecha Puesta en Marcha",	maquina.puestaMarcha));
          	atributos.push(new Atributo("Estado",					maquina.estado));
          	atributos.push(new Atributo("Ubicación",				maquina.ubicacion));
          	atributos.push(new Atributo("Tipo",						maquina.tipo));
          	var mantenciones:Array = maquina.mantenciones.source as Array;
          	var especificaciones:Array = maquina.especificaciones.source as Array;
          	var subordinados:Array = maquina.subordinados.source as Array;
          	var fabricante:Array = new Array();
          	fabricante.push(new Atributo("Nombre",			maquina.fabricante.fabricante));
          	fabricante.push(new Atributo("Año",				maquina.fabricante.ano));
          	fabricante.push(new Atributo("Modelo",			maquina.fabricante.modelo));
          	fabricante.push(new Atributo("Marca",			maquina.fabricante.marca));
          	fabricante.push(new Atributo("Serie",			maquina.fabricante.serie));
          	fabricante.push(new Atributo("Pais",			maquina.fabricante.pais));
          	
          	var colAtributo:GridColumn = 		new GridColumn("Atributo", 		"atributo", 		80, Align.CENTER, Align.LEFT);
			var colValor:GridColumn = 			new GridColumn("Valor", 		"valor", 			115, Align.CENTER, Align.LEFT);
			var colEspecificacion:GridColumn = 	new GridColumn("Especificación", "especificacion", 	80, Align.CENTER, Align.LEFT);
			var colActividad:GridColumn = 		new GridColumn("Actividad", 	"actividad", 		115, Align.CENTER, Align.LEFT);
			var colFrecuencia:GridColumn = 		new GridColumn("Frecuencia", 	"frecuencia", 		40, Align.CENTER, Align.CENTER);
			var colMantencion:GridColumn = 		new GridColumn("Mantención", 	"mantencion", 		40, Align.CENTER, Align.CENTER);
			var colCodigo:GridColumn =			new GridColumn("Código", 		"codigo", 			40, Align.CENTER, Align.LEFT);
			var colNombre:GridColumn = 			new GridColumn("Nombre", 		"nombre", 			70, Align.CENTER, Align.LEFT);
			var colDescripcion:GridColumn = 	new GridColumn("Desccioción", 	"descripcion", 		85, Align.CENTER, Align.LEFT);
			
			
			var colsBasico:Array=new Array(colAtributo,colValor);
			var basico:Grid = new Grid(atributos, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
          	basico.columns=colsBasico;
          	
          	var colsEspecif:Array=new Array(colEspecificacion,colValor);
			var especif:Grid = new Grid(especificaciones, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
          	especif.columns=colsEspecif;
          	
          	var colsManten:Array=new Array(colActividad,colFrecuencia,colMantencion);
			var manten:Grid = new Grid(mantenciones, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
          	manten.columns=colsManten;
          	
          	var colsFabric:Array=new Array(colAtributo,colValor);
			var fabric:Grid = new Grid(fabricante, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
          	fabric.columns=colsFabric;
          	
          	var colsUnion:Array=new Array(colCodigo,colNombre,colDescripcion);
			var union:Grid = new Grid(subordinados, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
          	union.columns=colsUnion;
          	
          	
          	pdf.setFontSize(22);
          	pdf.addText("Datos "+maquina.nombre, 20, 20);
          	pdf.setFontSize(10);
          	pdf.setY(20);
          	pdf.writeText(8,'\nDatos Básicos\n');
          	pdf.addGrid(basico);
          	pdf.writeText(8,'\nDatos del Fabricante\n');
          	pdf.addGrid(fabric);
          	
          	if(especificaciones.length>0)
          	{
          		pdf.writeText(8,'\nEspecificaciones\n');
          		pdf.addGrid(especif);
          	}
          	if(mantenciones.length>0)
          	{
          		pdf.writeText(8,'\nActividades de Mantención\n');
          		pdf.addGrid(manten);
          	}
          	if(subordinados.length>0)
          	{
          		pdf.writeText(8,'\nElementos Subordinados\n');
          		pdf.addGrid(union);
          	}
          	
          	pdf.save(Method.REMOTE, "http://192.168.3.117/create.php", 'inline', "DatosMaquina.pdf");
			//pdf.save(Method.REMOTE, "http://propiedadesmartinez.cl/create.php", 'inline', "DatosMaquina.pdf");
		}
		public function vistaLinea(linea:Object):void
		{
			pdf = new PDF(Orientation.PORTRAIT,Unit.MM,Size.LETTER);
			pdf.addPage();
			pdf.textStyle(new RGBColor(0),1);
			
			var atributos:Array = new Array();
          	atributos.push(new Atributo("SysCode",					linea.superClass));
          	atributos.push(new Atributo("Código",					linea.codigo));
          	atributos.push(new Atributo("Descripción",				linea.descripcion));
          	atributos.push(new Atributo("Nombre",					linea.nombre));
          	atributos.push(new Atributo("Encargado",				linea.encargado));
          	atributos.push(new Atributo("Fecha Puesta en Marcha",	linea.puestaMarcha));
          	var mantenciones:Array = linea.mantenciones.source as Array;
          	var subordinados:Array = linea.subordinados.source as Array;
          	
          	var colAtributo:GridColumn = 		new GridColumn("Atributo", 		"atributo", 		80, Align.CENTER, Align.LEFT);
			var colValor:GridColumn = 			new GridColumn("Valor", 		"valor", 			115, Align.CENTER, Align.LEFT);
			var colActividad:GridColumn = 		new GridColumn("Actividad", 	"actividad", 		115, Align.CENTER, Align.LEFT);
			var colFrecuencia:GridColumn = 		new GridColumn("Frecuencia", 	"frecuencia", 		40, Align.CENTER, Align.CENTER);
			var colMantencion:GridColumn = 		new GridColumn("Mantención", 	"mantencion", 		40, Align.CENTER, Align.CENTER);
			var colCodigo:GridColumn =			new GridColumn("Código", 		"codigo", 			40, Align.CENTER, Align.LEFT);
			var colNombre:GridColumn = 			new GridColumn("Nombre", 		"nombre", 			70, Align.CENTER, Align.LEFT);
			var colDescripcion:GridColumn = 	new GridColumn("Desccioción", 	"descripcion", 		85, Align.CENTER, Align.LEFT);
			
			
			var colsBasico:Array=new Array(colAtributo,colValor);
			var basico:Grid = new Grid(atributos, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
          	basico.columns=colsBasico;
          	
          	var colsManten:Array=new Array(colActividad,colFrecuencia,colMantencion);
			var manten:Grid = new Grid(mantenciones, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
          	manten.columns=colsManten;
          	
          	var colsUnion:Array=new Array(colCodigo,colNombre,colDescripcion);
			var union:Grid = new Grid(subordinados, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
          	union.columns=colsUnion;
          	
          	
          	pdf.setFontSize(22);
          	pdf.writeText(20,"Datos Línea "+linea.nombre);
          	pdf.setFontSize(10);
          	pdf.setY(20);
          	pdf.writeText(8,'\nDatos Básicos\n');
          	pdf.addGrid(basico);
          	
          	if(mantenciones.length>0)
          	{
          		pdf.writeText(8,'\nActividades de Mantención\n');
          		pdf.addGrid(manten);
          	}
          	if(subordinados.length>0)
          	{
          		pdf.writeText(8,'\nElementos Subordinados\n');
          		pdf.addGrid(union);
          	}
          	
          	pdf.save(Method.REMOTE, "http://192.168.3.117/create.php", 'inline', "DatosLinea.pdf");
			//pdf.save(Method.REMOTE, "http://propiedadesmartinez.cl/create.php", 'inline', "DatosLinea.pdf");
		}
	}
}