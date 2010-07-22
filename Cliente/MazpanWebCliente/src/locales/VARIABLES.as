package locales
{
	public class VARIABLES
	{
		public static const PETROLEO:String = "Petroleo";
		public static const LUZ:String = "Luz";
		public static const GAS:String = "Gas";
		
		public static const LITROS:String = "Litros";
		public static const KILOS:String = "Kilos";
		
		public static const TIPOSGASTOS:Array  = [PETROLEO,LUZ,GAS]
		
		public function VARIABLES()
		{
		}

		public function getTiposGastos():Array
		{
			var G1:Object = new Object;
			G1.tipo = "Petroleo";
			G1.unidad = "Litros";
			var G2:Object = new Object;
			G2.tipo = "Gas";
			G2.unidad = "Kilos";
			var G3:Object = new Object;
			G3.tipo = "Luz";
			G3.unidad = "kW";
			
			var salida:Array = new Array;
			 
			salida.push(G1);
			salida.push(G2);
			salida.push(G3);
			
			return salida;
		}
	}
}