package eventos
{
	import flash.events.Event;
	public class ComplexEvent extends Event
	{
		public static const MENU_CLICK:String="complexClick";
		private var _stateDestination:String="";
		private var _stateOrigin:String="";
		private var _objeto:Object=null;
		
		/**
		 * Constructor de la clase evento personalizado
		 * type: tipo del Evento
		 * _stateDestination: 
		 * _stateOrigin: el estado desde donde se prujo el envento
		 * _objeto: Los parametros que se requieran pasar encapsulado en un objeto
		 */ 
		public function ComplexEvent(type:String,_stateDestination:String,_stateOrigin:String,_objeto:Object)
		{
			super(type);
			this._stateDestination=_stateDestination;
			this._stateOrigin = _stateOrigin;
			this._objeto = _objeto;
		}
		
		/**
		 * Retorna el estado al cual queremos ir, el estado de destino
		 */
		public function get stateDestination():String
		{
			return _stateDestination;
		}
		
		/**
		 * Retorna el estado al cual pertenecemos, el estado de origen
		 */
		public function get stateOrigin():String
		{
			return _stateOrigin;
		}
		
		/**
		 * Retorna el objeto que contiene toda la informacion que queremos enviar
		 */
		public function get objeto():Object
		{
			return _objeto;
		}
	}
}