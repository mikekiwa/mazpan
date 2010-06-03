package estadoResultado
{
	import mx.collections.ArrayCollection;
	import mx.controls.DataGrid;
	import mx.formatters.NumberFormatter;
	import flash.display.Sprite;
	
	public class myDataGrid extends DataGrid
	{
		
		override protected function drawRowBackground(s:Sprite,rowIndex:int,y:Number,height:Number,color:uint,dataIndex:int):void  
		{  
			
			var dp:ArrayCollection = dataProvider as ArrayCollection;
			var item:Object;
			var formato:NumberFormatter = new NumberFormatter();
			formato.precision=0;
			formato.useThousandsSeparator=true;
			formato.thousandsSeparatorFrom=".";
			formato.thousandsSeparatorTo=".";
			formato.decimalSeparatorFrom=",";
			formato.decimalSeparatorTo=",";
			
			if( dataIndex < dp.length ) item = dp.getItemAt(dataIndex);
			if( item != null )
			{
			 	if(dataIndex==ITEMS.VENTASNETAS || dataIndex==ITEMS.COSTOSTOTALES || dataIndex==ITEMS.MARGENCOMERCIAL || dataIndex==ITEMS.TOTALGASTOSADMINISTRATIVOS || dataIndex==ITEMS.MARGENOPERACIONAL || dataIndex==ITEMS.RESULTADOANTESDEIMPUESTO || dataIndex==ITEMS.RESULTADO) color = 0xAAAAAA;
			 	
			 	item.ENE = formato.format(item.ENE);
			 	item.FEB = formato.format(item.FEB);
			 	item.MAR = formato.format(item.MAR);
			 	item.ABR = formato.format(item.ABR);
			 	item.MAY = formato.format(item.MAY);
			 	item.JUN = formato.format(item.JUN);
			 	item.JUL = formato.format(item.JUL);
			 	item.AGO = formato.format(item.AGO);
			 	item.SEP = formato.format(item.SEP);
			 	item.OCT = formato.format(item.OCT);
			 	item.NOV = formato.format(item.NOV);
			 	item.DIC = formato.format(item.DIC);
			 	item.MES = formato.format(item.MES);
			 	item.PPTO = formato.format(item.PPTO);
			 	item.REAL = formato.format(item.REAL);
			 	//item.DESV = formato.format(item.DESV);
			}
			super.drawRowBackground(s,rowIndex,y,height,color,dataIndex);  
		}
	}
}