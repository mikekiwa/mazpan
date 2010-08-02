package estadoResultado
{
	import flash.display.DisplayObject;
	
	import mx.formatters.NumberFormatter;
	
	import org.alivepdf.colors.RGBColor;
	import org.alivepdf.display.Display;
	import org.alivepdf.fonts.CoreFont;
	import org.alivepdf.fonts.FontFamily;
	import org.alivepdf.layout.Align;
	import org.alivepdf.layout.Layout;
	import org.alivepdf.layout.Orientation;
	import org.alivepdf.layout.Size;
	import org.alivepdf.layout.Unit;
	import org.alivepdf.pdf.PDF;
	import org.alivepdf.saving.Method;
	
	public class FORMATO4
	{
		private var pdf:PDF;
		private var formato:NumberFormatter = new NumberFormatter();
		private var titulo_var:String = "Estado de Resultado Consolidado";
		
		public function FORMATO4()
		{
			pdf = new PDF(Orientation.LANDSCAPE,Unit.MM,Size.LETTER);
			pdf.setMargins(7,10,7,10);
			pdf.addPage();
			pdf.textStyle(new RGBColor(0),1);
			pdf.setDisplayMode(Display.FULL_PAGE,Layout.SINGLE_PAGE);
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
		
		
		public function generarTabla3(arreglo:Array, img:DisplayObject, ano:String, titulo:String, sucursal:String, meses:int):void
		{
			pdf.setFont(new CoreFont(FontFamily.HELVETICA),8);
			
			var elMES:String = index.meses[meses];
			var m1:String='-';
			var m2:String='-';
			var m3:String='-';
			var m0:String='-';
			if(meses==1){ m3='ENE';}
			if(meses==2){ m2='ENE';m3='FEB';}
			if(meses==3){ m1='ENE';m2='FEB';m3='MAR';}
			if(meses==4){ m0='ENE';m1='FEB';m2='MAR';m3='ABR';}
			if(meses==5){ m0='ENE-FEB';m1='MAR';m2='ABR';m3='MAY';}
			if(meses==6){ m0='ENE-MAR';m1='ABR';m2='MAY';m3='JUN';}
			if(meses==7){ m0='ENE-ABR';m1='MAY';m2='JUN';m3='JUL';}
			if(meses==8){ m0='ENE-MAY';m1='JUN';m2='JUL';m3='AGO';}
			if(meses==9){ m0='ENE-JUN';m1='JUL';m2='AGO';m3='SEP';}
			if(meses==10){m0='ENE-JUL';m1='AGO';m2='SEP';m3='OCT';}
			if(meses==11){m0='ENE-AGO';m1='SEP';m2='OCT';m3='NOV';}
			
			pdf.setFontSize(20);
			pdf.addImage(img,null,0,0);
			pdf.addCell(70,1);//espacio para la imagen
			pdf.addCell(195, 10,titulo,0,0,Align.CENTER);
			pdf.writeText(10,"\n");
			pdf.addCell(70,1);//espacio para la imagen
			pdf.addCell(195,10,elMES+" "+ano,0,0,Align.CENTER);
			pdf.writeText(10,"\n");
/******************************************************/
/******************************************************/
/******************************************************/
/******************************************************/
/******************************************************/			
			pdf.setFontSize(8);
			pdf.writeText(2,"\n");
			pdf.addCell(83, 4,ano,1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(60, 14,"INGRESOS Y GASTOS",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(60, 4,elMES+" "+ano,1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(60, 4,"ACUMULADO a "+elMES+" "+ano,1,0,Align.CENTER);
			pdf.writeText(5,"\n");
			
			/******************************************************/
			pdf.addCell(20, 4,m0,1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			/******************************************************/
			pdf.addCell(20, 4,m1,1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(20, 4,m2,1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(20, 4,m3,1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(60, 4);//NADA
			pdf.addCell(1,1);//espacio
			pdf.addCell(20, 4,"REAL",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(20, 4,"PPTO",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(18, 4,"DESV",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(20, 4,"REAL",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(20, 4,"PPTO",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(18, 4,"DESV",1,0,Align.CENTER);
			pdf.writeText(5,"\n");
			
			/******************************************************/
			pdf.addCell(20, 4,m0,1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			/******************************************************/
			pdf.addCell(20, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(20, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(20, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(60, 4);//NADA
			pdf.addCell(1,1);//espacio
			pdf.addCell(20, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(20, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(18, 4,"%",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(20, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(20, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(18, 4,"%",1,0,Align.CENTER);
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
		
		public function generarTabla4(arreglo:Array, img:DisplayObject, ano:String, titulo:String, sucursal:String, meses:int):void
		{
			pdf.setFont(new CoreFont(FontFamily.HELVETICA),6);
			
			var elMES:String = index.meses[meses];
			var m1:String='-';
			var m2:String='-';
			var m3:String='-';
			var m0:String='-';
			if(meses==1){ m3='ENE';}
			if(meses==2){ m2='ENE';m3='FEB';}
			if(meses==3){ m1='ENE';m2='FEB';m3='MAR';}
			if(meses==4){ m0='ENE';m1='FEB';m2='MAR';m3='ABR';}
			if(meses==5){ m0='ENE-FEB';m1='MAR';m2='ABR';m3='MAY';}
			if(meses==6){ m0='ENE-MAR';m1='ABR';m2='MAY';m3='JUN';}
			if(meses==7){ m0='ENE-ABR';m1='MAY';m2='JUN';m3='JUL';}
			if(meses==8){ m0='ENE-MAY';m1='JUN';m2='JUL';m3='AGO';}
			if(meses==9){ m0='ENE-JUN';m1='JUL';m2='AGO';m3='SEP';}
			if(meses==10){ m0='ENE-JUL';m1='AGO';m2='SEP';m3='OCT';}
			if(meses==11){ m0='ENE-AGO';m1='SEP';m2='OCT';m3='NOV';}
			
			pdf.setFontSize(15);
			pdf.addImage(img,null,0,0);
			pdf.addCell(53,1);//espacio para la imagen
			pdf.addCell(147,10,titulo_var,0,0,Align.CENTER);
			pdf.writeText(5,"\n");
			pdf.addCell(53,1);//espacio para la imagen
			pdf.addCell(147, 10,titulo,0,0,Align.CENTER);
			pdf.writeText(5,"\n");
			pdf.addCell(53,1);//espacio para la imagen
			pdf.addCell(147,10,elMES+" "+ano,0,0,Align.CENTER);
			pdf.writeText(7,"\n");
			
			pdf.setFontSize(8);
			pdf.writeText(2,"\n");
			pdf.addCell(59, 4,ano,1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(51, 14,"INGRESOS Y GASTOS",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(44, 4,elMES+" "+ano,1,0,Align.CENTER);
			pdf.addCell(2,1);//espacio
			pdf.addCell(44, 4,"ACUMULADO a "+elMES+" "+ano,1,0,Align.CENTER);
			pdf.writeText(5,"\n");
			
			pdf.addCell(14, 4,m0,1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio		
			pdf.addCell(14, 4,m1,1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(14, 4,m2,1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(14, 4,m3,1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(51, 4);//NADA
			pdf.addCell(1,1);//espacio
			pdf.addCell(14, 4,"REAL",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(14, 4,"PPTO",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(14, 4,"DESV",1,0,Align.CENTER);
			pdf.addCell(2,1);//espacio
			pdf.addCell(14, 4,"REAL",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(14, 4,"PPTO",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(14, 4,"DESV",1,0,Align.CENTER);
			pdf.writeText(5,"\n");
			
			pdf.addCell(14, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio		
			pdf.addCell(14, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(14, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(14, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(51, 4);//NADA
			pdf.addCell(1,1);//espacio
			pdf.addCell(14, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(14, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(14, 4,"%",1,0,Align.CENTER);
			pdf.addCell(2,1);//espacio
			pdf.addCell(14, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(14, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(14, 4,"%",1,0,Align.CENTER);
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
			pdf.addCell(59, 4,ano,1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(51, 14,"INGRESOS Y GASTOS",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(44, 4,elMES+" "+ano,1,0,Align.CENTER);
			pdf.addCell(2,1);//espacio
			pdf.addCell(44, 4,"ACUMULADO a "+elMES+" "+ano,1,0,Align.CENTER);
			pdf.writeText(5,"\n");
			
			pdf.addCell(14, 4,m0,1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio		
			pdf.addCell(14, 4,m1,1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(14, 4,m2,1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(14, 4,m3,1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(51, 4);//NADA
			pdf.addCell(1,1);//espacio
			pdf.addCell(14, 4,"REAL",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(14, 4,"");//En cualquier caso diferente del general, la desvicion no es una factor, por tanto no se coloca
			pdf.addCell(1,1);//espacio
			pdf.addCell(14, 4,"PPTO",1,0,Align.CENTER);
			pdf.addCell(2,1);//espacio
			pdf.addCell(14, 4,"REAL",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(14, 4,"");//En cualquier caso diferente del general, la desvicion no es una factor, por tanto no se coloca
			pdf.addCell(1,1);//espacio
			pdf.addCell(14, 4,"PPTO",1,0,Align.CENTER);
			pdf.writeText(5,"\n");
			
			pdf.addCell(14, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio		
			pdf.addCell(14, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(14, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(14, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(51, 4);//NADA
			pdf.addCell(1,1);//espacio
			pdf.addCell(14, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(14, 4,"");//En cualquier caso diferente del general, la desvicion no es una factor, por tanto no se coloca
			pdf.addCell(1,1);//espacio
			pdf.addCell(14, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(2,1);//espacio
			pdf.addCell(14, 4,"M$",1,0,Align.CENTER);
			pdf.addCell(1,1);//espacio
			pdf.addCell(14, 4,"");//En cualquier caso diferente del general, la desvicion no es una factor, por tanto no se coloca
			pdf.addCell(1,1);//espacio
			pdf.addCell(14, 4,"M$",1,0,Align.CENTER);
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
		
		private function getVentas(arreglo:Array,meses:int):Array
		{
			var i:int=ITEMS.VENTASNETAS;
			var s:Array = [	0,//ventas del mes anterior-anterior-anterior al consultado
							0,//ventas del mes anterior-anterior al consultado
							0,//ventas del mes anterior al consultado
							0,//ventas del mes consutado
							0,//mes
							0,//real
							0,//ppto
							0];//Acumulado no visible
			
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
			
			var salida:Number = 0;
			if(meses>3) salida += Number(removeFormatting(arreglo[i].ENE));
			if(meses>4) salida += Number(removeFormatting(arreglo[i].FEB));
			if(meses>5) salida += Number(removeFormatting(arreglo[i].MAR));
			if(meses>6) salida += Number(removeFormatting(arreglo[i].ABR));
			if(meses>7) salida += Number(removeFormatting(arreglo[i].MAY));
			if(meses>8) salida += Number(removeFormatting(arreglo[i].JUN));
			if(meses>9) salida += Number(removeFormatting(arreglo[i].JUL));
			if(meses>10) salida += Number(removeFormatting(arreglo[i].AGO));
			
			s[4] = arreglo[i].MES;
			s[5] = arreglo[i].REAL;
			s[6] = arreglo[i].PPTO;
			s[7] = salida;
			
			return s;
		}
		private function getAcumulado(arreglo:Array,meses:int,index:int):Number
		{
			var salida:Number = 0;
			if(meses>3) salida += Number(removeFormatting(arreglo[index].ENE));
			if(meses>4) salida += Number(removeFormatting(arreglo[index].FEB));
			if(meses>5) salida += Number(removeFormatting(arreglo[index].MAR));
			if(meses>6) salida += Number(removeFormatting(arreglo[index].ABR));
			if(meses>7) salida += Number(removeFormatting(arreglo[index].MAY));
			if(meses>8) salida += Number(removeFormatting(arreglo[index].JUN));
			if(meses>9) salida += Number(removeFormatting(arreglo[index].JUL));
			if(meses>10) salida += Number(removeFormatting(arreglo[index].AGO));
			return salida;
		}
		private function addTotalGastosAdministrativosYVentas(nombre:String,arreglo:Array,meses:int,escala:int=1,porcentaje:Boolean=false):void
		{
			var m0:Number = getAcumulado(arreglo,meses,ITEMS.TOTALGASTOSADMINISTRATIVOS);
			var m0String:String = '-';
				
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
			
				/******************************************************/
				if(meses>3) m0String = parentesis(formato.format(m0));
				
				pdf.addCell(20,0.3,m0String,0,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				/******************************************************/
				pdf.addCell(20,0.3,m1,0,0,Align.RIGHT);
				pdf.addCell(20,0.3,m2,0,0,Align.RIGHT);
				pdf.addCell(20,0.3,m3,0,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(60,0.3,"   "+nombre,0,0,Align.LEFT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(20,0.3,r,0,0,Align.RIGHT);
				pdf.addCell(20,0.3,p,0,0,Align.RIGHT);
				pdf.addCell(18,0.3,d,0,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(20,0.3,ra,0,0,Align.RIGHT);
				pdf.addCell(20,0.3,pa,0,0,Align.RIGHT);
				pdf.addCell(18,0.3,da,0,0,Align.RIGHT);
				pdf.writeText(3,"\n");
			}
			else
			{
				if(meses>3) m0String = parentesis(formato.format(m0));
				
				if(!porcentaje)
				{
					pdf.setFont(new CoreFont(FontFamily.HELVETICA_BOLD),6);
					
					pdf.addCell(14,0.3,m0String,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,m1,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,m2,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,m3,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(51,0.3,"   "+nombre,0,0,Align.LEFT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,r,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,p,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,d,0,0,Align.RIGHT);
					pdf.addCell(2,1);//espacio
					pdf.addCell(14,0.3,ra,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,pa,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,da,0,0,Align.RIGHT);
					pdf.writeText(2,"\n");
					pdf.setFontSize(8);
				}
				else
				{
					pdf.setFont(new CoreFont(FontFamily.HELVETICA_BOLD),6);
					var ventasNetas:Array = getVentas(arreglo,meses);
					
					pdf.addCell(14,0.3,aPorcentaje(m0String,ventasNetas[7]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,aPorcentaje(m1,ventasNetas[0]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,aPorcentaje(m2,ventasNetas[1]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,aPorcentaje(m3,ventasNetas[2]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(51,0.3,"   "+nombre,0,0,Align.LEFT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,aPorcentaje(r ,ventasNetas[3]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,"");//En cualquier caso diferente del general, la desvicion no es una factor, por tanto no se coloca
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,aPorcentaje(p ,ventasNetas[4]),0,0,Align.RIGHT);
					pdf.addCell(2,1);//espacio
					pdf.addCell(14,0.3,aPorcentaje(ra,ventasNetas[5]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,"");//En cualquier caso diferente del general, la desvicion no es una factor, por tanto no se coloca
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,aPorcentaje(pa,ventasNetas[6]),0,0,Align.RIGHT);
					pdf.writeText(2,"\n");
					pdf.setFontSize(8);
				}
			}
			
			pdf.setFont(new CoreFont(FontFamily.HELVETICA),8);
		}
		private function addTotalMargenOperacionalBruto(nombre:String,arreglo:Array,meses:int,escala:int=1,porcentaje:Boolean=false):void
		{
			var m0:Number = getAcumulado(arreglo,meses,ITEMS.MARGENCOMERCIAL);
			var m0String:String = '-';
				
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
				
				/******************************************************/
				if(meses>3) m0String = parentesis(formato.format(m0));
				
				pdf.addCell(20,0.3,m0String,0,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				/******************************************************/
				pdf.addCell(20,0.3,m1,0,0,Align.RIGHT);
				pdf.addCell(20,0.3,m2,0,0,Align.RIGHT);
				pdf.addCell(20,0.3,m3,0,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(60,0.3,"   "+nombre,0,0,Align.LEFT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(20,0.3,r,0,0,Align.RIGHT);
				pdf.addCell(20,0.3,p,0,0,Align.RIGHT);
				pdf.addCell(18,0.3,d,0,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(20,0.3,ra,0,0,Align.RIGHT);
				pdf.addCell(20,0.3,pa,0,0,Align.RIGHT);
				pdf.addCell(18,0.3,da,0,0,Align.RIGHT);
				pdf.writeText(3,"\n");
			}
			else
			{
				if(meses>3) m0String = parentesis(formato.format(m0));
				
				if(!porcentaje)
				{
					pdf.setFont(new CoreFont(FontFamily.HELVETICA_BOLD),6);
					
					pdf.addCell(14,0.3,m0String,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio		
					pdf.addCell(14,0.3,m1,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,m2,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,m3,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(51,0.3,"   "+nombre,0,0,Align.LEFT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,r,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,p,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,d,0,0,Align.RIGHT);
					pdf.addCell(2,1);//espacio
					pdf.addCell(14,0.3,ra,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,pa,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,da,0,0,Align.RIGHT);
					pdf.writeText(2,"\n");
				}
				else
				{
					pdf.setFont(new CoreFont(FontFamily.HELVETICA_BOLD),6);
					var ventasNetas:Array = getVentas(arreglo,meses);
					
					pdf.addCell(14,0.3,aPorcentaje(m0String,ventasNetas[7]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio		
					pdf.addCell(14,0.3,aPorcentaje(m1,ventasNetas[0]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,aPorcentaje(m2,ventasNetas[1]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,aPorcentaje(m3,ventasNetas[2]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(51,0.3,"   "+nombre,0,0,Align.LEFT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,aPorcentaje(r ,ventasNetas[3]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,"");//En cualquier caso diferente del general, la desvicion no es una factor, por tanto no se coloca
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,aPorcentaje(p ,ventasNetas[4]),0,0,Align.RIGHT);
					pdf.addCell(2,1);//espacio
					pdf.addCell(14,0.3,aPorcentaje(ra,ventasNetas[5]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,"");//En cualquier caso diferente del general, la desvicion no es una factor, por tanto no se coloca
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,aPorcentaje(pa,ventasNetas[6]),0,0,Align.RIGHT);
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
				/**************************************************************************/
				pdf.addCell(20,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				/**************************************************************************/		
				pdf.addCell(20,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(20,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(20,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(60,0.3,"   "+texto,0,0,Align.LEFT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(20,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(20,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(18,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(20,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(20,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(18,0.3,"",0,0,Align.RIGHT);
				pdf.writeText(3,"\n");
			}
			else
			{
				pdf.setFont(new CoreFont(FontFamily.HELVETICA_BOLD),6);
				
				pdf.addCell(14,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(14,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(14,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(14,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(51,0.3,"   "+texto,0,0,Align.LEFT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(14,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(14,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(14,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(2,1);//espacio
				pdf.addCell(14,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(14,0.3,"",0,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(14,0.3,"",0,0,Align.RIGHT);
				pdf.writeText(2,"\n");
			}
			
			pdf.setFont(new CoreFont(FontFamily.HELVETICA),8);
		}
		private function addTotal(arreglo:Array,i:int,meses:int,escala:int=1,porcentaje:Boolean=false):void
		{
			var m0:Number = getAcumulado(arreglo,meses,i);
			var m0String:String = '-';
				
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
				
				/******************************************************/
				if(meses>3) m0String = parentesis(formato.format(m0));
				
				pdf.addCell(20,0.3,m0String,0,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				/******************************************************/
				pdf.addCell(20,0.3,m1,0,0,Align.RIGHT);
				pdf.addCell(20,0.3,m2,0,0,Align.RIGHT);
				pdf.addCell(20,0.3,m3,0,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(60,0.3,"   "+arreglo[i].nombre,0,0,Align.LEFT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(20,0.3,r,0,0,Align.RIGHT);
				pdf.addCell(20,0.3,p,0,0,Align.RIGHT);
				pdf.addCell(18,0.3,d,0,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(20,0.3,ra,0,0,Align.RIGHT);
				pdf.addCell(20,0.3,pa,0,0,Align.RIGHT);
				pdf.addCell(18,0.3,da,0,0,Align.RIGHT);
				pdf.writeText(3,"\n");
			}
			else
			{
				if(meses>3) m0String = parentesis(formato.format(m0));
				
				if(!porcentaje)
				{
					pdf.setFont(new CoreFont(FontFamily.HELVETICA_BOLD),6);
				
					pdf.addCell(14,0.3,m0String,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio	
					pdf.addCell(14,0.3,m1,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,m2,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,m3,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(51,0.3,"   "+arreglo[i].nombre,0,0,Align.LEFT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,r,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,p,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,d,0,0,Align.RIGHT);
					pdf.addCell(2,1);//espacio
					pdf.addCell(14,0.3,ra,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,pa,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,da,0,0,Align.RIGHT);
					pdf.writeText(2,"\n");
				}
				else
				{
					pdf.setFont(new CoreFont(FontFamily.HELVETICA_BOLD),6);
					var ventasNetas:Array = getVentas(arreglo,meses);
					pdf.addCell(14,0.3,aPorcentaje(m0String,ventasNetas[7]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio		
					pdf.addCell(14,0.3,aPorcentaje(m1,ventasNetas[0]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,aPorcentaje(m2,ventasNetas[1]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,aPorcentaje(m3,ventasNetas[2]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(51,0.3,"   "+arreglo[i].nombre,0,0,Align.LEFT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,aPorcentaje(r, ventasNetas[3]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,"");//En cualquier caso diferente del general, la desvicion no es una factor, por tanto no se coloca
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,aPorcentaje(p, ventasNetas[4]),0,0,Align.RIGHT);
					pdf.addCell(2,1);//espacio
					pdf.addCell(14,0.3,aPorcentaje(ra,ventasNetas[5]),0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,"");//En cualquier caso diferente del general, la desvicion no es una factor, por tanto no se coloca
					pdf.addCell(1,1);//espacio
					pdf.addCell(14,0.3,aPorcentaje(pa,ventasNetas[6]),0,0,Align.RIGHT);
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
			var m0:Number = 0;
			var m0String:String = '-';
				
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
				m0 = getAcumulado(arreglo,meses,i);
				
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
					/******************************************************/
					if(meses>3) m0String = parentesis(formato.format(m0));
					
					pdf.addCell(20,0.3,m0String,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					/******************************************************/
					pdf.addCell(20,0.3,m1,0,0,Align.RIGHT);
					pdf.addCell(20,0.3,m2,0,0,Align.RIGHT);
					pdf.addCell(20,0.3,m3,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(60,0.3,"   "+arreglo[i].nombre,0,0,Align.LEFT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(20,0.3,r,0,0,Align.RIGHT);
					pdf.addCell(20,0.3,p,0,0,Align.RIGHT);
					pdf.addCell(18,0.3,d,0,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(20,0.3,ra,0,0,Align.RIGHT);
					pdf.addCell(20,0.3,pa,0,0,Align.RIGHT);
					pdf.addCell(18,0.3,da,0,0,Align.RIGHT);
					pdf.writeText(3,"\n");
				}
				else
				{
					if(meses>3) m0String = parentesis(formato.format(m0));
					
					if(!porcentaje)
					{
						pdf.setFont(new CoreFont(FontFamily.HELVETICA),6);
						
						pdf.addCell(14,0.3,m0String,0,0,Align.RIGHT);
						pdf.addCell(1,1);//espacio
						pdf.addCell(14,0.3,m1,0,0,Align.RIGHT);
						pdf.addCell(1,1);//espacio
						pdf.addCell(14,0.3,m2,0,0,Align.RIGHT);
						pdf.addCell(1,1);//espacio
						pdf.addCell(14,0.3,m3,0,0,Align.RIGHT);
						pdf.addCell(1,1);//espacio
						pdf.addCell(51,0.3,"   "+arreglo[i].nombre,0,0,Align.LEFT);
						pdf.addCell(1,1);//espacio
						pdf.addCell(14,0.3,r,0,0,Align.RIGHT);
						pdf.addCell(1,1);//espacio
						pdf.addCell(14,0.3,p,0,0,Align.RIGHT);
						pdf.addCell(1,1);//espacio
						pdf.addCell(14,0.3,d,0,0,Align.RIGHT);//En cualquier caso diferente del general, la desvicion no es una factor, por tanto no se coloca
						pdf.addCell(2,1);//espacio
						pdf.addCell(14,0.3,ra,0,0,Align.RIGHT);
						pdf.addCell(1,1);//espacio
						pdf.addCell(14,0.3,pa,0,0,Align.RIGHT);
						pdf.addCell(1,1);//espacio
						pdf.addCell(14,0.3,da,0,0,Align.RIGHT);//En cualquier caso diferente del general, la desvicion no es una factor, por tanto no se coloca
						pdf.writeText(2,"\n");
					}
					else
					{
						pdf.setFont(new CoreFont(FontFamily.HELVETICA),6);
						var ventasNetas:Array = getVentas(arreglo,meses);
						
						pdf.addCell(14,0.3,aPorcentaje(m0String,ventasNetas[7]),0,0,Align.RIGHT);
						pdf.addCell(1,1);//espacio
						pdf.addCell(14,0.3,aPorcentaje(m1,ventasNetas[0]),0,0,Align.RIGHT);
						pdf.addCell(1,1);//espacio
						pdf.addCell(14,0.3,aPorcentaje(m2,ventasNetas[1]),0,0,Align.RIGHT);
						pdf.addCell(1,1);//espacio
						pdf.addCell(14,0.3,aPorcentaje(m3,ventasNetas[2]),0,0,Align.RIGHT);
						pdf.addCell(1,1);//espacio
						pdf.addCell(51,0.3,"   "+arreglo[i].nombre,0,0,Align.LEFT);
						pdf.addCell(1,1);//espacio
						pdf.addCell(14,0.3,aPorcentaje(r,ventasNetas[3]),0,0,Align.RIGHT);
						pdf.addCell(1,1);//espacio
						pdf.addCell(14,0.3,"",0);//En cualquier caso diferente del general, la desvicion no es una factor, por tanto no se coloca
						pdf.addCell(1,1);//espacio
						pdf.addCell(14,0.3,aPorcentaje(p,ventasNetas[4]),0,0,Align.RIGHT);
						pdf.addCell(2,1);//espacio
						pdf.addCell(14,0.3,aPorcentaje(ra,ventasNetas[5]),0,0,Align.RIGHT);
						pdf.addCell(1,1);//espacio
						pdf.addCell(14,0.3,"",0);//En cualquier caso diferente del general, la desvicion no es una factor, por tanto no se coloca
						pdf.addCell(1,1);//espacio
						pdf.addCell(14,0.3,aPorcentaje(pa,ventasNetas[6]),0,0,Align.RIGHT);
						pdf.writeText(2,"\n");
					}
				}
				pdf.setFont(new CoreFont(FontFamily.HELVETICA),8);
			}
		}
		private function aPorcentaje(m:String,venta:String):String
		{
			if(m!="-")
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
			else
			{
				return m;
			}
		}
		private function addLineaTotal(lineas:int=1,escala:int=1,porcentaje:Boolean=false):void
		{
			if(lineas==2)
			{
				if(escala==1)
				{
					pdf.addCell(83,0.3,"",1,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(60,0.3,"",0,0,Align.LEFT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(60,0.3,"",1,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(60,0.3,"",1,0,Align.RIGHT);
					pdf.writeText(2,"\n");
				}
				else
				{
					pdf.setFont(new CoreFont(FontFamily.HELVETICA),6);
			
					pdf.addCell(58,0.3,"",1,0,Align.RIGHT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(51,0.3,"",0,0,Align.LEFT);
					pdf.addCell(1,1);//espacio
					pdf.addCell(44,0.3,"",1,0,Align.RIGHT);
					pdf.addCell(2,1);//espacio
					pdf.addCell(44,0.3,"",1,0,Align.RIGHT);
					pdf.writeText(1,"\n");
				}
			}
			if(escala==1)
			{
				pdf.addCell(83,0.3,"",1,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(60,0.3,"",0,0,Align.LEFT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(60,0.3,"",1,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(60,0.3,"",1,0,Align.RIGHT);
				pdf.writeText(3,"\n");
			}
			else
			{
				pdf.setFont(new CoreFont(FontFamily.HELVETICA),6);
			
				pdf.addCell(58,0.3,"",1,0,Align.RIGHT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(51,0.3,"",0,0,Align.LEFT);
				pdf.addCell(1,1);//espacio
				pdf.addCell(44,0.3,"",1,0,Align.RIGHT);
				pdf.addCell(2,1);//espacio
				pdf.addCell(44,0.3,"",1,0,Align.RIGHT);
				pdf.writeText(2,"\n");
			}
			pdf.setFont(new CoreFont(FontFamily.HELVETICA),8);
			
		}

	}
}