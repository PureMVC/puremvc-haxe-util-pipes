/*
 PureMVC haXe/MultiCore Utility – Pipes Port by Marco Secchi <marco.secchi@puremvc.org>
 Copyright (c) 2008 Cliff Hall<cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.haxe.multicore.utilities.pipes.plumbing;

import org.puremvc.haxe.multicore.utilities.pipes.interfaces.IPipeFitting;
import org.puremvc.haxe.multicore.utilities.pipes.interfaces.IPipeMessage;
import org.puremvc.haxe.multicore.utilities.pipes.messages.FilterControlMessage;
import org.puremvc.haxe.multicore.utilities.pipes.messages.Message;
	
/**
 * Pipe Filter.
 *
 * <p>Filters may modify the contents of messages before writing them to 
 * their output pipe fitting. They may also have their parameters and
 * filter function passed to them by control message, as well as having
 * their Bypass/Filter operation mode toggled via control message.</p>  
 */ 
class Filter extends Pipe
{
		
	/**
	 * Constructor.
	 *
	 * <p>Optionally connect the output and set the parameters.</P>
	 */
	public function new( name: String, ?output: IPipeFitting = null, ?filter: IPipeMessage -> Dynamic -> Void = null, ?params: Dynamic = null ) 
	{
		super( output );
		this.name = name;
		mode = FilterControlMessage.FILTER;
		if( filter == null )
			filter = function( message: IPipeMessage, params: Dynamic ): Void { return; };
		if( params == null )
			params = {};
		setFilter( filter );
		setParams( params );
	}

	/**
	 * Handle the incoming message.
	 *
	 * <p>If message type is normal, filter the message (unless in BYPASS mode)
	 * and write the result to the output pipe fitting if the filter 
	 * operation is successful.</p>
	 * 
	 * <p>The FilterControlMessage.SET_PARAMS message type tells the Filter
	 * that the message class is FilterControlMessage, which it 
	 * casts the message to in order to retrieve the filter parameters
	 * object if the message is addressed to this filter.</p> 
	 * 
	 * <p>The FilterControlMessage.SET_FILTER message type tells the Filter
	 * that the message class is FilterControlMessage, which it 
	 * casts the message to in order to retrieve the filter function.</p>
	 * 
	 * <p>The FilterControlMessage.BYPASS message type tells the Filter
	 * that it should go into Bypass mode operation, passing all normal
	 * messages through unfiltered.</p>
	 * 
	 * <p>The FilterControlMessage.FILTER message type tells the Filter
	 * that it should go into Filtering mode operation, filtering all
	 * normal normal messages before writing out. This is the default
	 * mode of operation and so this message type need only be sent to
	 * cancel a previous BYPASS message.</p>
	 * 
	 * <p>The Filter only acts on the control message if it is targeted 
	 * to this named filter instance. Otherwise it writes through to the
	 * output.</p>
	 */
	override public function write( message: IPipeMessage ): Bool
	{
		var outputMessage: IPipeMessage = null;
		var success: Bool = true;
		// Filter normal messages
		switch ( message.getType() )
		{
			case Message.NORMAL: 	
				try
				{
					if ( mode == FilterControlMessage.FILTER )
					{
						outputMessage = applyFilter( message );
					}else
					{
						outputMessage = message;
					}
					success = output.write( outputMessage );
				}catch ( e: Dynamic )
				{
					success = false;
				}
				
			// Accept parameters from control message 
			case FilterControlMessage.SET_PARAMS:
				if (isTarget(message) )
				{
					setParams( cast( message, FilterControlMessage ).getParams() );
				}else
				{
					success = output.write( outputMessage );
				}
 			// Accept filter function from control message 
			case FilterControlMessage.SET_FILTER:
				if ( isTarget( message ) )
				{
					setFilter( cast( message, FilterControlMessage ).getFilter() );
				}else
				{
					success = output.write( outputMessage );
				}
			// Toggle between Filter or Bypass operational modes
			case FilterControlMessage.BYPASS:
				if ( isTarget( message ) )
				{
					mode = cast( message, FilterControlMessage ).getType();
				}else
				{
					success = output.write( outputMessage );
				}
			case FilterControlMessage.FILTER:
				if ( isTarget( message ) )
				{
					mode = cast( message, FilterControlMessage ).getType();
				}else
				{
					success = output.write( outputMessage );
				}
			
			// Write control messages for other fittings through
			default:	
				success = output.write( outputMessage );
		}
		return success;			
	}
	
	/**
	 * Is the message directed at this filter instance?
	 */
	private function isTarget( m: IPipeMessage ): Bool
	{
		var res: Bool = cast( m, FilterControlMessage ).getName() == this.name;
		return res;
	}
	
	/**
	 * Set the Filter parameters.
	 *
	 * <p>This can be an object can contain whatever arbitrary 
	 * properties and values your filter method requires to
	 * operate.</p>
	 */
	public function setParams( params: Dynamic ): Void
	{
		this.params = params;
	}

	/**
	 * Set the Filter function.
	 *
	 * <p>It must accept two arguments; an IPipeMessage, 
	 * and a parameter Object, which can contain whatever 
	 * arbitrary properties and values your filter method 
	 * requires.</p>
	 */
	public function setFilter( filter: IPipeMessage -> Dynamic -> Void ): Void
	{
		this.filter = filter;
	}
		
	/**
	 * Filter the message.
	 */
	private function applyFilter( message: IPipeMessage ): IPipeMessage
	{
		filter( message, params );
		return message;
	}
	
	private var mode: String;
	private var filter: IPipeMessage -> Dynamic -> Void;
	private var params: Dynamic;
	private var name: String;

}