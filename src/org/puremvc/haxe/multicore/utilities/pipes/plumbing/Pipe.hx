/*
 PureMVC haXe/MultiCore Utility – Pipes Port by Marco Secchi <marco.secchi@puremvc.org>
 Copyright (c) 2008 Cliff Hall<cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.haxe.multicore.utilities.pipes.plumbing;

import org.puremvc.haxe.multicore.utilities.pipes.interfaces.IPipeFitting;
import org.puremvc.haxe.multicore.utilities.pipes.interfaces.IPipeMessage;

/**
 * Pipe.
 *
 * <p>This is the most basic [IPipeFitting],
 * simply allowing the connection of an output
 * fitting and writing of a message to that output.</p>
 */	
class Pipe implements IPipeFitting
{
	private var output: IPipeFitting;

	// Constructor
	public function new( ?output: IPipeFitting = null )
	{
		if ( output != null ) connect( output );
	}

	/**
	 * Connect another PipeFitting to the output.
	 * 
	 * <p>PipeFittings connect to and write to other 
	 * PipeFittings in a one-way, syncrhonous chain.</p>
	 */
	public function connect( output: IPipeFitting ): Bool
	{
		var success: Bool = false;
		if ( this.output == null )
		{
			this.output = output;
			success = true;
		}
		return success;
	}
		
	/**
	 * Disconnect the Pipe Fitting connected to the output.
	 *
	 * <p>This disconnects the output fitting, returning a 
	 * reference to it. If you were splicing another fitting
	 * into a pipeline, you need to keep (at least briefly) 
	 * a reference to both sides of the pipeline in order to 
	 * connect them to the input and output of whatever 
	 * fiting that you're splicing in.</p>
	 */
	public function disconnect(): IPipeFitting
	{
		var disconnectedFitting: IPipeFitting = this.output;
		this.output = null;
		return disconnectedFitting;
	}
		
	/**
	 * Write the message to the connected output.
	 */
	public function write( message: IPipeMessage ): Bool
	{
		return output.write( message );
	}
	
}