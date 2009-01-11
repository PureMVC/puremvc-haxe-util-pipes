/*
 PureMVC haXe/MultiCore Utility – Pipes Port by Marco Secchi <marco.secchi@puremvc.org>
 Copyright (c) 2008 Cliff Hall<cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.haxe.multicore.utilities.pipes.plumbing;

import org.puremvc.haxe.multicore.utilities.pipes.interfaces.IPipeFitting;
import org.puremvc.haxe.multicore.utilities.pipes.interfaces.IPipeMessage;
		
/**
 * Pipe Listener.
 *
 * <p>Allows a class that does not implement [IPipeFitting] to
 * be the final recipient of the messages in a pipeline.</p>
 */ 
class PipeListener implements IPipeFitting
{
	private var context: Dynamic;
	private var listener: Dynamic -> Void;
	
	// Constructor
	public function new( context: Dynamic, listener: Dynamic -> Void )
	{
		this.context = context;
		this.listener = listener;
	}
		
	/**
	 *  Can't connect anything beyond this.
	 */
	public function connect( output: IPipeFitting ): Bool
	{
		return false;
	}
	
	/**
	 *  Can't disconnect since you can't connect, either.
	 */
	public function disconnect(): IPipeFitting
	{
		return null;
	}

	// Write the message to the listener
	public function write( message: IPipeMessage ): Bool
	{
		listener( message );
		return true;
	}
}