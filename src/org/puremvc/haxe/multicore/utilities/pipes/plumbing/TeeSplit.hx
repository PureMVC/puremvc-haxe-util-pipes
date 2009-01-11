/*
 PureMVC haXe/MultiCore Utility – Pipes Port by Marco Secchi <marco.secchi@puremvc.org>
 Copyright (c) 2008 Cliff Hall<cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.haxe.multicore.utilities.pipes.plumbing;

import org.puremvc.haxe.multicore.utilities.pipes.interfaces.IPipeFitting;
import org.puremvc.haxe.multicore.utilities.pipes.interfaces.IPipeMessage;
	
/** 
 * Splitting Pipe Tee.
 *
 * <p>Writes input messages to multiple output pipe fittings.</p>
 */
class TeeSplit implements IPipeFitting
{
	private var outputs: Array<IPipeFitting>;
		
	/**
	 * Constructor.
	 *
	 * <p>Create the TeeSplit and connect the up two optional outputs.
	 * This is the most common configuration, though you can connect
	 * as many outputs as necessary by calling [connect].</p>
	 */
	public function new( ?output1: IPipeFitting = null, ?output2: IPipeFitting = null ) 
	{
		outputs = new Array();
		if ( output1 != null ) connect( output1 );
		if ( output2 != null ) connect( output2 );
	}

	/** 
	 * Connect the output IPipeFitting.
	 *
	 * <p>NOTE: You can connect as many outputs as you want
	 * by calling this method repeatedly.</p>
	 */
	public function connect( output: IPipeFitting ): Bool
	{
		outputs.push( output );
		return true;
	}
		
	/** 
	 * Disconnect the most recently connected output fitting. (LIFO)
	 *
	 * <p>To disconnect all outputs, you must call this 
	 * method repeatedly untill it returns null.</p>
	 */
	public function disconnect(): IPipeFitting 
	{
		return outputs.pop();
	}

	/**
	 * Write the message to all connected outputs.
	 *
	 * <p>Returns false if any output returns false, 
	 * but all outputs are written to regardless.</p>
	 */
	public function write( message: IPipeMessage ): Bool
	{
		var success: Bool = true;
		for ( i in 0...outputs.length )
		{
			var output: IPipeFitting = outputs[ i ];
			if ( !output.write( message ) ) success = false;
		}
		return success;			
	}
		
}