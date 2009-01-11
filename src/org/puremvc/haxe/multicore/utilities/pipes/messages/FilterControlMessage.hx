/*
 PureMVC haXe/MultiCore Utility – Pipes Port by Marco Secchi <marco.secchi@puremvc.org>
 Copyright (c) 2008 Cliff Hall<cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.haxe.multicore.utilities.pipes.messages;
	
/**
 * Filter Control Message.
 *
 * <p>A special message type for controlling the behavior of a Filter.</p>
 * 
 * <p>The [FilterControlMessage.SET_PARAMS] message type tells the Filter
 * to retrieve the filter parameters object.</p> 
 *  
 * <p>The [FilterControlMessage.SET_FILTER] message type tells the Filter
 * to retrieve the filter function.</p>
 * 
 * <p>The [FilterControlMessage.BYPASS] message type tells the Filter
 * that it should go into Bypass mode operation, passing all normal
 * messages through unfiltered.</p>
 * 
 * <p>The [FilterControlMessage.FILTER] message type tells the Filter
 * that it should go into Filtering mode operation, filtering all
 * normal normal messages before writing out. This is the default
 * mode of operation and so this message type need only be sent to
 * cancel a previous  [FilterControlMessage.BYPASS] message.</p>
 * 
 * <p>The Filter only acts on a control message if it is targeted 
 * to this named filter instance. Otherwise it writes the message
 * through to its output unchanged.</p>
 */ 
class FilterControlMessage extends Message
{
	/**
	 * Message type base URI
	 */
	private static inline var BASE :String			= Message.BASE + '/filter/';
		
	/**
	 * Set filter parameters.
	 */ 
	public static inline var SET_PARAMS: String		= BASE + 'setparams';
	
	/**
	 * Set filter function.
	 */ 
	public static inline var SET_FILTER: String		= BASE + 'setfilter';

	/**
	 * Toggle to filter bypass mode.
	 */
	public static inline var BYPASS: String			= BASE + 'bypass';
		
	/**
	 * Toggle to filtering mode. (default behavior).
	 */
	public static inline var FILTER: String			= BASE + 'filter';

	// Constructor
	public function new( type: String, name: String, ?filter: Dynamic -> Dynamic -> Void = null, ?params: Dynamic = null )
	{
		super( type );
		setName( name );
		setFilter( filter );
		setParams( params );
	}

	/**
	 * Set the target filter name.
	 */
	public function setName( name: String ): Void
	{
		this.name = name;
	}
		
	/**
	 * Get the target filter name.
	 */
	public function getName(): String
	{
		return this.name;
	}
		
	/**
	 * Set the filter function.
	 */
	public function setFilter( filter: Dynamic -> Dynamic -> Void ): Void
	{
		this.filter = filter;
	}
		
	/**
	 * Get the filter function.
	 */
	public function getFilter(): Dynamic -> Dynamic -> Void
	{
		return this.filter;
	}
		
	/**
	 * Set the parameters object.
	 */
	public function setParams( params: Dynamic ): Void
	{
		this.params = params;
	}
		
	/**
	 * Get the parameters object.
	 */
	public function getParams(): Dynamic
	{
		return this.params;
	}
		
	private var params: Dynamic;
	private var filter: Dynamic -> Dynamic -> Void;
	private var name: String;
}