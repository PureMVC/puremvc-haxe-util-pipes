/*
 PureMVC haXe/MultiCore Utility – Pipes Port by Marco Secchi <marco.secchi@puremvc.org>
 Copyright (c) 2008 Cliff Hall<cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.haxe.multicore.utilities.pipes.plumbing;

import org.puremvc.haxe.multicore.utilities.pipes.interfaces.IPipeFitting;
	
/** 
 * Merging Pipe Tee.
 *
 * <p>Writes the messages from multiple input pipelines into
 * a single output pipe fitting.</p>
 */
class TeeMerge extends Pipe
{
		
	/**
	 * Constructor.
	 *
	 * <p>Create the TeeMerge and the two optional constructor inputs.
	 * This is the most common configuration, though you can connect
	 * as many inputs as necessary by calling [connectInput]
	 * repeatedly.</p>
	 *
	 * <p>Connect the single output fitting normally by calling the 
	 * [connect] method, as you would with any other IPipeFitting.</p>
	 */
	public function new( ?input1: IPipeFitting = null, ?input2: IPipeFitting = null ) 
	{
		super();
		if ( input1 != null ) connectInput( input1 );
		if ( input2 != null ) connectInput( input2 );
	}

	/** 
	 * Connect an input IPipeFitting.
	 *
	 * <p>NOTE: You can connect as many inputs as you want
	 * by calling this method repeatedly.</p>
	 */
	public function connectInput( input: IPipeFitting ): Bool
	{
		return input.connect( this );
	}
		
}