/*
 PureMVC haXe/MultiCore Utility – Pipes Port by Marco Secchi <marco.secchi@puremvc.org>
 Copyright (c) 2008 Cliff Hall<cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.haxe.multicore.utilities.pipes.plumbing;

import org.puremvc.haxe.multicore.utilities.pipes.interfaces.IPipeFitting;
import org.puremvc.haxe.multicore.utilities.pipes.interfaces.IPipeMessage;
	
/**
 * Pipe Junction.
 * 
 * <p>Manages Pipes for a Module</p>. 
 * 
 * <p>When you register a Pipe with a Junction, it is 
 * declared as being an INPUT pipe or an OUTPUT pipe.</p> 
 * 
 * <p>You can retrieve or remove a registered Pipe by name, 
 * check to see if a Pipe with a given name exists,or if 
 * it exists AND is an INPUT or an OUTPUT Pipe.</p> 
 * 
 * <p>You can send an [IPipeMessage] on a named INPUT Pipe 
 * or add a [PipeListener] to registered INPUT Pipe.</p>
 */
class Junction
{
	/**
	 *  INPUT Pipe Type
	 */
	public static inline var INPUT: String		= 'input';

	/**
	 *  OUTPUT Pipe Type
	 */
	public static inline var OUTPUT: String		= 'output';
	
	// Constructor. 
	public function new()
	{
		inputPipes = new Array();
		outputPipes = new Array();
		pipesMap = new Hash();
		pipeTypesMap = new Hash();
	}

	/**
	 * Register a pipe with the junction.
	 *
	 * <p>Pipes are registered by unique name and type,
	 * which must be either [Junction.INPUT]
	 * or [Junction.OUTPUT].</p>
	 *
	 * <p>NOTE: You cannot have an INPUT pipe and an OUTPUT
	 * pipe registered with the same name. All pipe names
	 * must be unique regardless of type.</p>
	 */
	public function registerPipe( name: String, type: String, pipe: IPipeFitting ): Bool
	{ 
		var success: Bool = true;
		if ( !pipesMap.exists( name ) )
		{
			pipesMap.set( name, pipe );
			pipeTypesMap.set( name, type );
			switch ( type )
			{
				case INPUT:
					inputPipes.push( name );	
				case OUTPUT:
					outputPipes.push( name );
				default:	
					success = false;
			}
		}else
		{
			success = false;
		}
		return success;
	}
		
	/**
	 * Does this junction have a pipe by this name?
	 */ 
	public function hasPipe( name: String ): Bool
	{
		return pipesMap.exists( name );
	}
		
	/**
	 * Does this junction have an INPUT pipe by this name?
	 */ 
	public function hasInputPipe( name: String ): Bool
	{
		return ( hasPipe( name ) && ( pipeTypesMap.get( name ) == INPUT) );
	}

	/**
	 * Does this junction have an OUTPUT pipe by this name?
	 */ 
	public function hasOutputPipe( name: String ): Bool
	{
		return ( hasPipe( name ) && ( pipeTypesMap.get( name ) == OUTPUT) );
	}

	/**
	 * Remove the pipe with this name if it is registered.
	 *
	 * <p>NOTE: You cannot have an INPUT pipe and an OUTPUT
	 * pipe registered with the same name. All pipe names
	 * must be unique regardless of type.</p>
	 */
	public function removePipe( name: String ): Void 
	{
		if ( hasPipe( name ) ) 
		{
			var type: String = pipeTypesMap.get( name );
			var pipesList: Array<String> = null;
			switch ( type )
			{
				case INPUT:
					pipesList = inputPipes;
				case OUTPUT:
					pipesList = outputPipes;	
			}
			for ( i in 0...pipesList.length )
			{
				if ( pipesList[ i ] == name )
				{
					pipesList.splice( i, 1 );
					break;
				}
			}
			pipesMap.remove( name );
		 	pipeTypesMap.remove( name );
		}
	}

	/**
	 * Retrieve the named pipe.
	 */
	public function retrievePipe( name: String ): IPipeFitting 
	{
		return pipesMap.get( name );
	}

	/**
	 * Add a PipeListener to an INPUT pipe.
	 *
	 * <p>NOTE: there can only be one PipeListener per pipe,
	 * and the listener function must accept an IPipeMessage
	 * as its sole argument.</p> 
	 */
	public function addPipeListener( inputPipeName: String, context: Dynamic, listener: Dynamic -> Void ): Bool 
	{
		var success: Bool = false;
		if ( hasInputPipe( inputPipeName ) )
		{
			var pipe: IPipeFitting = pipesMap.get( inputPipeName );
			success = pipe.connect( new PipeListener( context, listener ) );
		} 
		return success;
	}
		
	/**
	 * Send a message on an OUTPUT pipe.
	 */
	public function sendMessage( outputPipeName: String, message: IPipeMessage ): Bool 
	{
		var success: Bool = false;
		if ( hasOutputPipe( outputPipeName ) )
		{
			var pipe: IPipeFitting = pipesMap.get( outputPipeName );
			success = pipe.write( message );
		} 
		return success;
	}

	/**
	 *  The names of the INPUT pipes
	 */
	private var inputPipes: Array<String>;
	
	/**
	 *  The names of the OUTPUT pipes
	 */
	private var outputPipes: Array<String>;
		
	/** 
	 * The map of pipe names to their pipes
	 */
	private var pipesMap: Hash<IPipeFitting>;
		
	/**
	 * The map of pipe names to their types
	 */
	private var pipeTypesMap: Hash<String>;

}
